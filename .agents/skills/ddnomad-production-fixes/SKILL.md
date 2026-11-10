---
name: ddnomad-production-fixes
description: Use when investigating production data, planning production fixes, or writing, reviewing, or executing one-off repairs and backfills.
---

Scope
-----

- Apply to production investigations and repairs, including SQL, scripts, API operations, explanations, and instructions to other agents
- Investigate read-only. A request to investigate or prepare a repair does not authorise production writes. Obtain explicit human approval for the specific operation before execution.
- Apply [ddnomad-docs-style](../ddnomad-docs-style/SKILL.md) to documents, [ddnomad-coding-style](../ddnomad-coding-style/SKILL.md) to code, and [ddnomad-implementation-specs](../ddnomad-implementation-specs/SKILL.md) when preparing a specification or implementation plan

Entity References
-----------------

- Use consistent, verified entity labels in explanations, comments, and summaries. Prefer `customer Acme (public ID cust_123)` over unexplained `customer 42`. If no readable label exists, say `customer with internal ID 42`.
- Retrieve labels alongside exact keys, distinguishing public, internal, and provider IDs. Disambiguate collisions with verified IDs and context. Matching names or contact details do not prove identity or ownership.
- Keep executable identifiers and quoted evidence exact. Resolve readable labels to verified unique identifiers before writes; never target entities using display names, partial IDs, or unverified matches.

Evidence
--------

- State the environment and evidence date. Distinguish live observations, restored dumps, and inferences.
- Inspect the deployed data model and relevant application behaviour. Prefer supported operations that enforce the required rules over direct data writes.
- Request necessary access or missing evidence from the human. Do not silently assume production matches a dump or local checkout.
- Push back on potentially outdated references or dumps. Proactively request newer versions where appropriate.

Repair Safety
-------------

- Define exact targets, expected starting state, and affected record counts. Revalidate them immediately before writing and abort on unexpected matches or changed state.
- Use the target system's supported atomicity and concurrency controls. Account for partial failures and side effects that recovery cannot undo.
- State the expected result, verification steps, and recovery procedure with its limits. Rehearse on an appropriate isolated copy and verify the resulting state before proposing production execution.
- After execution, verify the expected result and report what was proposed, rehearsed, and actually executed, including failures or deviations

Data Store Specific Rules
-------------------------

### SQL and Relational Databases

- Inspect the deployed schema, including keys, constraints, relationships, and triggers that affect the repair
- Use verified unique keys in predicates and joins. Prefer `WHERE id = 42` over `WHERE name = 'Acme'` after verifying the key-to-entity mapping. Include expected state guards.
- Use a transaction where supported, check affected-row counts and resulting state before committing, and roll back on unexpected results. Confirm which operations the database can actually roll back.
