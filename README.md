# foxdock-editor

The `editor` plugin of FoxDock, the plugin system for the Visual FoxPro 9 IDE. Small utilities for the code editor: a new GUID on the clipboard or at the cursor.

> Also in Spanish ([README_ES.md](README_ES.md)) and German ([README_DE.md](README_DE.md)).

## Install

You need FoxDock and [FoxPack](https://irwinrodriguez.dev/products/foxpack).

- In FoxDock: **FoxDock > Plugins > Plugin center...**, **Available**, choose `editor` and press **Install**.
- From a console: `foxpack plugin add editor`.

If `editor` came with your FoxDock installer, the plugin center shows its new versions in **Updates**.

## The `editor` package

**FoxDock > Editor** gathers the small tools for the program editor, as modules of one plugin (§ 13).
Today it has one, `guid`, with two bars:
- **Create GUID** (`ALT+G`; another key, or none, with `"keys": { "editor.CreateGuid": "CTRL+K" }` in
  `config.json`, or `""`) puts a new GUID on the clipboard, and the notice at the top right of VFP shows it. It comes in
  lower case and without braces (`3af9df3c-b3ac-42b0-8a87-38620462676f`); for another format, the options
  below.
- **Insert GUID at cursor** writes it where the cursor is, in the editor in front. **F11** does the same
  with an editor in front (§ 5).

The options go in `"options": { "editor": { "guid": { ... } } }`:

| Option | Default | |
|---|---|---|
| `enabled` | `.T.` | `.F.` switches the module off: no bars, no `F11` |
| `upper` | `.F.` | in lower case; `.T.` writes it in capitals |
| `braces` | `.F.` | without braces; `.T.` puts `{}` around it |

Up to 0.9.5 this was the `guid` plugin, and its options went in `"options": { "guid": { ... } }`. If only
those are there, FoxDock reads them and the log says so: move them to `editor` when you can.

It has no tools for the agent.

## About this manual

This text is the section about `editor` of the FoxDock plugin manual. The references to other sections (§) and to AGENT-TOOLS point to the documents FoxDock installs in its `docs` folder.

## License

MIT. See [LICENSE](LICENSE).
