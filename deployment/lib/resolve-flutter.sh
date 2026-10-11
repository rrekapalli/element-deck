# shellcheck shell=bash
# Resolve Flutter on Linux, macOS, and WSL (including Windows Flutter on /mnt/c/).

is_wsl() {
    grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null
}

# WSL can mount Windows binaries without being able to execute them (interop disabled).
wsl_interop_available() {
    is_wsl || return 1
    local win_exe
    for win_exe in cmd.exe powershell.exe; do
        command -v "$win_exe" >/dev/null 2>&1 || continue
        if [[ "$win_exe" == cmd.exe ]]; then
            "$win_exe" /c exit 0 >/dev/null 2>&1 && return 0
        else
            "$win_exe" -NoProfile -Command "exit 0" >/dev/null 2>&1 && return 0
        fi
    done
    return 1
}

resolve_flutter() {
    if [[ -n "${FLUTTER:-}" ]] && [[ -x "${FLUTTER}" ]]; then
        echo "${FLUTTER}"
        return 0
    fi
    local linux_flutter
    if linux_flutter="$(find_linux_flutter 2>/dev/null)"; then
        echo "$linux_flutter"
        return 0
    fi
    if command -v flutter >/dev/null 2>&1; then
        command -v flutter
        return 0
    fi
    return 1
}

# Windows Flutter SDKs often have CRLF in bin/*.sh; WSL bash fails with "$'\r': command not found".
fix_flutter_crlf_if_needed() {
    local flutter_bin="$1"
    is_wsl || return 0
    [[ "$flutter_bin" == /mnt/c/* ]] || return 0

    local flutter_root internal f patched=0
    flutter_root="$(cd "$(dirname "$flutter_bin")/.." && pwd)"
    internal="${flutter_root}/bin/internal"

    for f in "$flutter_bin" "${internal}"/*.sh; do
        [[ -f "$f" ]] || continue
        if grep -q $'\r' "$f" 2>/dev/null; then
            sed -i 's/\r$//' "$f"
            patched=1
        fi
    done

    if [[ "$patched" -eq 1 ]]; then
        log_warn "Fixed CRLF in Windows Flutter SDK scripts (required when building from WSL)."
        log_warn "For deploy builds, a Linux-native Flutter install under WSL is recommended."
    fi
}

run_flutter() {
    local app_dir="$1"
    local flutter_bin="$2"
    shift 2
    fix_flutter_crlf_if_needed "$flutter_bin"
    (cd "$app_dir" && "$flutter_bin" "$@")
}

package_config_json() {
    echo "$1/.dart_tool/package_config.json"
}

# Windows `flutter pub get` writes file:///C:/... URIs. WSL dart2js cannot load
# those packages and reports hundreds of fake "isn't defined" errors.
package_config_has_windows_file_uris() {
    local pc
    pc="$(package_config_json "$1")"
    [[ -f "$pc" ]] || return 1
    grep -qE 'file:///[A-Za-z]:/' "$pc"
}

_unlock_package_config() {
    local pc="${_PACKAGE_CONFIG_LOCK:-}"
    _PACKAGE_CONFIG_LOCK=""
    [[ -n "$pc" && -f "$pc" ]] || return 0
    chmod u+w "$pc" 2>/dev/null || true
}

# Re-run pub get if a Windows IDE raced us, then freeze the file during dart2js.
prepare_linux_package_config_for_web_build() {
    local app_dir="$1"
    local flutter_bin="$2"
    local pc attempt

    flutter_has_linux_dart_sdk "$flutter_bin" || return 0

    pc="$(package_config_json "$app_dir")"
    for attempt in 1 2 3; do
        if ! package_config_has_windows_file_uris "$app_dir"; then
            break
        fi
        log_warn "package_config.json has Windows paths (file:///C:/...); pub get retry ${attempt}/3."
        run_flutter "$app_dir" "$flutter_bin" pub get
    done

    if package_config_has_windows_file_uris "$app_dir"; then
        log_error "WSL dart cannot resolve Windows package URIs in .dart_tool/package_config.json."
        log_error "That is why ScaffoldMessenger / kDebugMode / http.get look missing."
        log_error "Cursor on Windows likely overwrote WSL pub get. Use .\\deploy.ps1, or close the Windows Flutter tooling and retry."
        exit 1
    fi

    if is_wsl && [[ -f "$pc" ]]; then
        chmod a-w "$pc" 2>/dev/null || true
        _PACKAGE_CONFIG_LOCK="$pc"
        trap '_unlock_package_config' EXIT
    fi
}

# Flutter pub get needs git. WSL often lacks it; try Windows Git only if it actually runs.
ensure_wsl_build_path() {
    if command -v git >/dev/null 2>&1 && git --version >/dev/null 2>&1; then
        return 0
    fi

    if is_wsl; then
        local win_git dir
        for win_git in \
            "/mnt/c/Program Files/Git/cmd/git.exe" \
            "/mnt/c/Program Files/Git/bin/git.exe"; do
            if [[ -x "$win_git" ]] && "$win_git" --version >/dev/null 2>&1; then
                dir="$(dirname "$win_git")"
                export PATH="${dir}:${PATH}"
                log_info "Using Windows Git from WSL: ${win_git}"
                return 0
            fi
        done
    fi

    log_error "git not found or not runnable from this shell."
    if is_wsl; then
        log_error "Install git in WSL, then retry deploy:"
        if command -v apt-get >/dev/null 2>&1; then
            log_error "  sudo apt install git zip"
        elif command -v dnf >/dev/null 2>&1; then
            log_error "  sudo dnf install git zip"
        elif command -v pacman >/dev/null 2>&1; then
            log_error "  sudo pacman -S git zip"
        else
            log_error "  install git and zip using your distro package manager"
        fi
    else
        log_error "Install git and zip, then retry."
    fi
    exit 1
}

maybe_generate_pwa_icons() {
    local app_dir="$1"
    local script="${app_dir}/scripts/generate_pwa_icons.py"
    [[ -f "$script" ]] || return 0

    if ! python3 -c "import PIL" 2>/dev/null; then
        if [[ -f "${app_dir}/web/icons/Icon-192.png" ]] && [[ -f "${app_dir}/web/apple-touch-icon.png" ]]; then
            log_warn "Pillow (PIL) not installed; using committed web/ icons."
            return 0
        fi
        log_warn "Pillow (PIL) not installed; cannot regenerate PWA icons."
        log_warn "Install with: pip install Pillow"
        return 0
    fi

    # Always regenerate so opaque A2HS icons stay in sync with assets/images/element-deck.png.
    log_info "Generating PWA / A2HS icons..."
    (cd "$app_dir" && python3 scripts/generate_pwa_icons.py)
}

# True when flutter_bin belongs to a Linux Flutter SDK (cache/dart-sdk/bin/dart exists).
flutter_has_linux_dart_sdk() {
    local flutter_bin="$1"
    local flutter_root dart_linux
    flutter_root="$(cd "$(dirname "$flutter_bin")/.." && pwd)"
    dart_linux="${flutter_root}/bin/cache/dart-sdk/bin/dart"
    [[ -x "$dart_linux" ]]
}

# On WSL, Windows SDKs and cmd.exe shims to flutter.bat are not runnable from bash.
flutter_is_unusable_in_wsl() {
    local flutter_bin="$1"
    is_wsl || return 1
    flutter_has_linux_dart_sdk "$flutter_bin" && return 1
    return 0
}

find_linux_flutter() {
    local candidate
    for candidate in \
        "${FLUTTER:-}" \
        "${HOME}/flutter/bin/flutter" \
        "${HOME}/development/flutter/bin/flutter" \
        "/opt/flutter/bin/flutter"; do
        [[ -n "$candidate" && -x "$candidate" ]] || continue
        [[ "$candidate" == /mnt/c/* ]] && continue
        flutter_has_linux_dart_sdk "$candidate" || continue
        echo "$candidate"
        return 0
    done
    return 1
}

build_pwa_artifact_powershell() {
    local root_dir="$1"
    local ps_script="${root_dir}/scripts/build_pwa_artifact.ps1"
    [[ -f "$ps_script" ]] || {
        log_error "Missing Windows build script: ${ps_script}"
        exit 1
    }

    if ! wsl_interop_available; then
        log_error "WSL cannot run Windows binaries (interop disabled or unavailable)."
        log_error "Use Windows PowerShell from the repo root instead:"
        log_error "  .\\deploy.ps1"
        log_error "Or build only, then deploy from WSL:"
        log_error "  powershell -File scripts/build_pwa_artifact.ps1"
        log_error "  ./deploy.sh --skip-build"
        exit 1
    fi

    local ps_exe ps_path
    for ps_exe in powershell.exe pwsh.exe; do
        if command -v "$ps_exe" >/dev/null 2>&1; then
            ps_path="$(wslpath -w "$ps_script")"
            log_info "Building PWA via Windows ${ps_exe} (Windows Flutter SDK)..."
            if "$ps_exe" -NoProfile -ExecutionPolicy Bypass -File "$ps_path"; then
                [[ -f "${root_dir}/deployment/artifacts/pwa-dist.zip" ]] || {
                    log_error "PowerShell build finished but pwa-dist.zip is missing"
                    exit 1
                }
                log_success "PWA zip: ${root_dir}/deployment/artifacts/pwa-dist.zip"
                return 0
            fi
            log_warn "${ps_exe} build failed (WSL may not be able to run Windows binaries)."
        fi
    done

    log_error "Cannot build with Windows Flutter from WSL (Dart SDK is Windows-only)."
    log_error "Do one of the following:"
    log_error "  1) From Windows PowerShell:  .\\deploy.ps1"
    log_error "  2) Build then deploy:        powershell -File scripts/build_pwa_artifact.ps1"
    log_error "                               ./deploy.sh --skip-build"
    log_error "  3) Install Flutter natively in WSL and set FLUTTER=~/flutter/bin/flutter"
    log_error "  4) Enable WSL interop so powershell.exe is available from your WSL shell"
    exit 1
}

build_pwa_artifact_native() {
    local root_dir="$1"
    local app_dir="${root_dir}"
    local artifacts_dir="${root_dir}/deployment/artifacts"
    local build_dir="${app_dir}/build/web"
    local flutter_bin

    ensure_wsl_build_path
    command -v zip >/dev/null 2>&1 || {
        log_error "zip not found. Install zip (e.g. sudo dnf install zip) and retry."
        exit 1
    }

    flutter_bin="$(resolve_flutter || true)"
    if [[ -z "$flutter_bin" ]] && is_wsl && ! wsl_interop_available; then
        # shellcheck source=ensure-linux-flutter.sh
        source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ensure-linux-flutter.sh"
        ensure_linux_flutter
        flutter_bin="$(find_linux_flutter || true)"
    fi
    [[ -n "$flutter_bin" ]] || {
        log_error "Flutter not found. Install Flutter, add it to PATH, or set FLUTTER=/path/to/flutter"
        exit 1
    }

    if flutter_is_unusable_in_wsl "$flutter_bin"; then
        local linux_flutter
        linux_flutter="$(find_linux_flutter || true)"
        if [[ -z "$linux_flutter" ]]; then
            if wsl_interop_available; then
                build_pwa_artifact_powershell "$root_dir"
                return 0
            fi
            # shellcheck source=ensure-linux-flutter.sh
            source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ensure-linux-flutter.sh"
            ensure_linux_flutter
            linux_flutter="$(find_linux_flutter || true)"
            [[ -n "$linux_flutter" ]] || {
                log_error "Linux Flutter install failed."
                log_error "From Windows PowerShell use: .\\deploy.ps1"
                exit 1
            }
        fi
        log_info "Using Linux Flutter: ${linux_flutter}"
        flutter_bin="$linux_flutter"
    fi

    maybe_generate_pwa_icons "$app_dir"
    run_flutter "$app_dir" "$flutter_bin" pub get

    local define_script="${root_dir}/scripts/Get-FlutterDartDefines.sh"
    local -a dart_defines=()
    if [[ -f "$define_script" ]]; then
        while IFS= read -r line; do
            dart_defines+=("$line")
        done < <(bash "$define_script")
    fi

    # --no-web-resources-cdn: CanvasKit from build/web/canvaskit (not gstatic).
    # Offline / A2HS white-screens if the engine still points at the CDN.
    prepare_linux_package_config_for_web_build "$app_dir" "$flutter_bin"
    run_flutter "$app_dir" "$flutter_bin" build web --release --no-wasm-dry-run --no-web-resources-cdn "${dart_defines[@]}"
    _unlock_package_config

    [[ -d "$build_dir" ]] || { log_error "Build dir missing: $build_dir"; exit 1; }
    [[ -f "${build_dir}/index.html" ]] || { log_error "index.html missing in build output"; exit 1; }

    if [[ -f "${app_dir}/scripts/generate_offline_sw.py" ]]; then
        log_info "Generating offline/update service worker (content-hash cache)..."
        if command -v python3 >/dev/null 2>&1; then
            python3 "${app_dir}/scripts/generate_offline_sw.py" "$build_dir"
        else
            python "${app_dir}/scripts/generate_offline_sw.py" "$build_dir"
        fi
    else
        log_warn "Missing scripts/generate_offline_sw.py — Flutter stub SW will unregister (A2HS updates break)"
    fi

    rm -f "${artifacts_dir}/pwa-dist.zip"
    (cd "$build_dir" && zip -qr "${artifacts_dir}/pwa-dist.zip" .)
    log_success "PWA zip: ${artifacts_dir}/pwa-dist.zip"
}

# Local dev build → ./build/web (no zip). WSL-safe Flutter resolution.
build_web_pwa_release() {
    local root_dir="$1"
    local app_dir="${root_dir}"
    local build_dir="${app_dir}/build/web"
    local flutter_bin

    ensure_wsl_build_path

    flutter_bin="$(resolve_flutter || true)"
    if [[ -z "$flutter_bin" ]] && is_wsl && ! wsl_interop_available; then
        # shellcheck source=ensure-linux-flutter.sh
        source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ensure-linux-flutter.sh"
        ensure_linux_flutter
        flutter_bin="$(find_linux_flutter || true)"
    fi
    [[ -n "$flutter_bin" ]] || {
        log_error "Flutter not found. Install Flutter, add it to PATH, or set FLUTTER=/path/to/flutter"
        exit 1
    }

    if flutter_is_unusable_in_wsl "$flutter_bin"; then
        local linux_flutter
        linux_flutter="$(find_linux_flutter || true)"
        if [[ -z "$linux_flutter" ]]; then
            if wsl_interop_available; then
                build_pwa_artifact_powershell "$root_dir"
                [[ -f "${build_dir}/index.html" ]] || {
                    log_error "Windows build finished but ${build_dir}/index.html is missing"
                    exit 1
                }
                log_success "PWA build ready: ${build_dir}/"
                return 0
            fi
            # shellcheck source=ensure-linux-flutter.sh
            source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ensure-linux-flutter.sh"
            ensure_linux_flutter
            linux_flutter="$(find_linux_flutter || true)"
            [[ -n "$linux_flutter" ]] || {
                log_error "Linux Flutter install failed."
                log_error "From Windows PowerShell use: powershell -File scripts/build_pwa_artifact.ps1"
                exit 1
            }
        fi
        log_info "Using Linux Flutter: ${linux_flutter}"
        flutter_bin="$linux_flutter"
    fi

    maybe_generate_pwa_icons "$app_dir"
    run_flutter "$app_dir" "$flutter_bin" pub get

    local define_script="${root_dir}/scripts/Get-FlutterDartDefines.sh"
    local -a dart_defines=()
    if [[ -f "$define_script" ]]; then
        while IFS= read -r line; do
            dart_defines+=("$line")
        done < <(bash "$define_script")
    fi

    # --no-web-resources-cdn: CanvasKit from build/web/canvaskit (not gstatic).
    prepare_linux_package_config_for_web_build "$app_dir" "$flutter_bin"
    run_flutter "$app_dir" "$flutter_bin" build web --release --no-wasm-dry-run --no-web-resources-cdn "${dart_defines[@]}"
    _unlock_package_config

    [[ -f "${build_dir}/index.html" ]] || {
        log_error "Flutter web build failed: index.html missing in ${build_dir}"
        exit 1
    }

    if command -v python3 >/dev/null 2>&1; then
        python3 "${app_dir}/scripts/generate_offline_sw.py" "$build_dir"
    else
        python "${app_dir}/scripts/generate_offline_sw.py" "$build_dir"
    fi

    log_success "PWA build ready: ${build_dir}/"
}
