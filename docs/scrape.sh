#!/usr/bin/env bash
set -u
export FIRECRAWL_API_KEY="${FIRECRAWL_API_KEY:?set FIRECRAWL_API_KEY in env before running}"
cd "$(dirname "$0")/.." || exit 1
MAN="${1:-docs/manifest.tsv}"
TAG="$(basename "$MAN" .tsv)"
LOG="docs/_${TAG}.log"
FAIL="docs/_${TAG}_failures.tsv"
: > "$LOG"; : > "$FAIL"
rm -f docs/_test.md

run_batch() {  # wait for background jobs to drop below 2
  while [ "$(jobs -rp | wc -l)" -ge 2 ]; do sleep 1; done
}

scrape_one() {
  local g="$1" p="$2" s="$3" url="$4"
  local out="docs/$g/$p/$s.md"
  mkdir -p "docs/$g/$p"
  if [ -s "$out" ]; then echo "SKIP $out" >> "$LOG"; return 0; fi
  local a
  for a in 1 2; do
    if firecrawl scrape "$url" -o "$out" >>"$LOG" 2>&1 && [ -s "$out" ]; then
      echo "OK $out" >> "$LOG"; return 0
    fi
    sleep 3
  done
  printf '%s\t%s\t%s\t%s\n' "$g" "$p" "$s" "$url" >> "$FAIL"
  echo "FAIL $url" >> "$LOG"
}

while IFS=$'\t' read -r g p s url; do
  [ -z "${url:-}" ] && continue
  run_batch
  scrape_one "$g" "$p" "$s" "$url" &
done < "$MAN"
wait

total=$(grep -vc '^[[:space:]]*$' "$MAN")
ok=$(grep -c '^OK ' "$LOG"); skip=$(grep -c '^SKIP ' "$LOG"); fails=$(wc -l < "$FAIL" | tr -d ' ')
echo "DONE total=$total ok=$ok skip=$skip fail=$fails" | tee -a "$LOG"
