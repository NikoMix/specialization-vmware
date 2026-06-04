# Contributing

Thanks for contributing to the **VMware on Microsoft Azure (Azure VMware Solution) Advanced Specialization** engagement toolkit. This is an **innersource** repository owned by the AVS practice.

## Branch + PR workflow

1. Branch off `main` using the pattern: `feature/<area>/<short-slug>` (e.g. `feature/module-b/refine-b11-evidence`)
2. Make focused changes — one logical concern per PR
3. Open a PR using the PR template; link the engagement phase + control number
4. At least one **CODEOWNER** approval is required (see `CODEOWNERS`)
5. Review SLA: **2 working days**
6. Squash-merge

## Issue templates

Use the matching template under `.github/ISSUE_TEMPLATE/`:

- **control-improvement** — improvement to a Module A / B control page
- **template-improvement** — improvement to an engagement playbook or deliverable template
- **lesson-learned** — capture a lesson from a closed engagement

## Content rules

- Follow `.github/memories/mdx-content.md` strictly
- Escape `<` followed by letter/digit/space in prose (`&lt;`)
- **Filenames must not contain dots** — use `2-1-foo.mdx`, not `2.1-foo.mdx`
- Control numbers in prose use dots: `A.2.1`, `B.3.1`
- Cross-link controls with **relative** paths
- Anonymise customer references — never commit real customer names / IP

## When evidence requirements change

If you add, remove, or reword an evidence item on a control page, you **must** also update `.github/scripts/create-issues.sh` so the auto-created issue checkboxes stay aligned.

## Code of conduct

Be kind. Be specific. Be helpful. Disagreements about technical content are welcome — disagreements about people are not.

## Questions

Open a GitHub Discussion or ping the AVS practice lead in the practice's Teams channel.
