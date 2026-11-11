---
name: ddnomad-production-fixes
description: Use when investigating production data, planning production fixes, or preparing, reviewing, and rehearsing one-off repairs and backfills.
---

Scope
-----

- Apply to production investigations and repairs, including SQL, scripts, API operations, explanations, and instructions to other agents
- Production access is read-only. Prepare and rehearse repairs on isolated copies; hand production execution to a human operator.
- Apply [ddnomad-docs-style](../ddnomad-docs-style/SKILL.md) to documents, [ddnomad-coding-style](../ddnomad-coding-style/SKILL.md) to code, and [ddnomad-implementation-specs](../ddnomad-implementation-specs/SKILL.md) when preparing a specification or implementation plan
- Read and apply [ddnomad-investigations](../ddnomad-investigations/SKILL.md) for evidence gathering, tool use, and missing access

Entity References
-----------------

- Use consistent, verified entity labels in explanations, comments, and summaries. Prefer `customer Acme (public ID cust_123)` over unexplained `customer 42`. If no readable label exists, say `customer with internal ID 42`.
- Retrieve labels alongside exact keys, distinguishing public, internal, and provider IDs. Disambiguate collisions with verified IDs and context. Matching names or contact details do not prove identity or ownership.
- Keep executable identifiers and quoted evidence exact. Resolve readable labels to verified unique identifiers before writes; never target entities using display names, partial IDs, or unverified matches.

Repair Safety
-------------

### Plan

- Inspect the deployed data model and relevant application behaviour. Prefer supported operations that enforce the required rules over direct data writes.
- Define exact targets, expected starting state, affected record counts, and the intended result
- Choose appropriate atomicity and concurrency controls. Specify verification and recovery steps, accounting for partial failures and irreversible side effects.

### Rehearse

- Run the repair on an appropriate isolated copy and verify the resulting state before proposing production execution

### Hand Over for Human Execution

- Provide the reviewed repair and rehearsal results, with instructions to revalidate targets and starting state immediately before writing and abort on unexpected matches or changed state
- Include post-execution verification and recovery instructions. Distinguish proposed and rehearsed changes from production execution confirmed by the operator or read-only evidence.

Data Store Specific Rules
-------------------------

### SQL and Relational Databases

- Inspect the deployed schema, including keys, constraints, relationships, and triggers that affect the repair
- Use verified unique keys in predicates and joins. Prefer `WHERE id = 42` over `WHERE name = 'Acme'` after verifying the key-to-entity mapping. Include expected state guards.
- Prepare transactional SQL where supported, with affected-row and resulting-state checks before commit and rollback on unexpected results. Confirm which operations the database can actually roll back.
