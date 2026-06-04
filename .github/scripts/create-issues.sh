#!/usr/bin/env bash
# create-issues.sh
# Creates all audit engagement issues for the VMware on Microsoft Azure
# (Azure VMware Solution) Advanced Specialization. Skips any issue whose title
# already exists (open or closed) for the given cycle label to avoid duplicates
# across re-runs.
#
# Environment variables expected:
#   GH_TOKEN     - GitHub token with issues:write permission
#   CYCLE_LABEL  - e.g. "audit-2026"
#   MILESTONE    - milestone title (e.g. "Audit 2026") — passed by title for safety
#   REPO         - owner/repo

set -euo pipefail

# ─── helpers ──────────────────────────────────────────────────────────────────

create_issue() {
  local title="$1"
  local labels="$2"
  local body="$3"

  local existing
  existing=$(gh issue list \
    --repo "$REPO" \
    --state all \
    --label "$CYCLE_LABEL" \
    --limit 200 \
    --json title \
    --jq "[.[] | select(.title == \"$title\")] | length")

  if [ "${existing:-0}" -gt 0 ]; then
    echo "⏭  Skipping (exists): $title"
    return
  fi

  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --label "$labels" \
    --milestone "$MILESTONE" \
    --body "$body"

  echo "✅ Created: $title"
}

# ─── Pre-Qualification Gate ───────────────────────────────────────────────────

create_issue \
  "🎯 Pre-Qualification Gate" \
  "pre-qualification,$CYCLE_LABEL" \
  "## Pre-Qualification Gate

Confirm all pre-qualification requirements before requesting the V1.9.1 audit (ISSI).

📖 [Full requirements](../../src/content/docs/requirements.mdx)

### Solutions Partner designation
- [ ] Active **Solutions Partner for Infrastructure (Azure)** confirmed in Partner Center
- [ ] Screenshot of active designation exported

### ACR – AVS node consumption + adjacent infra
- [ ] AVS node ACR threshold confirmed in Partner Center → Insights → Azure Revenue
- [ ] Adjacent ExpressRoute / ANF / Arc-enabled VMware ACR captured
- [ ] ACR figures verified with PDM (data may lag 2–4 weeks)
- [ ] Partner Center ACR export saved

### Customer diversity
- [ ] ≥ 1 AVS production customer in the last 12 months (Module B)
- [ ] ≥ 2 unique customers in the last 12 months (Module A)

### Required Microsoft certifications (consultants)
- [ ] At least 1 person holds AZ-104 (Azure Administrator)
- [ ] At least 1 person holds AZ-305 (Azure Solutions Architect Expert)
- [ ] (Recommended, not gating) VCP-DCV / NSX-T / AZ-700

### Module A reuse (if applicable)
- [ ] Confirm whether existing Module A pass is &lt; 2 years old → may waive Module A at this audit

### Audit logistics
- [ ] Decide Module B only (\$2,400, 4h) vs combined Module A+B (\$3,600, 8h)
- [ ] Audit slot requested in Partner Center"

# ─── Module A controls ────────────────────────────────────────────────────────

create_issue \
  "A.1.1 – Cloud & AI Adoption Business Strategy" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.1.1 – Cloud & AI Adoption Business Strategy

📖 [Control page](../../src/content/docs/module-a/1-1-business-strategy.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence
- [ ] **FinOps Review** completed for each of 2 unique customers (REQUIRED)
- [ ] **Cloud Adoption Strategy Evaluator (CASE)** completed for each (REQUIRED)
- [ ] (Optional) Advisor Assessment
- [ ] Customer-facing report or presentation demonstrating both Business and FinOps outcomes
- [ ] Personalised recommendations for maximising cloud business value documented
- [ ] All evidence stored, dated, and anonymised in evidence tracker"

create_issue \
  "A.1.2 – Cloud & AI Adoption Plan" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.1.2 – Cloud & AI Adoption Plan

📖 [Control page](../../src/content/docs/module-a/1-2-adoption-plan.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence (at least 2 of)
- [ ] **Cost Management report** with **Pricing Calculator output** per customer (REQUIRED)
- [ ] **DevOps Capability Assessment** report per customer (REQUIRED)
- [ ] Adoption plan covering analytics / app modernisation / AI tracking"

create_issue \
  "A.2.1 – Security & Governance Tooling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.2.1 – Security & Governance Tooling

📖 [Control page](../../src/content/docs/module-a/2-1-security-governance-tooling.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence
- [ ] Security baseline via **Microsoft Defender for Cloud** OR 3rd-party tool deployed for each customer
- [ ] **Cloud Adoption Security Review** assessment completed for each customer
- [ ] Governance tooling (Policy, RBAC, tagging) evidence captured"

create_issue \
  "A.2.2 – Well-Architected Workloads" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.2.2 – Well-Architected Workloads

📖 [Control page](../../src/content/docs/module-a/2-2-well-architected-workloads.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence
- [ ] **Azure Well-Architected Review** results exported per customer
- [ ] Evidence of alignment to Architecture Center reference architectures
- [ ] WAR completed for workloads about to be deployed (production-readiness)"

create_issue \
  "A.3.1 – Repeatable Deployment (ALZ)" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.1 – Repeatable Deployment (ALZ)

📖 [Control page](../../src/content/docs/module-a/3-1-repeatable-deployment-alz.mdx)

**Customers**: 2 unique

### Required evidence
- [ ] Documented repeatable deployment aligned to **ALZ conceptual architecture**
- [ ] Using **Bicep, Terraform, OR ARM** (pick one — clarified Dec 1, 2025) OR the **Azure Landing Zone Accelerator**
- [ ] Minimum configured: Identity (Entra ID), Networking topology (incl. hybrid ER/VPN), Resource organisation (tagging + naming)
- [ ] **Azure Landing Zone Review** assessment confirming multi-region or multi-zone redundancy policy
- [ ] One of four ALZ approaches articulated (start small / full conceptual / alternative / brownfield)"

create_issue \
  "A.3.2 – Plan for Skilling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.2 – Plan for Skilling

📖 [Control page](../../src/content/docs/module-a/3-2-plan-for-skilling.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence
- [ ] Skilling plan for IT Admin / Governance / Ops / Security roles
- [ ] Knowledge-transfer resources (Microsoft Learn paths, certs)
- [ ] Customer-facing presentation OR planning docs OR post-deployment docs
- [ ] Reference: \"How to Build a Skilling Readiness Plan\""

create_issue \
  "A.3.3 – Operations Management Tooling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.3 – Operations Management Tooling

📖 [Control page](../../src/content/docs/module-a/3-3-operations-management-tooling.mdx)

**Customers**: 2 unique • **Window**: Last 12 months

### Required evidence
- [ ] **Azure Monitor OR Azure Automation OR Azure Backup/Site Recovery** deployed per customer
- [ ] Automated security + compliance checks via **GitHub Actions or Azure DevOps**
- [ ] One sanitised artifact captured: security scan report / monitoring dashboard export / audit-ready YAML pipeline + scan logs / SBOM / policy-as-code compliance snapshot
- [ ] (Optional) Azure Advisor Reliability Review"

# ─── Module B controls (AVS, V1.9.1 — 8 controls) ─────────────────────────────

create_issue \
  "B.1.1 – Workload Assessment" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.1.1 – Workload Assessment

📖 [Control page](../../src/content/docs/module-b/1-1-workload-assessment.mdx)

**Customers**: 1 AVS • **Window**: Last 12 months

### Required evidence (≥ 2 artifacts)
- [ ] **Azure Migrate** discovery + dependency map (or 3rd-party with results consolidated into Azure Migrate for final recommendation)
- [ ] Licensing / support coverage analysis (SAP, Oracle, etc.)
- [ ] AVS node sizing — active + standby for surge / DR
- [ ] Performance-based vs As-on-premises assessment decision documented
- [ ] Remediation plan for \"Ready with conditions\" / \"Not ready\" VMs
- [ ] ExpressRoute bandwidth estimation factoring storage volume + migration timeline
- [ ] Network topology with no overlap between on-prem / AVS mgmt / AVS workload nets
- [ ] Remote-location / VPN-site / user count baseline
- [ ] Inbound + outbound connectivity + security analysis
- [ ] Software requiring AVS-host access identified"

create_issue \
  "B.2.1 – Solution Design" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.2.1 – Solution Design

📖 [Control page](../../src/content/docs/module-b/2-1-solution-design.mdx)

**Customers**: 1 AVS • **Window**: Last 12 months

### Required evidence (≥ 2 artifacts: design docs / functional specs / architecture diagrams / tooling reports / physical+logical diagrams)
- [ ] Migration strategy with apps / DBs / auxiliary components in scope
- [ ] Migration risk + mitigation register
- [ ] High-level migration sequence + validation criteria
- [ ] Non-overlapping network topology
- [ ] **ALZ** alignment: Mgmt Groups (Tenant/Platform/Landing Zone/Sandbox), subscriptions (Identity/Connectivity/Mgmt/AVS-Prod/AVS-Pilot), RBAC defs+assignments, Policy defs+assignments, AzOps process, AVS Resource Provider registration permissions, DHCP/DNS strategy
- [ ] **ExpressRoute Global Reach** for migration when available
- [ ] AVS ER circuit key termination on ER Gateway / Virtual WAN documented
- [ ] Connectivity from on-prem / Azure jump box → vCenter / NSX-T / HCX interfaces
- [ ] VLAN segments + DHCP + port mirroring + DNS forwarder via NSX-T or Azure portal
- [ ] Guest VM connectivity: internet, on-prem, Azure VM, Azure PaaS via Private Endpoint
- [ ] Backup / restore / monitor / DR design"

create_issue \
  "B.2.2 – Azure Well-Architected Review of Workloads" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.2.2 – Azure Well-Architected Review of Workloads

📖 [Control page](../../src/content/docs/module-b/2-2-well-architected-review.mdx)

**Customers**: 1 unique • **Window**: Last 12 months

### Required evidence
- [ ] **Azure Well-Architected Review** run on AVS workload(s)
- [ ] Exported WAR results covering at least **2 pillars** (Reliability + Cost recommended for AVS)
- [ ] Customer named in the export
- [ ] Review timing (before/during/after deployment) documented"

create_issue \
  "B.3.1 – Infrastructure Implementation and Configuration" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.3.1 – Infrastructure Implementation and Configuration

📖 [Control page](../../src/content/docs/module-b/3-1-infrastructure-implementation.mdx)

**Customers**: 1 AVS production • **Window**: Last 12 months

### Required evidence (≥ 2 of)
- [ ] Signed SOWs
- [ ] Solution design docs
- [ ] Customer-approved project plan + migration-deployment sequence
- [ ] Architecture diagrams
- [ ] Implementation or \"as-built\" documentation"

create_issue \
  "B.3.2 – Migration Tools" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.3.2 – Migration Tools

📖 [Control page](../../src/content/docs/module-b/3-2-migration-tools.mdx)

**Customers**: 1 AVS

### Required evidence — choose one option (A / B / C)
- [ ] **Option A — HCX**: experience documented for at least one of: app migration with live VM mobility / heterogeneous vSphere-version migration / workload rebalancing between on-prem DCs and AVS region(s)
- [ ] **Option B — VMware motion mechanism**: plans + scripts + pre/post-assessments for on-prem → AVS or other-cloud → AVS
- [ ] **Option C — 3rd-party tools** (Commvault, RiverMeadow, Rubrik, etc.): referenced in project plan or output snapshots"

create_issue \
  "B.3.3 – AVS Configuration and Azure Services Integration" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.3.3 – AVS Configuration and Azure Services Integration

📖 [Control page](../../src/content/docs/module-b/3-3-avs-configuration-and-integration.mdx)

**Customers**: 1 AVS production • **Window**: Last 12 months

### Required evidence — ≥ 3 integration capabilities demonstrated
- [ ] Azure Blob backend for vSphere Content Library
- [ ] Content Library populated with licensed Windows / Linux images
- [ ] On-prem AD or federated Entra ID via domain controllers on Azure VMs as identity source for AVS
- [ ] Add / remove hosts without app impact
- [ ] Configure Gateway for AVS app
- [ ] Enable public Internet on AVS
- [ ] Scale AVS nodes
- [ ] Quota-increase process documented
- [ ] Configure Virtual WAN for multi-site access

### Supporting artifacts (≥ 2 of)
- [ ] Solution Design Docs
- [ ] Project Plan + migration sequence
- [ ] Architecture diagrams covering Networking, HA/DR, Backup, Mgmt + Monitoring, Load Balancing"

create_issue \
  "B.4.1 – Service Validation and Testing" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.4.1 – Service Validation and Testing

📖 [Control page](../../src/content/docs/module-b/4-1-service-validation-testing.mdx)

**Customers**: 1 (AVS migration) • **Window**: Last 12 months

### Required evidence
- [ ] Documented testing process — app performance vs user expectations + Azure best practices
- [ ] Documented process for evaluating + improving architectural best practices post-migration (perf / cost remediation)
- [ ] Test / validation / perf-evaluation documents
- [ ] **Customer sign-off** stating expectations met (email acceptable)"

create_issue \
  "B.4.2 – Post-Deployment Documentation" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.4.2 – Post-Deployment Documentation

📖 [Control page](../../src/content/docs/module-b/4-2-post-deployment-documentation.mdx)

**Customers**: 1 AVS

### Required evidence — all bullets covered for 1 customer (may reuse prior controls)
- [ ] How the partner documents decisions / architectures / procedures
- [ ] SOPs for BAU ops (\"how-to\" scenarios)
- [ ] AVS host monitoring solution in place
- [ ] Azure Monitoring Agent (or equivalent) deployed on guest VMs
- [ ] Guest-VM logs flowing into Azure Monitor / Log Analytics
- [ ] Azure Update Management + Config Management (or similar) on AVS guest VMs via Automation Account + Log Analytics
- [ ] AVS guest VMs enrolled in **Defender for Cloud (Defender for Servers)**
- [ ] **Backup** via Azure Backup Server (or licensed equivalent) with **restore demonstrated** (screenshot / video)
- [ ] **DR via HCX / SRM / partner solution** documented
- [ ] **Automated DR** — workloads deployable to alternate site in running state"

echo ""
echo "🎉 All audit engagement issues created (or skipped if already present)."
