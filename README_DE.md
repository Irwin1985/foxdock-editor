# foxdock-editor

Das Plugin `editor` für FoxDock, das Plugin-System für die IDE von Visual FoxPro 9. Kleine Hilfen für den Programmeditor: eine neue GUID in der Zwischenablage oder an der Cursorposition.

> Auch auf Englisch ([README.md](README.md)) und Spanisch ([README_ES.md](README_ES.md)).

## Installieren

Sie brauchen FoxDock und [FoxPack](https://irwinrodriguez.dev/products/foxpack).

- In FoxDock: **FoxDock > Plugins > Plugin-Center...**, **Verfügbar**, `editor` auswählen und **Installieren** drücken.
- Von der Konsole: `foxpack plugin add editor`.

Wenn `editor` mit Ihrem FoxDock-Installer kam, zeigt das Plugin-Center seine neuen Versionen unter **Aktualisierungen**.

## Das Paket `editor`

**FoxDock > Editor** sammelt die kleinen Werkzeuge für den Programm-Editor, als Module eines einzigen
Plugins (§ 13). Heute hat es eines, `guid`, mit zwei Menüpunkten:
- **GUID erstellen** (Create GUID) (`ALT+G`; eine andere Taste, oder keine, mit `"keys": { "editor.CreateGuid": "CTRL+K" }`
  in `config.json`, oder `""`) legt eine neue GUID in die Zwischenablage, und der Hinweis oben rechts in VFP zeigt sie an.
  Sie kommt in Kleinbuchstaben und ohne Klammern (`3af9df3c-b3ac-42b0-8a87-38620462676f`); für ein anderes
  Format die Optionen unten.
- **GUID am Cursor einfügen** (Insert GUID at cursor) schreibt sie an die Stelle des Cursors, im Editor im Vordergrund. **F11** tut
  dasselbe, wenn ein Editor im Vordergrund ist (§ 5).

Die Optionen stehen in `"options": { "editor": { "guid": { ... } } }`:

| Option | Standard | |
|---|---|---|
| `enabled` | `.T.` | `.F.` schaltet das Modul ab: keine Menüpunkte, kein `F11` |
| `upper` | `.F.` | in Kleinbuchstaben; `.T.` schreibt sie in Großbuchstaben |
| `braces` | `.F.` | ohne geschweifte Klammern; `.T.` setzt `{}` darum |

Bis 0.9.5 war das das Plugin `guid`, und seine Optionen standen in `"options": { "guid": { ... } }`. Wenn
nur diese da sind, liest FoxDock sie, und das Protokoll meldet es: verschieben Sie sie zu `editor`, wenn
Sie können.

Es hat keine Tools für den Agenten.

## Über dieses Handbuch

Dieser Text ist der Abschnitt über `editor` aus dem Plugin-Handbuch von FoxDock. Die Verweise auf andere Abschnitte (§) und auf AGENT-TOOLS zeigen auf die Dokumente, die FoxDock in seinem Ordner `docs` installiert.

## Lizenz

MIT. Siehe [LICENSE](LICENSE).
