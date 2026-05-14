# Google Scholar Chinese Citation Extraction

> How to reliably extract citation counts from Google Scholar when using the Chinese interface (`hl=zh-CN`).

## The Problem

Google Scholar's citation count rendering depends on the interface language:

| Language | Citation Label | Regex |
|----------|---------------|-------|
| English | `Cited by 133` | `/Cited by (\d+)/` |
| Chinese | `被引用次数：133` | Full-width colon! |

The Chinese interface uses a **full-width colon** (`：`, U+FF1A), not ASCII colon (`:`). Most regex patterns fail because they only match ASCII.

## Reliable Regex

```python
import re

CITE_PATTERNS = [
    # Chinese interface (full-width colon)
    r'被引用次数[：:]\s*(\d+)',
    # English interface
    r'Cited by (\d+)',
    # Fallback: any digits after "引用"
    r'引用\D*(\d+)',
]

def extract_citations(text: str) -> int:
    for pattern in CITE_PATTERNS:
        m = re.search(pattern, text)
        if m:
            return int(m.group(1))
    return 0
```

## CDP Extraction Strategy

1. In CDP `eval`, extract raw `textContent` of each result row (no filtering)
2. In Python, run regex on each row's text
3. Sort by extracted citation count

```bash
# CDP eval (browser side) — extract raw text only
curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll(".gs_r.gs_or.gs_scl")).map(el => ({
  allText: el.textContent.slice(0, 600)
})))
' -o results.json
```

```python
# Python side — parse with regex
import json, re

with open('results.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

items = json.loads(data['value'])
for item in items:
    text = item.get('allText', '')
    cite = re.search(r'被引用次数[：:]\s*(\d+)', text)
    cites = int(cite.group(1)) if cite else 0
    year = re.search(r'\b(20\d{2})\b', text)
    print(f'[{cites}c] ({year.group(1) if year else "?"}) {text[:80]}...')
```

## Why NOT Filter in CDP eval

```javascript
// ❌ BROKEN in CDP eval context:
items.filter(t => t.includes("引用"))  // Returns [] due to Unicode serialization issues

// ✅ DO THIS instead:
// Extract raw text in CDP, filter in Python on the host side
```

## URL Tip

Force Chinese interface for consistent parsing across sessions:

```
https://scholar.google.com/scholar?q=KEYWORD&hl=zh-CN&as_ylo=2023
```

Or force English:

```
https://scholar.google.com/scholar?q=KEYWORD&hl=en&as_ylo=2023
```

---

*Last validated: 2026-05-14 | GS HTML structure subject to change without notice*
