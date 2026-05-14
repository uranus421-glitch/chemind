# deep-chem

> **Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymerindustrie**
>
> *化工 / 生物基材料 / 聚合物产业的多维度深度研究*
>
> *Chemical / Bio-Based Materials / Polymer Industry Multi-Dimensional Deep Research*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

---

## Positionierung / 定位 / Positioning

`deep-chem` ist die **Erweiterungsschicht für die chemische/materialbasierte Industrie** auf Basis von `academic-search`. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung.

`deep-chem` 是 `academic-search` 的化工材料产业增强层。`deep-chem` is the chemical/materials industry enhancement layer on top of `academic-search`.

---

## Abgedeckte Dimensionen / 覆盖维度 / Dimensions

| Dimension | Werkzeuge/Quellen |
|------|------|
| 📚 Wissenschaftliche Literatur | OpenAlex + Google Scholar + CNKI |
| 📄 Industrielle PDFs | PyMuPDF (Geschäftsberichte, Patente) |
| 🏭 Markt/Kapazität | defuddle + WebSearch + CNKI |
| 🔬 Patente | Google Patents + CNKI-Patentdatenbank |
| 📏 Normen/Vorschriften | GB/T, ISO, EU, China-Kunststoffverbot |
| 🔗 Lieferkette | Branchenberichte + Verbände + Geschäftsberichte |
| 🤖 KI + Materialien | OpenAlex + GS (KI-gestütztes Materialdesign) |

---

## Schnellstart / 快速开始 / Quick Start

```bash
npx skills install github:uranus421-glitch/deep-chem
bash scripts/check-env.sh
pip install PyMuPDF
npx skills install github:uranus421-glitch/academic-search
```

---

## Auslöser / 触发词 / Triggers

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkettenanalyse · Technologielandschaft · Materialpatente · KI-Materialdesign · Geschäftsberichte · Industrienormen

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报

Chemical industry research · bio-based materials · polymer market · production capacity · supply chain · technology landscape · patents · AI materials design · annual reports

---

## 8 Arbeitsabläufe / 8 个工作流 / 8 Workflows

| W# | Name | Quelle | Dimension |
|----|------|--------|----------|
| W1 | OpenAlex | REST API | Neueste Arbeiten (2023+) |
| W2 | Google Scholar CDP | CDP Browser (VPN in China) | Hochzitierte Übersichten |
| W3 | CNKI CDP | CDP Browser (KEIN VPN!) | Chinesischer Volltext + Dissertationen |
| W4 | PyMuPDF | PDF Parser | Geschäftsberichte/Patent-Extraktion |
| W5 | Merge & Dedup | Python | Drei-Quellen-Deduplizierung |
| W6 | Industrie-Intel | defuddle + scrapling | Markt/Kapazität/Lieferkette |
| W7 | Patentrecherche | Google Patents + CNKI | Technologielandschaft |
| W8 | KI + Materialien | OpenAlex + GS | KI-Materialdesign |

---

## Validierte Szenarien / 已验证场景 / Validated Scenarios

| # | Szenario | Dimensionen | Daten |
|---|------|------|:---:|
| 1 | PA11/PA1010 biobasiertes Polyamid Drei-Quellen-Recherche | Literatur/Patente/Lieferkette/Kapazität | 50 Arbeiten |
| 2 | Huafon Chemical 241-Seiten Geschäftsbericht PyMuPDF-Extraktion | Industrie-PDF/Kapazität/Finanzen/Lieferkette | 458KB Text |
| 3 | PHA Polyhydroxyalkanoate Branchenpanorama | Literatur/Markt/Abbaunormen/Kapazität/Ökosystem | 85 Treffer |
| 4 | KI + Polymer-Materialdesign Grenzbereich | Literatur/ML-Methoden/Materialinformatik/Industrie | 291 Treffer |
| 5 | Biobasierte Materialien Branchenpanorama 3D-Kreuzanalyse | 3 Richtungen × 10 Dimensionen | 60 Arbeiten + Kapazität + Normen + TRL |
| 6 | Google Scholar chinesische Zitationsextraktion | „被引用次数：133" Regex | Vollbreiter Doppelpunkt Regex |
| 7 | CNKI Direktverbindung (ohne VPN) CDP-Pipeline | KNS8-Selektoren + SSL-Umgehung | 140 Treffer |
| 8 | Windows 11 UTF-8 permanente Lösung | Python/PowerShell/Git Bash | Permanente Lösung |

---

## Bekannte Fallen / 已知陷阱 / Known Traps

**30 katalogisierte Fallen** (7 Kategorien). Siehe [[traps-catalog]].

| Tödlichste / Most Fatal / 最致命 |
|---|
| 1. `print()` Chinesisch → Absturz |
| 2. PS 5.1 statt 7+ → Kodierungsfehler |
| 3. CNKI + VPN → HTTP 418 Blockierung |
| 4. CDP `/navigate` für CNKI → URL-Parameter abgeschnitten |
| 5. GS Regex ohne vollbreiten Doppelpunkt → verpasst chinesische Ergebnisse |
| 6. CNKI `.page-next` → Paginierung schlägt still fehl |
| 7. GS ohne VPN (China) → nicht erreichbar |

---

## Netzwerk-Hinweise / 网络说明 / Network Notes

- **CNKI**: MUSS Direktverbindung nutzen — VPN löst HTTP 418 Anti-Bot aus
- **Google Scholar** (aus China): VPN erforderlich — `socks5h://127.0.0.1:10808`
- **Internationale Nutzer**: Alle Quellen direkt zugänglich

---

## Lizenz / 许可证 / License

MIT — [LICENSE](LICENSE)

---

*deep-chem v0.2.0 · Chemie/Biobasiert/Polymere · 化工/生物基/聚合物 · Chemical/Bio-Based/Polymer*
