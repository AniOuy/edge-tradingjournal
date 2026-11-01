# EDGEBOOK Trading Journal

## Dateien
- `index.html`: Journal (Dashboard, Trades, Konten, Confluence-Analytics, Login-UI)
- `supabase-schema.sql`: Datenbanktabelle + Row Level Security
- `README.md`: Anleitung

## GitHub Pages
1. Repository erstellen und diese Dateien hochladen.
2. GitHub → Settings → Pages → Deploy from branch → `main` / root.
3. GitHub Pages URL abwarten.

## Supabase
Die Projekt-ID wurde bereits als Projekt-URL eingetragen:
`https://eahqzqtlorgvnfrqxjmn.supabase.co`

Noch erforderlich:
1. Supabase → Project Settings → API (oder API Keys).
2. Den `anon` / `publishable` public key kopieren.
3. In `index.html` bei `SUPABASE_ANON_KEY` den Platzhalter ersetzen.
4. `supabase-schema.sql` im Supabase SQL Editor ausführen.
5. Auth → URL Configuration: GitHub-Pages-URL als Site URL und Redirect URL erlauben.
6. Die Website neu zu GitHub hochladen.

**Wichtig:** Niemals `service_role` oder `secret` key in `index.html` oder GitHub eintragen. Nur den öffentlichen anon/publishable Key verwenden. Die Tabelle hat RLS-Regeln, sodass angemeldete Nutzer nur ihre eigene Zeile lesen und ändern können.

## Funktionen
- Mehrere Konten / getrennte Auswertungen
- Trade-Log mit Entry, SL, TP, R-Ergebnis, Bias, Session, Notizen und Lernpunkten
- Confluences: 1x OTE, 2x OTE, Double OTE, Standard Deviations, POC/VAH/VAL, Absorption, Wick Reaction, CHoCH/BOS, Midnight Open, 8 AM Open, 12 PM Open
- Winrate, Expectancy, Profit Factor, Netto-R, Equity-Kurve
- Confluence- und Kombinationsstatistiken
- CSV/JSON Backup und Import

## Grenzen
Cloud-Sync ist ein einfacher manueller Sync. Nicht gleichzeitig auf mehreren Geräten editieren, sonst können Änderungen überschrieben werden. Screenshots sind aktuell als URL/Notiz gedacht; privater Bild-Upload ist nicht implementiert. Kennzahlen sind rückblickend und keine Prognosen oder Garantien. Bei kleinen Stichproben sind Prozentwerte sehr unsicher. No-Fills/hypothetische Trades getrennt von tatsächlich ausgeführten Paper-Trades auswerten.

Für Lernzwecke und Paper-Trading gedacht. Minderjährige sollten Cloud-Konten nur mit Unterstützung/Zustimmung eines Erziehungsberechtigten gemäß Anbieterbedingungen einrichten.
