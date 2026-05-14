# deep-chem

> Mehrdimensionale Tiefenforschung für Chemie-, Biobasierte Materialien-, Polymer- & Biowissenschaften — Claude Code Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

[中文](README.md) | [English](README.en.md)

---

## Überblick

`deep-chem` ist die **Erweiterungsschicht für die chemische/materialbasierte Industrie & Biowissenschaften** auf Basis von `academic-search`. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung.

---

## Installation

### Voraussetzungen

| Komponente | Minimum | Hinweis |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF für Geschäftsbericht-Extraktion, Deduplizierung |
| Node.js | 18+ | CDP-Browsersteuerung (Kernabhängigkeit von academic-search) |
| PowerShell | 7+ (**nicht** 5.1) | PS 5.1 hat UTF-8-Bugs bei CJK-Text |
| Chrome / Chromium | Neueste stabile Version | Remote-Debugging-Modus (`chrome://inspect`) |

**Plattformen**: Windows 11 ✅ | macOS ✅ | Linux ✅ (WSL2 empfohlen für Windows)

### Ein-Kommando-Installation

```bash
bash <(curl -sL https://raw.githubusercontent.com/uranus421-glitch/deep-chem/master/install.sh)
```

Automatisch: Skill-Installation → academic-search → PyMuPDF → Umgebungsprüfung.

### Manuelle Installation

```bash
# 1. Skill installieren
npx skills install github:uranus421-glitch/deep-chem

# 2. CDP-Infrastruktur installieren
npx skills install github:uranus421-glitch/academic-search

# 3. Python-Abhängigkeiten installieren
pip install PyMuPDF

# 4. Umgebung prüfen
bash ~/.claude/skills/deep-chem/scripts/check-env.sh
```

### Verifizierung

Aktivieren Sie den Skill durch Nennung eines Auslösers in Claude Code:

> Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Geschäftsberichte · Biopharma · CDMO

---

## Abgedeckte Dimensionen

| Dimension | Werkzeuge/Quellen |
|------|------|
| 📚 Wissenschaftliche Literatur | OpenAlex + Google Scholar + CNKI |
| 📄 Industrielle PDFs | PyMuPDF (Geschäftsberichte / Patente) |
| 🏭 Markt & Kapazität | defuddle + WebSearch + CNKI |
| 🔬 Patente | Google Patents + CNKI-Patentdatenbank |
| 📏 Normen & Vorschriften | GB/T, ISO, EU, FDA/EMA |
| 🔗 Lieferkette | Branchenberichte + Handelsverbände |
| 🤖 KI + Materialien | OpenAlex + GS (ML-Materialdesign) |
| 🧬 Biopharma | OpenAlex + GS + CNKI (CHO/Reinigung/AI/CGT/CDMO) |

---

## 8 Arbeitsabläufe

| W# | Name | Quelle | Zweck |
|----|------|--------|------|
| W1 | OpenAlex | REST API | Neueste Arbeiten (2023+) |
| W2 | Google Scholar CDP | CDP-Browser (VPN erforderlich) | Epochenübergreifende Übersichten |
| W3 | CNKI CDP | CDP-Browser (**KEIN VPN!**) | Chinesischer Volltext + Dissertationen |
| W4 | PyMuPDF | PDF-Parser | Geschäftsbericht / Patent-Volltext |
| W5 | Multi-Quellen-Deduplizierung | Python | Drei-Quellen-Abgleich (DOI > Titel > Titel+Jahr) |
| W6 | Brancheninformationen | defuddle + scrapling | Markt / Kapazität / Lieferkette |
| W7 | Patentrecherche | Google Patents + CNKI | Technologielandschaft / Wettbewerbsanalyse |
| W8 | KI + Materialien | OpenAlex + GS | ML-Materialdesign / Polymerinformatik |

---

## Validierte Szenarien

| # | Szenario | Dimensionen | Umfang |
|---|------|------|:---:|
| 1 | PA11/PA1010 biobasiertes Polyamid 3-Quellen-Recherche | Literatur/Patente/Lieferkette/Kapazität | 50 Arbeiten |
| 2 | Huafon Chemical 241 S. Geschäftsbericht PyMuPDF | Industrie-PDF/Kapazität/Finanzen/Lieferkette | 458 KB |
| 3 | RSC Lab on a Chip OA-Papier (44c kontinuierlich) | Akademische OA/Mikrofluidik/Intelligentes DSP | 22 S. |
| 4 | Frontiers CGT 4.0 OA-Papier (4c) | Akademische OA/CGT/Automatisierungssensoren | 6 S. |
| 5 | PHA Polyhydroxyalkanoate Branchenpanorama | Literatur/Markt/Abbaunormen/Kapazität | 85 Treffer |
| 6 | KI + Polymer-Materialdesign Grenzbereich | Literatur/ML-Methoden/Materialinformatik | 291 Treffer |
| 7 | Biobasierte Materialien 3D-Kreuzanalyse | 3 Richtungen × 10 Dimensionen | 60 Arbeiten |
| 8 | Google Scholar chinesische Zitationsextraktion | „被引用次数：133" Regex | Vollbreiter Doppelpunkt |
| 9 | CNKI Direktverbindung (ohne VPN) CDP-Pipeline | KNS8-Selektoren + SSL-Umgehung | 140 Treffer |
| 10 | Windows 11 UTF-8 permanente Lösung | Python/PowerShell/Git Bash | Permanent |
| 11 | Biopharma Branchenpanorama | Literatur/Prozess/AI/Glykosylierung/CDMO | 41 Treffer |
| 12 | WuXi Biologics 263 S. Geschäftsbericht PyMuPDF | Industrie-PDF/Kapazität/Finanzen/CDMO | 5-Jahres-Finanzen |
| 13 | Samsung Biologics Finanzverifizierung | Marktübergreifende Berichte (HKEX/KRX) + Wikipedia | 2023-2024 |

---

## Bekannte Fallen (30 insgesamt, 7 Kategorien)

1. `print()` für Chinesisch → Absturz (immer in UTF-8-Datei schreiben)
2. PS 5.1 statt 7+ → Kodierungsfehler
3. CNKI + VPN → HTTP 418 (CNKI benötigt Direktverbindung)
4. CDP `/navigate` für CNKI → URL-Parameter abgeschnitten
5. GS Regex ohne vollbreiten Doppelpunkt → verfehlt alle chinesischen Ergebnisse
6. CNKI `.page-next` → Paginierung schlägt still fehl
7. GS ohne VPN (China) → nicht erreichbar

Vollständiger Katalog → [[traps-catalog]]

---

## Netzwerk-Hinweise

- **CNKI**: nur Direktverbindung (VPN löst HTTP 418 Anti-Bot aus)
- **Google Scholar** (China-Nutzer): VPN erforderlich, Proxy `socks5h://127.0.0.1:10808`
- **Internationale Nutzer**: alle Quellen direkt zugänglich
- **CDP-Proxy**: `http://127.0.0.1:3456` (Chrome Remote-Debugging-Port `9222`)

---

## Auslöser

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkettenanalyse · Technologielandschaft · Wettbewerbsanalyse · Materialpatente · KI-Materialdesign · Geschäftsberichte · Biopharma · Biosimilars · mAb · ADC · CGT · CHO-Kultur · CDMO

---

## Lizenz

MIT — [LICENSE](LICENSE)

---

*deep-chem v0.2.0 · Chemie / Biobasierte Materialien / Polymere / Biowissenschaften*
