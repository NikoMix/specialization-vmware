import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// ─── Site URL & base path ─────────────────────────────────────────────────────
// On GitHub Actions, GITHUB_REPOSITORY is "owner/repo" and GITHUB_REPOSITORY_OWNER
// is just "owner". We derive both `site` and `base` from these so a freshly-forked
// template builds correctly with no manual configuration.
//
// You can override either by setting ASTRO_SITE / ASTRO_BASE as repo variables.
//
// Special case: user/org pages (repo named `<owner>.github.io`) are served from
// the domain root and must use base "/".
const repo = process.env.GITHUB_REPOSITORY ?? 'YOUR_ORG/vmware-on-azure-specialization';
const [owner, repoName] = repo.split('/');
const isUserOrOrgPage = repoName?.toLowerCase() === `${owner?.toLowerCase()}.github.io`;

const site =
  process.env.ASTRO_SITE ??
  (isUserOrOrgPage ? `https://${owner}.github.io` : `https://${owner}.github.io/${repoName}`);

const base = process.env.ASTRO_BASE ?? (isUserOrOrgPage ? '/' : `/${repoName}/`);

const githubUrl = process.env.ASTRO_GITHUB_URL ?? `https://github.com/${repo}`;

export default defineConfig({
  site,
  base,
  integrations: [
    starlight({
      title: 'VMware on Microsoft Azure – Advanced Specialization',
      description:
        'Partner enablement guide for the VMware on Microsoft Azure (Azure VMware Solution) Advanced Specialization audit.',
      social: [
        {
          icon: 'github',
          label: 'GitHub',
          href: githubUrl,
        },
      ],
      sidebar: [
        { label: 'Home', link: '/' },
        { label: 'Overview', link: '/overview/' },
        { label: 'Pre-Qualification Requirements', link: '/requirements/' },
        { label: 'Audit Process', link: '/audit-process/' },
        {
          label: 'Module A – General Requirements',
          items: [{ autogenerate: { directory: 'module-a' } }],
        },
        {
          label: 'Module B – Azure VMware Solution',
          items: [{ autogenerate: { directory: 'module-b' } }],
        },
        {
          label: 'Engagement Playbook',
          items: [{ autogenerate: { directory: 'engagement' } }],
        },
        {
          label: 'Innersource',
          items: [{ autogenerate: { directory: 'innersource' } }],
        },
        { label: 'Evidence Tracker', link: '/evidence-tracker/' },
        { label: 'FAQ', link: '/faq/' },
      ],
      editLink: {
        baseUrl: `${githubUrl}/edit/main/`,
      },
    }),
  ],
});
