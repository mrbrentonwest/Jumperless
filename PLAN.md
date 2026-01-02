# Plan: project-starter Template

Create a reusable project template that combines Spec-Kit's Spec-Driven Development workflow with RFC Pattern + Expiry Headers for documentation freshness.

**Repository:** `Brenton-Thriviti/project-starter`

---

## Goals

1. **Reusable Template** - Start any new project from this foundation
2. **Merged Documentation System** - Spec-Kit + RFC Pattern + Expiry Headers
3. **Doc Freshness Enforcement** - `/docs-audit` command + skill
4. **Git for Non-Technical Teams** - `/git` interactive helper
5. **Upgradeable** - Pull spec-kit updates without losing customizations
6. **Tech-Stack Agnostic** - No assumptions about what you're building

---

## Phase 1: Create Template Repository

### 1.1 Initialize with Spec-Kit (Multi-AI Support)
```bash
# Create template repo
mkdir ~/Projects/project-starter
cd ~/Projects/project-starter

# Initialize with all 6 default AI tools
specify init . --ai claude
specify init . --ai cursor-agent --force
specify init . --ai copilot --force
specify init . --ai gemini --force
specify init . --ai codex --force
specify init . --ai windsurf --force
```

**Default AI tools included:**

| Tool | AI Assistant | Commands Location |
|------|--------------|-------------------|
| `claude` | Claude Code | `.claude/commands/` |
| `cursor-agent` | Cursor | `.cursor/` |
| `copilot` | GitHub Copilot | `.github/copilot-instructions.md` |
| `gemini` | Gemini CLI | `.gemini/` |
| `codex` | OpenAI Codex CLI | `.codex/` |
| `windsurf` | Windsurf | `.windsurf/` |

Each init merges that tool's command structure while sharing the same `.speckit/` core.

### 1.2 Conflict Risks & Safe Order

**High Risk:**
| Risk | What Could Happen |
|------|-------------------|
| `.speckit/` overwrites | Each `--force` init may reset `constitution.md`, `spec.md`, `plan.md` to defaults |
| Custom commands overwritten | If you add `/docs-audit` or `/git` before all inits are done, a later init might overwrite them |

**Medium Risk:**
| Risk | What Could Happen |
|------|-------------------|
| `.github/` conflicts | Copilot writes `copilot-instructions.md` here; issue templates also live here - likely merges fine but verify |
| `.vscode/settings.json` | Multiple tools might write conflicting editor settings |

**Safe Order of Operations:**
```
1. specify init (all 6 tools)     ← Do ALL inits first
2. Customize .speckit/memory/     ← Then add your customizations
3. Add custom commands            ← /docs-audit, /git
4. Add custom skills              ← documentation-audit, git-workflow
5. Commit                         ← Lock it in
```

**Key rule:** Complete all `specify init` commands before adding any customizations.

This creates a multi-AI spec-kit structure:
```
.claude/                # Claude Code
│   └── commands/
.codex/                 # OpenAI Codex CLI
│   └── ...
.cursor/                # Cursor
│   └── ...
.gemini/                # Gemini CLI
│   └── ...
.github/
│   └── copilot-instructions.md  # GitHub Copilot
.windsurf/              # Windsurf
│   └── ...
.speckit/               # Shared core (same across all tools)
├── memory/
│   └── constitution.md
├── spec.md
├── plan.md
└── tasks.md
```

### 1.3 Add RFC Pattern + Expiry Headers

Enhance spec-kit's structure with your documentation strategy:

**Modify `.speckit/memory/constitution.md`** - Add documentation principles

**Create `.speckit/memory/documentation-strategy.md`** - Full RFC Pattern rules:
- Document types: `spec`, `gap-analysis`, `research`, `memory`
- YAML frontmatter requirements (id, type, created, status, review_by)
- Immutability rules
- Resolution protocol
- Review schedule (30/90/180 days)

**Update spec-kit templates** to include expiry headers:
```yaml
---
id: SPEC-XXX
type: spec
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
review_by: YYYY-MM-DD  # Auto-calculated
status: draft | active | deprecated
---
```

---

## Phase 2: GitHub & Project Configuration

### 2.1 GitHub Templates

**Directory:** `.github/`

```
.github/
├── ISSUE_TEMPLATE/
│   ├── bug_report.md        # Structured bug reports
│   ├── feature_request.md   # Feature proposals
│   └── config.yml           # Template chooser config
├── PULL_REQUEST_TEMPLATE.md # PR checklist
├── CODEOWNERS               # Auto-assign reviewers
└── dependabot.yml           # Dependency updates
```

### 2.2 Security & Compliance

| File | Content |
|------|---------|
| `SECURITY.md` | Vulnerability reporting process |
| `.gitignore` | Comprehensive patterns (node_modules, .env, IDE, OS files) |

*No LICENSE file - projects are private/proprietary by default.*

### 2.3 Contributor Experience

| File | Content |
|------|---------|
| `CONTRIBUTING.md` | How to contribute, links to `/git` guide |
| `docs/GETTING_STARTED.md` | New team member onboarding checklist |
| `docs/ENVIRONMENT_SETUP.md` | Dev environment requirements |

### 2.4 Editor Configuration

```
.editorconfig              # Cross-editor formatting
.vscode/
├── settings.json          # From spec-kit
└── extensions.json        # Recommended extensions
```

---

## Phase 3: Doc Freshness Command & Skill

### 3.1 Create `/docs-audit` Command

**File:** `.claude/commands/docs-audit.md`

Functionality:
- Scan all `.speckit/` documents for YAML frontmatter
- Flag documents past `review_by` date
- Report documents missing required frontmatter fields
- List gap-analysis docs that should be superseded
- Suggest cleanup actions

**Output format:**
```
## Doc Audit Report

### Expired (need review)
- .speckit/specs/001-feature/spec.md (review_by: 2025-01-01, 30 days overdue)

### Missing Frontmatter
- .speckit/specs/002-feature/notes.md (missing: id, type, review_by)

### Ready to Supersede
- .speckit/specs/003-gap-analysis/gap.md (all gaps resolved)

### Summary
- 12 documents scanned
- 2 need attention
- 1 ready for archive
```

### 3.2 Create Doc Audit Skill

**File:** `.claude/skills/documentation-audit/`

Provides context for:
- How to interpret audit results
- How to update documents properly
- Immutability rules (when NOT to edit)
- Resolution protocol steps

---

## Phase 4: Git Skills for Teams

### 4.1 Create `/git` Command

**File:** `.claude/commands/git.md`

Port from DealHubConductor with modifications:
- Interactive menu (no commands to remember)
- Options: create branch, commit, push, get latest
- Team member selection (configurable via `.speckit/memory/team.md`)
- Branch naming: `{username}/{description}`

### 4.2 Create Git Guide

**File:** `docs/GIT_GUIDE.md`

Port from DealHubConductor:
- Visual diagrams (mermaid)
- Quick reference card
- Common situations & fixes
- Works with Claude or standalone shell script

### 4.3 Shell Script Fallback

**File:** `scripts/git-helper.sh`

For when not in a Claude session - mirrors `/git` functionality.

---

## Phase 5: Upgrade Path for Spec-Kit

### 5.1 Track Customizations

**File:** `.speckit/memory/customizations.md`

Document all modifications to spec-kit defaults:
- Added frontmatter fields
- Modified templates
- Custom commands
- Custom skills

### 5.2 Upgrade Script

**File:** `scripts/upgrade-speckit.sh`

```bash
# Fetch latest spec-kit templates
# Compare with local versions
# Show diff of what would change
# Allow selective merge
```

---

## Phase 6: Template Repository Setup

### 6.1 Create GitHub Template Repo

```bash
cd ~/Projects/project-starter
gh repo create project-starter --public --source=. --push
```

Then enable as template:
- GitHub repo → Settings → General → Template repository ✓

### 6.2 Usage Instructions (README)

**From GitHub:**
```bash
gh repo create MyNewProject --template Brenton-Thriviti/project-starter --clone
cd MyNewProject
```

**Locally:**
```bash
git clone https://github.com/Brenton-Thriviti/project-starter.git MyNewProject
cd MyNewProject
rm -rf .git && git init
```

**Template includes 6 AI tools by default:**
- Claude Code, Cursor, GitHub Copilot, Gemini CLI, OpenAI Codex CLI, Windsurf

**Adding more AI tools (if needed):**
```bash
specify init . --ai qwen --force
specify init . --ai opencode --force
specify init . --ai amp --force
```

---

## File Structure (Final)

```
project-starter/
├── .claude/                     # Claude Code
│   ├── commands/
│   │   ├── docs-audit.md        # NEW: Freshness enforcement
│   │   ├── git.md               # From DealHubConductor
│   │   ├── speckit.constitution.md
│   │   ├── speckit.specify.md
│   │   ├── speckit.plan.md
│   │   ├── speckit.tasks.md
│   │   └── speckit.implement.md
│   ├── skills/
│   │   ├── documentation-audit/ # NEW: Doc audit skill
│   │   └── git-workflow/        # NEW: Git skill
│   └── settings.json
├── .codex/                      # OpenAI Codex CLI
│   └── ...
├── .cursor/                     # Cursor
│   └── ...
├── .gemini/                     # Gemini CLI
│   └── ...
├── .windsurf/                   # Windsurf
│   └── ...
├── .github/
│   ├── copilot-instructions.md  # GitHub Copilot
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── config.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── CODEOWNERS
│   └── dependabot.yml
├── .speckit/
│   ├── memory/
│   │   ├── constitution.md      # Enhanced with doc principles
│   │   ├── documentation-strategy.md  # RFC Pattern rules
│   │   ├── team.md              # Team members for /git
│   │   └── customizations.md    # Track spec-kit mods
│   ├── specs/                   # Per-feature specs (empty)
│   ├── spec.md
│   ├── plan.md
│   └── tasks.md
├── .vscode/
│   ├── settings.json            # From spec-kit
│   └── extensions.json          # Recommended extensions
├── docs/
│   ├── GIT_GUIDE.md
│   ├── GETTING_STARTED.md       # Onboarding checklist
│   └── ENVIRONMENT_SETUP.md     # Dev environment guide
├── scripts/
│   ├── git-helper.sh
│   └── upgrade-speckit.sh
├── .editorconfig                # Cross-editor formatting
├── .gitignore                   # Comprehensive ignore patterns
├── CLAUDE.md                    # AI assistant instructions
├── CONTRIBUTING.md              # How to contribute
├── README.md                    # Template usage guide
└── SECURITY.md                  # Vulnerability reporting
```

---

## Implementation Order

1. **Phase 1** - Initialize with spec-kit, add RFC Pattern + Expiry Headers
2. **Phase 2** - Add GitHub templates, security files, contributor docs, editor config
3. **Phase 3** - Create `/docs-audit` command and skill
4. **Phase 4** - Port `/git` command and guide from DealHubConductor
5. **Phase 5** - Create upgrade script for future spec-kit updates
6. **Phase 6** - Push to GitHub, enable template setting

---

## Source References

- **Spec-Kit:** https://github.com/github/spec-kit
- **RFC Pattern + Expiry Headers:** DealHubConductor `.specify/memory/documentation-strategy.md`
- **Git Command:** DealHubConductor `.claude/commands/git.md`
- **Git Guide:** DealHubConductor `docs/GIT_GUIDE.md`
