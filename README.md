# VMware on Microsoft Azure — Advanced Specialization

> Engagement toolkit for Microsoft partners pursuing the **VMware on Microsoft Azure (Azure VMware Solution) Advanced Specialization** audit.
>
> **Checklist version**: V1.9.1 (active **Jan 1 – Jun 30, 2026**). V2.0 PREVIEW (Jun 1, 2026) refresh pending.

---

## 🎯 Purpose

This repository gives consultants a structured, step-by-step engagement framework to guide partner organisations through the Advanced Specialization audit. It includes:

- **GitHub Issues** as the primary engagement task board — one issue per control with evidence checklists
- **Documentation site** (Astro / Starlight) with detailed evidence guidance for each control plus an engagement playbook
- **Engagement Agent** — an AI assistant that guides consultants through the process
- **Innersource governance** — lifecycle, CODEOWNERS, contributing guide
- **Automated issue creation** — recreates audit issues each year, 9 months before the next audit

---

## 🚀 Getting Started

This repo is a **GitHub Template**. Click **"Use this template"** (not Fork) to create your own copy.

### 1. Use this template

Click **Use this template → Create a new repository** and choose your GitHub organisation.

### 2. Set your site URL

In `astro.config.mjs`, the site URL is read from the `ASTRO_SITE` environment variable.
Add it as a **repository variable** (not a secret):

- Go to your repo → **Settings → Secrets and variables → Actions → Variables**
- Add variable `ASTRO_SITE` = `https://YOUR_ORG.github.io/YOUR_REPO_NAME`

Optionally also add `ASTRO_GITHUB_URL` = `https://github.com/YOUR_ORG/YOUR_REPO_NAME`.

### 3. Enable GitHub Pages

Go to your repo → **Settings → Pages → Source** → select **GitHub Actions**.

### 4. Create the engagement issues

Go to **Actions → Create Audit Engagement Issues → Run workflow**.

### 5. Done

- Issues appear as your engagement task board 📋
- The documentation site deploys automatically on push to `main` 🌐
- Use the Engagement Agent for guided assistance 🤖

---

## 🤖 Engagement Agent

This repo ships with a **GitHub Custom Agent** — a purpose-built Copilot agent that knows every audit control, evidence requirement, AVS reference architecture, and common blocker for this specialization.

The agent profile is defined in [`.github/agents/engagement-agent.agent.md`](.github/agents/engagement-agent.agent.md).

---

## 📅 Annual Audit Cycle

The `Create Audit Engagement Issues` workflow runs automatically on a **schedule** (default: March 1st each year) to create a fresh set of issues for the next audit cycle, 9 months after the previous audit — giving your team 3 months to re-collect evidence.

To adjust the schedule to match your audit timing:
- Open `.github/workflows/create-issues.yml`
- Change the cron month: `0 9 1 **3** *` → your audit month + 9

---

## 🖥️ Local Development

```bash
npm install
npm run dev
```

---

## 📁 Structure

```
├── .github/
│   ├── agents/engagement-agent.agent.md
│   ├── memories/mdx-content.md
│   ├── ISSUE_TEMPLATE/
│   ├── scripts/create-issues.sh
│   └── workflows/
│       ├── deploy.yml
│       ├── create-issues.yml
│       └── copilot-setup-steps.yml
└── src/content/docs/
    ├── index.mdx / overview.mdx / requirements.mdx / ...
    ├── module-a/      # A.1.1 – A.3.3 (7 controls, generic Azure foundation)
    ├── module-b/      # B.1.1 – B.4.2 (8 controls, AVS-specific)
    ├── engagement/    # Offerings, qualification, discovery, WAF, Azure Migrate + HCX, ref arch, deliverables, DoD
    └── innersource/   # Contributing, content governance, roadmap
```

---

## 📄 License

Content is provided for partner enablement purposes. Refer to your Microsoft Partner Agreement for usage terms.
