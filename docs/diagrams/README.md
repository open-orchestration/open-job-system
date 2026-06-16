# Architecture Diagrams

Rendered PNGs of the Jobs System architecture, exported from a single Figma design file. Embedded throughout the docs; this folder is the source of truth for the images.

**Figma source:** [Jobs System — Architecture](https://www.figma.com/design/fQQVHCikSbfb634V8j5msK/Jobs-System---Architecture) · file key `fQQVHCikSbfb634V8j5msK`

| PNG | Frame node | Shown in |
|---|---|---|
| `01-two-tier.png` | `1:2` | `ARCHITECTURE.md` §2.2 |
| `02-hexagonal-ports.png` | `4:2` | `ARCHITECTURE.md` §3 |
| `03-scope-hierarchy.png` | `6:2` | `GLOSSARY.md` §2.0 |
| `04-lifecycle-state-machine.png` | `7:2` | `ARCHITECTURE.md` §2.1 |
| `05-key-flows.png` | `14:2` | `ARCHITECTURE.md` §8 |
| `06-data-er.png` | `16:2` | `DATA-STRATEGY.md` §2 |
| `07-resumability.png` | `19:2` | `ARCHITECTURE.md` §14 |

## Regenerating / adding diagrams

These are built and updated via the Figma MCP. The full workflow — style system, build helpers, the connector-alignment gotcha, dot-grid/icon recipes, and the export-and-embed procedure — lives in the **`jobs-system-diagrams`** skill (`~/.claude/skills/jobs-system-diagrams/SKILL.md`).

To refresh after editing in Figma: re-export the frame (`get_screenshot`) and overwrite the matching PNG here — filenames are stable, so the markdown references keep working.
