# Personas

Personas are **jobs**, not separate apps. The catalog, the four rooms, and the three depths stay the same. What changes is the default depth, the sentence on the home hint, and which empty states we write.

A persona is stored with the learner and can be changed in Settings. First launch uses **Student** at **Intermediate**, which matches the concept screens. The preview opens with no account. Buying a package and downloading the full pack require Google sign-in. Nothing in the schema is hidden from a persona.

## Catalog

| Persona | Objective | Default depth | Home hint |
| --- | --- | --- | --- |
| Student | Pass from "I have seen the symbol" to "I can explain the element" | Intermediate, switchable | What should I understand about this element today? |
| Educator | Teach one element to a room that is not all at the same depth | Intermediate, with the depth control obvious | Which element is in front of the class, and can a student change depth without leaving? |
| Enthusiast | Follow a glow, a metal, a neighbor pair | Advanced | What is interesting about this element beyond the exam line? |

There is no Researcher persona. Someone who wants term symbols and isotope decay uses **Enthusiast** or **Student** at Advanced. Element Deck does not keep a lab notebook or a paper graph.

## Same rooms, different jobs

```text
FIND → READ → COMPARE → SEE THE LIGHT → RETURN
```

| Step | Student | Educator | Enthusiast |
| --- | --- | --- | --- |
| Find | Search the syllabus symbol | Element of the day, or a class set | Wander the matrix or a category chip |
| Read | Intermediate dossier, drop to Beginner when lost | Project Details; invite the room to switch depth | Advanced metrics first |
| Compare | The neighbor the chapter pairs (C and Si) | The pair that makes the trend visible on a wide screen | Any saved pair |
| Light | Color and a plain description of the glow | Emission vs absorption, still readable from the back row | Line, transition, isotopes |
| Return | Bookmark the exam set | Reopen the same element next period | Recent elements and saved comparisons |

## What a persona actually changes

| Surface | Weight |
| --- | --- |
| Default complexity | Student and Educator: Intermediate. Enthusiast: Advanced |
| Table hint | Exam-friendly on Student; "project this" on Educator; quiet on Enthusiast |
| Details curriculum card | Student sees the three profiles as a guide. Educator sees them as the lever. Enthusiast can collapse the card |
| Compare empty state | Student: a suggested congener in the same group. Educator: last class pair. Enthusiast: last saved pair |
| Spectra lead | Student: glow and color name first. Advanced sections remain one scroll away |
| Settings | Educator sees Classroom once Pro exists. The appearance controls are identical |

A student can open Advanced. An enthusiast can switch to Beginner to see what a younger reader would get. Persona only picks the default path through the same rooms.

## Persona versus depth

Keep these separate.

| | Persona | Depth |
| --- | --- | --- |
| Lifetime | This device, changeable in Settings | Session, and a default stored in App settings |
| Question it answers | Why am I here? | How much of this element should be on screen? |
| Example | I am teaching | Show Intermediate |

An educator at Beginner is still an educator. They dropped the room's reading level for a minute.

## Persona on this device

```text
Open the app
  → preview catalog, no account
  → persona Student, depth Intermediate

Sign in and buy Element Deck
  → download the content pack
  → persona and depth follow this device, then copy to the account

Settings → Learning
  → persona dropdown
  → depth default follows the persona until the learner overrides it
```

Changing persona later does not rewrite bookmarks. It changes defaults from then on.

## Classroom is not a fourth persona

A class is the Classroom package: a shared Firebase list of elements and a suggested depth. Each learner still uses the same app and can move the depth control. The educator does not get a private build of the table. The package does not have to ship in the first store build.

See [use-cases/classroom.md](./use-cases/classroom.md).
