# Legacy research corpus

The prior scraped-catalog research setup, kept as **source material** for re-research
through the Open Research System plugin. New research lives in `../.research/`; authored
guides live in `../docs/`.

- `RESEARCH-CATALOG.md` — the 17-category taxonomy and sources to mine.
- `NN-*/` — gathered source material per category (scraped vendor docs).
- `patterns/` — pattern references (AWS builder library, microservices.io).
- `manifest*.tsv`, `_*_failures.tsv`, `*.log`, `scrape.sh` — scrape bookkeeping.
- `graphify-out/` — knowledge graph of the old corpus.

Feed these into ORS runs (e.g. drop into `ingest/`, or cite per topic) until the new
`.research/` corpus reaches parity; do not extend this directory further.
