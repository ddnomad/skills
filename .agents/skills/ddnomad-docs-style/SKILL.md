---
name: ddnomad-docs-style
description: Documentation style conventions. Use when writing, editing, or formatting project documentation files, including SKILL.md and other skill Markdown files.
---

Scope
-----

- Apply to documentation prose and Markdown structure. Source comments and docstrings must use `ddnomad-coding-style`. Load and apply that skill for code examples in documentation too.
- Treat `SKILL.md` and other Markdown files within skills as documentation. All rules in this skill apply to them.
- The shared [Language](#language) rules also apply when required by other skills; this does not extend documentation formatting rules to source code

Language
--------

- Use British English. Preserve exact quotations, proper names, existing code or API identifiers, and names required by external APIs or existing contracts.
- Describe state, behaviour, and constraints literally. Avoid attributing intent or human relationships to data and system components; name the actual operation or condition instead.
- Prefer explicit domain terms over narrative shorthand. Conventional technical actions such as "the service rejects the request" are generally accepted
- Do not replace clear terminology with awkward passive wording
- Follow established conventions, but do not infer a general wording rule from a few nearby examples

Illustrative wording:

| Do | Don't | Issue |
| --- | --- | --- |
| Cached entries expire after five minutes | The cache wants fresh data | Attributes desire to a cache and leaves the expiry condition unspecified |
| Suspended accounts cannot create new sessions | Suspended accounts lend their sessions to nobody | Uses a lending metaphor that obscures the actual restriction |
| The service rejects requests without an authentication token | The service is unhappy with the request | Attributes emotion to a service and omits the rejection condition |
| List the user's active sessions | List the active sessions of one user | Adds an unnecessary count where the user is already identified |

Use these forms only when the stated behaviour and conditions are verified.

Formatting
----------

### Project Configuration

- Read and apply the applicable `.editorconfig` rules before editing
- All Markdown must comply with the project's markdownlint configuration, defaulting to `.markdownlint.json` at the project root. It takes precedence over conflicting formatting guidance in this skill.

### Paragraphs

- Keep each prose paragraph on a single line in Markdown or other plain text based documentation files. Preserve line breaks required by file format structure.

### Headings

- Prefer title case for headings: capitalise the first and last words and all major words; lowercase articles, coordinating conjunctions, and prepositions elsewhere (for example, `The Quick Brown Fox Jumps over the Lazy Dog`). Preserve the exact casing of proper names and code or API identifiers.
- Every `SKILL.md` must begin with a Scope section after its frontmatter, stating when the skill applies and its boundaries

References
----------

### Links

- Link section and paragraph references with descriptive text naming the destination, not bare section numbers or positional wording such as "above" or "below". Include section numbers only alongside meaningful titles.
- Use `[Section](#heading-anchor)` within a file and `[Section](relative/path.md#heading-anchor)` across Markdown files. Use a URL and fragment for external documents. Resolve relative paths from the referring file.
- For a paragraph without an anchor, link to its containing section and identify the paragraph in the surrounding text. Add a descriptive subheading only if the reference would otherwise be ambiguous.
- When moving or renaming a heading, update affected links in the document and related documents

### Document Labels

- Use document local identifiers (e.g. TASK-1, PHASE-3) only when they improve traceability, not for every paragraph or task
- Define each labelled item with a short, meaningful title, such as `TASK-5 (Retry Behaviour)`, and keep that title consistent across related documents. In definition tables, keep the ID and title together.
- Refer to labelled items through descriptive links containing the ID and established title, rather than bare IDs. Do not repeat the title unnecessarily within the item's own definition.
- Document labels are not program identifiers. Do not rename code symbols, API fields, or literal values to satisfy these rules.
