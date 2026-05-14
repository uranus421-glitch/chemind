# Multi-Source Merge & Deduplication

> Merging results from OpenAlex, Google Scholar, and CNKI into a single deduplicated list.

## The Problem

When searching the same topic across three sources (OpenAlex, Google Scholar, CNKI), many papers overlap. Without dedup, you get 3 copies of the same paper in your final notes.

## Dedup Priority Chain

Papers are matched by **descending reliability**:

1. **DOI** — most reliable, but CNKI papers often lack DOIs
2. **Title (first 80 chars, lowercased)** — good fallback for Chinese papers
3. **Title + Year** — last resort for edge cases

## Python Implementation

```python
import json

def merge_papers(*sources):
    """
    Merge multiple source lists, deduplicating by DOI > title[:80] > title+year.
    
    Args:
        sources: One or more lists of paper dicts.
                 Each dict should have: doi (optional), title (required), year (optional), cites (optional)

    Returns:
        Sorted list of unique papers, highest citations first.
    """
    all_papers = []
    seen_keys = set()

    for source in sources:
        for paper in source:
            # Build dedup key with fallback chain
            key = (
                paper.get('doi')
                or (paper.get('title', '')[:80].lower())
                or f"{paper.get('title', '')}_{paper.get('year', '')}"
            )
            if key not in seen_keys:
                seen_keys.add(key)
                all_papers.append(paper)

    # Sort by citation count (descending)
    # Source priority: GS > CNKI > OpenAlex (already handled during extraction)
    all_papers.sort(key=lambda p: p.get('cites', 0), reverse=True)

    return all_papers


# Usage example
if __name__ == '__main__':
    # Load from individual source JSON files
    with open('openalex_results.json', 'r', encoding='utf-8') as f:
        oa = json.load(f)

    with open('gs_results.json', 'r', encoding='utf-8') as f:
        gs = json.load(f)

    with open('cnki_results.json', 'r', encoding='utf-8') as f:
        cnki = json.load(f)

    merged = merge_papers(oa, gs, cnki)

    # Write final output
    with open('merged_results.json', 'w', encoding='utf-8') as f:
        json.dump(merged, f, ensure_ascii=False, indent=2)

    print(f"Merged: {len(oa)}+{len(gs)}+{len(cnki)} → {len(merged)} unique papers")
```

## Citation Count Normalization

Different sources report different citation counts for the same paper:

| Source | Count Type | Scale |
|--------|-----------|-------|
| Google Scholar | All citations (includes preprints, theses) | **Highest** |
| CNKI | Chinese citations only | Medium |
| OpenAlex | Academic citations only | Lower |

**Strategy**: Sort by Google Scholar count when available, falling back to CNKI then OpenAlex.

## Output Format

Each merged paper record:

```json
{
  "title": "Long-chain bio-based polyamide 11: A review",
  "doi": "10.1016/j.progpolymsci.2024.101234",
  "year": 2024,
  "cites": 45,
  "source": ["openalex", "google_scholar"],
  "oa_url": "https://doi.org/10.1016/j.progpolymsci.2024.101234",
  "authors": ["Zhang, W.", "Li, H."],
  "journal": "Progress in Polymer Science"
}
```

---

*Last validated: 2026-05-14 | Used in production for PA11/PA1010 literature survey*
