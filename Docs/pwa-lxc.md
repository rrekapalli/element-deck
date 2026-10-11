# PWA on the LXC

Element Deck's web build is a static Flutter PWA. It is hosted the same way as the other apps on this Proxmox host: clone an LXC from the nginx base, serve the files with nginx, and publish HTTPS with Tailscale Funnel so a phone or tablet can open it without joining the tailnet.

There is no API container. Firebase stays in Google Cloud. The LXC only serves the web shell.

| | |
| --- | --- |
| VMID | **7018** |
| Hostname | `elementdeck` |
| URL | `https://elementdeck.tailce422e.ts.net/` |
| Template | `moneytree-lxc-frontend-base` (VMID **9002**) |
| Web root | `/var/www/element-deck` |

7018 is free next to the other personal-app containers (7001–7005, 7012, 7014, 7016, 7201–7203). Change `ELEMENT_DECK_VMID` in `deployment/proxmox/deployment.conf` if that id is taken.

## Once

1. Copy `.env.example` to `.env` and set `PROXMOX_PASSWORD`, `CONTAINER_PASSWORD`, and `TS_AUTHKEY` (`tskey-auth-...`).
2. In the Tailscale admin console, turn on MagicDNS and HTTPS certificates, and allow Funnel for the node.
3. WSL (or a Linux shell) with `bash`, `ssh`, and `python3`. Windows builds the PWA; WSL talks to Proxmox.

## Deploy

From the repo root in PowerShell:

```powershell
.\deploy.ps1
```

That bumps `pubspec.yaml`, runs `flutter build web`, zips `deployment/artifacts/pwa-dist.zip`, and deploys it to VMID 7018.

From Git Bash or WSL:

```bash
bash ./deploy.sh
```

Other flags:

```powershell
.\deploy.ps1 -SkipBuild          # redeploy the zip you already built
.\deploy.ps1 -Recreate           # destroy VMID 7018 and clone it again
.\deploy.ps1 -Major 1
```

```bash
bash ./deploy.sh --skip-build
bash ./deploy.sh --recreate
bash ./deploy.sh --skip-version-bump
```

After a successful deploy, open `https://elementdeck.tailce422e.ts.net/` on a phone, a tablet, and a desktop browser. Add it to the home screen to check the installed PWA. The manifest allows any orientation so a tablet can use the wide layout.

`/health` returns `ok` and is the Funnel probe. The app itself is `/`.

## Checks

```bash
bash deployment/proxmox/diagnose.sh
bash deployment/proxmox/curl-check.sh
```

Funnel off (tailnet-only HTTPS, devices must have Tailscale):

```bash
# in .env
ELEMENT_DECK_PUBLIC_VIA_FUNNEL=false
```

```bash
bash deployment/proxmox/enable-tailscale-https.sh
```

Turn public HTTPS back on:

```bash
bash deployment/proxmox/enable-tailscale-funnel.sh
```

## What the scripts do

`deploy.ps1` builds on Windows Flutter, then calls `deploy.sh --skip-build` in WSL. `deploy.sh` calls `deployment/prepare-artifacts.sh` (unless skipped) and `deployment/proxmox/deploy-ui.sh`.

`deploy-ui.sh` clones VMID 7018 if it is missing, unpacks the zip into nginx, joins Tailscale, and enables Funnel. A Windows-built zip is repacked when its paths use backslashes, so Linux `unzip` can read it.

The web build uses `--no-web-resources-cdn` so CanvasKit is inside the zip. A device does not have to reach gstatic. Service-worker and `index.html` responses are not cached by nginx. Hashed assets are.
