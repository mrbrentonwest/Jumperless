# Claude Code Instructions

## Getting Started

### What is Jumperless?
Jumperless V5 is a hardware development platform - an "IDE for hardware" with an RP2350B microcontroller. It combines a breadboard with built-in test equipment and software-controlled wiring.

**Key Hardware Features:**
- Four individually programmable ±8V power supplies
- Ten GPIO pins and seven management channels
- RGB LEDs under each breadboard hole for circuit visualization
- Software-defined jumper connections between any two points
- Onboard multimeter, oscilloscope, function generator, and logic analyzer

### Documentation
- **Official Docs:** https://jumperless-docs.readthedocs.io/en/latest/
- **App Docs:** https://jumperless-docs.readthedocs.io/en/latest/03-app/
- **GitHub (App):** https://github.com/Architeuthis-Flux/Jumperless-App
- **GitHub (Hardware):** https://github.com/Architeuthis-Flux/JumperlessV5

### Running the App
```bash
# Full path (if not in PATH)
/Library/Frameworks/Python.framework/Versions/3.13/bin/jumperless

# Or add to PATH and run directly
jumperless
```

**Version:** 1.1.1.15
**Data Directory:** `/Users/brenton/Projects/Jumperless/Data` (symlinked from package)

### Installation (already done)
```bash
pip install jumperless
```

The app auto-installs `arduino-cli` and `avrdude` on first startup.

---

## Project Type
This is a **project template** for starting new projects with Spec-Driven Development.

## Key Files
- `.specify/memory/constitution.md` - Project principles
- `.specify/memory/documentation-strategy.md` - RFC Pattern + Expiry Headers rules
- `.specify/memory/team.md` - Team roster for `/git` command
- `.specify/memory/customizations.md` - Track spec-kit modifications

## Custom Commands
- `/docs-audit` - Scan documentation for freshness and compliance
- `/git` - Interactive git workflow helper

## Documentation Standards
All documents in `.specify/` must include YAML frontmatter with:
- `id`, `type`, `created`, `last_updated`, `review_by`, `status`

Review intervals:
- spec: 90 days
- gap-analysis: 30 days
- research: 180 days
- memory: 90 days

## Immutability Rules
- `spec`, `gap-analysis`, `research` are immutable after approval
- Updates create superseding documents
- `memory` documents are mutable

## Branch Naming
Format: `{username}/{description}`
Team roster in `.specify/memory/team.md`
