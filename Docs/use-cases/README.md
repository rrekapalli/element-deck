# Use cases

Same catalog, same four rooms, same three depths. The job changes.

```text
                         Element Deck
                           │
            ┌──────────────┼──────────────┐
            │              │              │
        LEARN          TEACH          WANDER
            │              │              │
        Student        Educator      Enthusiast
            │              │
            └──── Classroom (Pro) ───┘
```

| File | Who |
| --- | --- |
| [Student](./student.md) | Learn an element at the right depth |
| [Educator](./educator.md) | Put one element in front of a room |
| [Enthusiast](./enthusiast.md) | Follow a glow or a neighbor pair |
| [Classroom](./classroom.md) | The Classroom package: a shared list on top of the same content pack |

Offerings are sketched in [product-brief.md](./product-brief.md). Personas are in [personas.md](../personas.md).

## Packages

| Package | What the person gets |
| --- | --- |
| Preview | Five elements, no account, bundled in the app |
| Element Deck | The full content pack, downloaded from Firebase and cached on the device |
| Classroom | Element Deck plus a class list |

Who bought which package is a Firestore purchase, written after the store receipt is checked. See [product-brief.md](../product-brief.md).
