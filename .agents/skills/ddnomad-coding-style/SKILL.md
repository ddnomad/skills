---
name: ddnomad-coding-style
description: Code style conventions. Use when writing, editing, or formatting source code, comments, docstrings, or code examples in documentation.
---

Scope
-----

- Apply to source code, comments, docstrings, identifiers, user-facing messages, and code examples in documentation. Documentation prose must follow `ddnomad-docs-style`.
- Limit style changes to the requested work and code being edited unless broader cleanup is requested

Language
--------

- Read and apply the shared [Language](../ddnomad-docs-style/SKILL.md#language) rules to comments, docstrings, user-facing text, and new identifiers. This does not apply documentation formatting rules to source files.
- Use implementation comments primarily to explain unexpected behaviour, non-obvious constraints, or seemingly odd choices, not to narrate straightforward code
- Limit factual claims to behaviour verified in the relevant implementation. Do not promise input properties, caller behaviour, or system-wide guarantees based on assumptions about other code.
- State required preconditions as requirements, not claims that callers already satisfy them. If an explanation depends on enforcement elsewhere, verify, identify and stress that enforcement point, otherwise omit the claim or raise the uncertainty.

Illustrative comment wording:

| Do | Don't | Issue |
| --- | --- | --- |
| `// Keep the second check: the value may change while the lock is released` | `// The value cannot change because callers hold the lock` | Assumes caller behaviour instead of explaining the local defensive check |
| `// Requires a non-empty list` | `// The list is always non-empty because validation happens upstream` | Confuses a required precondition with an unverified guarantee |
| `// Skip malformed entries so one bad record does not abort the batch` | `// Malformed entries cannot reach this code` | Promises behaviour elsewhere instead of explaining the local recovery policy |

Use these examples only when the local behaviour or required contract has been verified.

Formatting
----------

### Project Configuration

- Read and apply the applicable `.editorconfig` rules before editing

### Line Length

- Wrap code at a target line length of 150 characters

Programming Language Specific Rules
-----------------------------------

### Rust

#### Module Structure

Order source files as follows:

1. Module documentation (`//!`)
2. Module declarations (`mod`)
3. Imports (`use`)
4. Constants (`const`)
5. Static values (`static`)
6. Enums, then structs, keeping each type adjacent to its own implementations
7. Implementations for types defined outside the file
8. Free functions, grouped by visibility and then alphabetically, with private helpers last
9. Test modules

After each type definition, place its inherent implementations (`impl Type`), followed by its trait implementations (`impl Trait for Type`). Do not place standalone functions between the type and its implementations.

#### Spacing

- Use one blank line between a type and its first implementation, and between successive implementations of that type
- Use two blank lines between other neighbouring items, including between type units, before implementations for types defined elsewhere, before free functions, and before the test module
- Apply the same item separation rules inside blocks, including implementations and nested modules. This does not require two blank lines between fields or statements.
- Keep documentation comments, attributes, and derives attached to the item they describe. Do not treat them as separate items.
- Separate the introductory module documentation or inner attributes from the following contents with one blank line
- Use the group spacing defined in [Imports](#imports) within import blocks

#### Visibility and Alphabetical Order

- Within each declaration group in [Module Structure](#module-structure), sort by visibility from widest to narrowest, then alphabetically by name within each visibility group. Sort enums and structs separately. Imports must follow [Imports](#imports).
- Compare restricted visibility by the resolved module scope, not path length. A restriction to an outer ancestor is wider than one to an inner ancestor. Equivalent scopes belong to the same group.
- Preserve the group order and type–implementation adjacency defined in [Module Structure](#module-structure) when sorting

#### Imports

- Prefer relative paths for internal imports, allowing at most two parent levels (`super::super::something::Something`). Use a `crate::` path when a relative import would require more than two `super::` segments.
- Place each `use` in the narrowest scope that needs it, such as inside a function, rather than collecting all imports at file scope
- Group imports by origin, with one blank line between groups
- Sort imports alphabetically within each group, including names inside braces (for example, `{Alpha, Beta, Gamma}`)

#### Comments

- Omit the final full stop from single-sentence comments and documentation comments
- Use full punctuation, including a final full stop, for comments containing two or more sentences
- Prefix lasting implementation rationale with `// NOTE:`
