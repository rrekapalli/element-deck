# Classroom

**Plan:** Classroom package  
**Status:** after the personal Element Deck package. Same Firebase project.  
**Data:** class list in Firestore. The science is the content pack in Storage, cached in SQLite on each device.

A classroom is a shared list and a suggested depth. It is not a second catalog and not a grading system.

## Job

An educator creates a class, shares a join code, and pins the elements for the week. Learners open Element Deck, join, and land on that set. Each learner can still change depth and can still open the rest of the table.

## Objects

From [object-model.md](../object-model.md):

| Object | Meaning |
| --- | --- |
| Classroom | Name, owner, join code |
| Membership | Educator or learner |
| Assignment | Title, list of Z, suggested depth, optional date |

v1 of classroom can be a single pinned list. Multiple assignments can wait.

## Flow

```text
Educator (Pro)
  → create class
  → add elements
  → set suggested depth
  → show join code

Learner
  → join
  → Table filters to the class set, with a clear "All elements" escape
  → depth opens at the suggestion
  → learner may switch depth; that does not rewrite the assignment
```

The escape hatch is required. A class that traps a curious student inside ten elements has failed the product.

## Roster and minors

Joining should not demand a date of birth or a school id. A display name from Firebase Auth is enough if a class is built. School deployment, data-processing terms, and who may create a class for children are **open**. Do not ship join codes to minors until that note exists. Until then, a class is just everyone opening the same element. Adults and informal study groups would be the first users of a shared list.

## Wide shell

The educator projects the wide layout. Learners are often on phones. The assignment id in a link (`/class/{code}`) opens the filtered table. It does not force the wide shell onto a phone.

## Out of classroom

- Grades, submissions, and plagiarism.
- Hiding Spectra because it is "not on the test."
- Educator edits to atomic weights.
- Chat.
