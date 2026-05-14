# PyMuPDF Industrial PDF Extraction Guide

> Extracting text from annual reports, patents, and non-academic PDFs with PyMuPDF (fitz).

## Installation

```bash
pip install PyMuPDF
```

## Standard Extraction Template

```python
import fitz
import os
import tempfile

pdf_path = "annual_report.pdf"
doc = fitz.open(pdf_path)

# Write to temp file — NEVER print() Chinese to console
out_path = os.path.join(tempfile.gettempdir(), 'pdf_output.txt')
with open(out_path, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        text = doc[i].get_text()
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(text)

doc.close()
print(f"Extracted {len(doc)} pages to {out_path}")  # Only print ASCII
```

## Performance Benchmarks

| PDF Type | Pages | Output Size | Extraction Time |
|----------|-------|-------------|-----------------|
| Annual report (上市公司年报) | 241 | ~458 KB | < 10 seconds |
| Academic paper (知网) | 12 | ~45 KB | < 1 second |
| Patent document | 30-80 | ~120-300 KB | 2-5 seconds |

## Key Differences: Industrial vs Academic PDFs

| Feature | Academic PDF | Industrial PDF (年报/专利) |
|---------|-------------|--------------------------|
| TOC (`doc.get_toc()`) | Usually present | **Almost never** |
| Text layer | OCR or born-digital | Usually born-digital (faster) |
| Tables | Simple, extractable | Complex merged cells, needs `fitz.Table` |
| Images | Embedded figures | Charts, scanned stamps, QR codes |
| Multi-column | Rare | Common in financial sections |

## Handling Large PDFs (500+ pages)

```python
import fitz

doc = fitz.open("large_report.pdf")
out_path = "/tmp/large_output.txt"

with open(out_path, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        # Extract and write page-by-page — don't accumulate in memory
        text = doc[i].get_text()
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(text)
        f.flush()  # Force write to disk

doc.close()
```

## Table Extraction (Optional)

```python
for page in doc:
    tables = page.find_tables()
    for table in tables:
        data = table.extract()
        # data is a 2D list of cell contents
```

## Common Pitfalls

1. **Never `print()` Chinese PDF text** — always write to UTF-8 file
2. **Annual reports lack TOC** — don't rely on `doc.get_toc()`, use text pattern matching for sections
3. **Scanned PDFs have no text layer** — PyMuPDF won't help; use OCR (Tesseract) instead
4. **Password-protected PDFs** — use `fitz.open(path, password='...')`

---

*Last validated: 2026-05-14 | PyMuPDF 1.24+ | Annual reports from Chinese stock exchanges*
