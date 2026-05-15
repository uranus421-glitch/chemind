# synthon

> **Rohdaten rein, strukturierte Industrie-Insights raus — eine 12-dimensionale Deep-Research-Engine.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.3.0-green)]()

[中文](README.md) | [English](README.en.md)

---

## Was ist synthon?

In der organischen Chemie ist ein **Synthon** die kleinste Struktureinheit, die kombiniert ein komplexes Molekül aufbaut. In der Industrieforschung ist jeder Workflow in synthon ein Baustein — Literatur, Patente, Finanzen, Lieferketten, Vorschriften — die zusammen ein vollständiges, mehrdimensionales Bild eines Unternehmens, Marktes oder einer Technologie ergeben.

synthon ist die Industrie-Intelligence-Schicht auf Basis von [academic-search](https://github.com/coeus-io/academic-search). Wo academic-search in der Literaturrecherche glänzt, erweitert synthon in jede Dimension der realen Industrieforschung: von Geschäftsbericht-Finanzdaten bis zur Lieferkettenkartierung, von Patentlandschaften bis zum Wettbewerbs-Benchmarking.

---

## Architektur

```
┌─────────────────────────────────────────────────────────┐
│                    synthon v0.3.0                        │
│          Industrie-Intelligence-Schicht                   │
│                                                         │
│  W1-W3     W4-W5    W6-W8        W9-W12                │
│  Literatur PDF      Unternehmens Investment             │
│  Suche     Pipeline Intelligence Research               │
│  ───────   ────────  ───────────  ────────────          │
│  OpenAlex  PyMuPDF   Sogou        AKShare               │
│  GS CDP    Dedup     Patente      SEC EDGAR             │
│  CNKI CDP  Scraping  KI+Industrie Lieferkette           │
│                      (7 Domänen)  Vorschriften          │
│                                   Cluster (13 Parks)    │
├─────────────────────────────────────────────────────────┤
│                 academic-search                          │
│          CDP-Infrastruktur                               │
│      Chrome DevTools · Proxy · VPN-Routing              │
└─────────────────────────────────────────────────────────┘
```

12 Arbeitsabläufe in 4 Funktionsgruppen, auf CDP-Infrastruktur von academic-search.

---

## Ausprobieren

Einfach Claude Code fragen — synthon aktiviert sich automatisch:

```bash
# Unternehmens-Tiefenanalyse
"Analysiere Wanhua Chemical — Kapazität, Geschäftsbericht, Lieferkette, Wettbewerber"

# Technologielandschaft
"Literaturübersicht zu Festkörperbatterien — neueste Fortschritte"

# Investment-Vergleich
"CATL vs BYD: Finanzkennzahlen im Vergleich"

# Lieferketten-Mapping
"PU-Harz-Lieferkette: Upstream-Rohstoffe und Downstream-Anwendungen"

# Regulierungspfad
"IND-Antragsverfahren für innovative Arzneimittel in China"
```

---

## 12 Arbeitsabläufe

### Gruppe 1: Literatur & Patente

| W# | Workflow | Beschreibung |
|----|----------|-------------|
| W1 | **OpenAlex** | Neueste englische Arbeiten (2023+), REST API — kein VPN, sofort |
| W2 | **Google Scholar CDP** | Epochenübergreifende hochzitierte Übersichten via CDP-Browser |
| W3 | **CNKI CDP** | Chinesischer Volltext + Dissertationen — **KEIN VPN verwenden!** |

### Gruppe 2: PDF & Unternehmensintelligenz

| W# | Workflow | Beschreibung |
|----|----------|-------------|
| W4 | **PyMuPDF** | Geschäftsbericht-/Patent-Volltextextraktion, 500+ Seiten |
| W5 | **Merge & Dedup** | Drei-Quellen-Abgleich (DOI > Titel > Titel+Jahr) |
| W5b | **Geschäftsbericht-Scraping** | A-Aktien (Eastmoney) / HKEX / SEC EDGAR Batch-Download, 4-Pfad-Fallback |
| W6 | **Sogou Unternehmenssuche** | Chinesische Unternehmensnachrichten, Branchendynamik, Uni-Kooperationen |
| W7 | **Patentrecherche** | Google Patents CDP + CNKI-Patentdatenbank |
| W8 | **KI + Industrie** | 7 Subdomänen: Materialien · Pharma · Chemie · Energie · Landwirtschaft · Kosmetik · Investment |

### Gruppe 3: Investment & Strategie

| W# | Workflow | Beschreibung |
|----|----------|-------------|
| W9 | **Investmentanalyse** | AKShare A-Aktien-Finanzen + SEC 10-K + Wettbewerbs-Benchmarking |
| W10 | **Vorschriftenrecherche** | 10 Regulierungsbehörden × 6 Domänenmatrizen (GB/T, ISO, FDA, EMA, NMPA…) |
| W11 | **Lieferketten-Mapping** | UN Comtrade API + Upstream/Midstream/Downstream |
| W12 | **Industriecluster** | 13 Referenzparks in 7 Ländern + Fördermittel |

---

## Domänenabdeckung

10 Industriedimensionen, jede mit verifizierter Werkzeugkette:

| Dimension | Werkzeuge | Verifiziert |
|------|------|:---:|
| 📚 Wissenschaftliche Literatur | OpenAlex + GS + CNKI → 3-Quellen-Dedup | ✅ 19 Szenarien |
| 📄 Industrielle PDFs | PyMuPDF → strukturierte Finanzdaten | ✅ 2 Geschäftsberichte |
| 🏭 Markt & Kapazität | Sogou + Geschäftsberichte + Regierungsseiten | ✅ 3 Unternehmen |
| 🔬 Patente | Google Patents CDP + CNKI-Patentdatenbank | ✅ W7-Pipeline |
| 📏 Normen & Vorschriften | 10 Regulierungsbehörden × 6 Domänenmatrizen | ✅ W10-Pipeline |
| 🔗 Lieferkette | UN Comtrade + Sogou + Geschäftsberichte | ✅ PU-Harz-Kette |
| 🤖 KI + Industrie | 7 Subdomänen in allen Branchen | ✅ W8-Pipeline |
| 💰 Investment | AKShare + SEC EDGAR + HKEX CDP | ✅ 3 A-Aktien-Unternehmen |
| 🏗️ Industriecluster | 13 Parks in 7 Ländern | ✅ W12-Referenztabelle |
| 🧬 Biopharma | Literatur + Prozess + KI + Glykosylierung + CDMO | ✅ 3 Szenarien |

---

## Praxisvalidierung

Jeder Workflow gegen reale Daten validiert:

| # | Szenario | Daten | Schlüsselerkenntnis |
|---|------|:---:|------|
| 1 | PA11/PA1010 biobasiertes Polyamid | 50 Arbeiten | 3-Quellen-Literatur-Pipeline |
| 2 | BASF Geschäftsbericht 2024 | ~280 S. | Finanz- & Kapazitätsextraktion + Verbund |
| 5 | PHA-Branchenpanorama | 85 Treffer | Literatur + Markt + Abbaunormen |
| 6 | KI + Polymer-Materialdesign | 291 Treffer | Branchenübergreifendes ML-Frontier-Mapping |
| 11 | Biopharma-Branchenpanorama | 41 Arbeiten | CHO/Reinigung/CGT/CDMO |
| 14 | Sogou-Unternehmenssuche | 3 Unternehmen | Chinesische Unternehmensnachrichten-Pipeline |
| 17 | Festkörperbatterie-Landschaft | Lit + Nachrichten | Akademische + Industrie-Kreuzvalidierung |
| 18 | Alternative-Protein-Markt | Akademisch + Investment | Food-Tech-Mehrdimensionalität |
| 19 | Aktivpeptid-Kosmetik-Rohstoffe | Lit + Unternehmen | Kosmetik-Rohstoff-Pipeline |

Alle 19 validierten Szenarien: [SKILL.md](SKILL.md).

---

## Fallen & Fallstricke

53 dokumentierte Fallen in 16 Kategorien — jede mit Ursache und Lösung. Industrieforschung scheitert auf vorhersehbare Weise. Diese haben wir bereits dokumentiert und gelöst:

| Häufigste Fallen |
|------|
| `print()` Chinesisch → Absturz (in UTF-8-Datei schreiben) |
| PS 5.1 zerstört chinesische Klammer-Syntax (PS 7+ verwenden) |
| CNKI + VPN = HTTP 418 (nur Direktverbindung) |
| AKShare-Spaltennamen ändern sich zwischen Versionen |
| Eastmoney PDF API liefert leere Antwort (Multi-Pfad-Fallback) |
| Sogou CSS-Selektor-Klassen-Varianten |

Vollständiger Katalog → [traps-catalog.md](references/traps-catalog.md)

---

## Installation

### Voraussetzungen

| Komponente | Min | Für |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF, akshare, secedgar |
| Node.js | 18+ | CDP-Browsersteuerung |
| PowerShell | 7+ (**nicht** 5.1) | Windows UTF-8-Kompatibilität |
| Chrome | Neueste | Remote-Debugging (`chrome://inspect`) |

### Ein-Kommando

```bash
bash <(curl -sL https://raw.githubusercontent.com/coeus-io/synthon/master/install.sh)
```

### Schrittweise

```bash
npx skills install github:coeus-io/synthon
npx skills install github:coeus-io/academic-search
python3 -m pip install PyMuPDF akshare secedgar defuddle requests
bash ~/.claude/skills/synthon/scripts/check-env.sh
```

---

## Netzwerk

| Quelle | Zugriff aus China | Methode |
|--------|:---:|------|
| OpenAlex | ✅ Direkt | `curl` REST API |
| Sogou | ✅ Direkt | `curl` HTML-Extraktion |
| CNKI | ✅ Direkt (**KEIN VPN!**) | CDP-Browser |
| Google Scholar | 🚧 VPN erforderlich | CDP-Browser + Proxy |
| Google Patents | 🚧 VPN erforderlich | CDP-Browser + Proxy |
| SEC EDGAR | 🚧 VPN erforderlich | `secedgar`-Bibliothek |
| UN Comtrade | ✅ Direkt | `curl` API |

---

## Verwandt

| Ressource | Beschreibung |
|------|------|
| [academic-search](https://github.com/coeus-io/academic-search) | CDP-Infrastruktur, auf der dieser Skill aufbaut |
| [SKILL.md](SKILL.md) | Vollständige Skill-Definition & Workflow-Referenz |
| [traps-catalog.md](references/traps-catalog.md) | 53 dokumentierte Fallen (16 Kategorien) |

---

## Lizenz

MIT — [LICENSE](LICENSE)

---

*synthon v0.3.0 · Aufgebaut auf academic-search · Chemie / Materialien / Biopharma / Lieferkette / Investment — 12-Dimensionen Industrie-Tiefenforschungs-Engine*
