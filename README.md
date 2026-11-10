Agentic Development Skills
==========================

A coherent, reviewed, and trusted set of agent skills tailored to ddnomad's development setup.

Current targets:

- **Workflow:** Spec-driven development with exhaustive manual code reviews
- **Harness:** [OMP (Oh-My-Pi)](https://omp.sh/)
- **Model:** [Qwen 3.8 Flash Next FP4 Local](https://huggingface.co/nvidia/Qwen3.8-Flash-Next-FP4-Local)

Motivation
----------

Off-the-shelf skills are great in theory, but can quickly become counterproductive for large, complex projects, as they:

- Address weaknesses in specific models that may not be present in others
- Ban words or behaviors to fix narrow issues at the expense of general output quality
- Often conflict when combined, degrading overall output quality
- Devolve over time into overly broad, barely reviewed AI slop masquerading as universal best practices
- Come from strangers and may include a bonus prompt injection one day

Current Status
--------------

Inception. Most skills are either absent or do not cover everything that dd would want to cover yet.

Quick Start
-----------

### Manual Skills Installation

From your project root, download the skills:

```sh
curl -fsSL https://github.com/ddnomad/skills/archive/refs/heads/main.tar.gz \
  | tar -xz --strip-components=1 skills-main/.agents/skills
```

Copy the **Required Skills** section from this repository's [AGENTS.md](AGENTS.md) into your project's `AGENTS.md`. **This is crucial**, as it tells agents when to proactively read and apply the skills, rather than merely making the files available, hoping they will be used.
