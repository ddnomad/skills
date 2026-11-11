---
name: ddnomad-implementation-specs
description: Use when creating, editing, or reviewing implementation specifications and plans for issues or other development work.
---

Scope
-----

- Apply when creating, editing, or reviewing implementation specifications and plans for issues or other development work
- Preparing or reviewing a specification does not authorise implementation. Keep implementation separate unless the user requests it.

General Requirements
--------------------

- Resolve every in-scope decision and ambiguity through explicit human approval, recorded in the specification
- Agents may investigate and recommend, not decide implicitly. Assumptions and human silence are not approval.
- Keep open questions, assumptions, and blockers explicit, and mark the specification as an incomplete draft until each has an approved resolution
- Read and apply [ddnomad-docs-style](../ddnomad-docs-style/SKILL.md) for document formatting, wording, labels, and references. Follow its requirement to load coding style when including code examples.
- Read and apply [ddnomad-investigations](../ddnomad-investigations/SKILL.md) when gathering evidence for the specification
- Keep the specification consistent with current code and related documents. When revising it, update affected plans, acceptance criteria, and references.

Content
-------

Cover the topics relevant to the change, with enough detail to guide implementation and review. Follow existing project conventions for document structure. Omit sections that do not apply.

### Purpose and Scope

- State the problem, intended observable behaviour, and explicit non-goals
- Distinguish requested requirements from proposed choices. Do not silently expand the work.
- Propose small, low-effort improvements to system-wide robustness or correctness as scope candidates, even when slightly outside the original request. Explain their benefit and added work; include them only with explicit human approval.

### Current Behaviour and Context

- Explain how verified current behaviour, historical decisions and precedents, and future plans constrain the proposal, linking to the supporting evidence

### Proposed Changes

- Describe the proposed approach and its rationale, distinguishing recommendations from approved decisions
- Describe affected interfaces, state transitions, data changes, and error behaviour where relevant. Make boundary cases and compatibility expectations explicit.
- Reuse existing conventions unless the change deliberately replaces them. Identify affected callers and documents when changing a contract.
- Address security, migration, deployment, rollback, and operational concerns where relevant

### Implementation Plan

- Break the work into concrete component changes, naming verified files or symbols where useful. Identify dependencies, required sequencing, and work that can proceed independently.
- Describe the intended behaviour and contracts without prescribing incidental implementation details that do not affect correctness or review

### Acceptance and Verification

- Define observable acceptance criteria for the intended behaviour, boundaries, and failure cases, and explain how each will be verified
- Distinguish planned checks from checks already performed. Do not present an untested proposal as verified.
