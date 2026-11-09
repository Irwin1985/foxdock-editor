# foxdock-editor

El plugin `editor` de FoxDock, el sistema de plugins para el IDE de Visual FoxPro 9. Utilidades pequeñas del editor de programas: un GUID nuevo en el portapapeles o en el cursor.

> También en inglés ([README.md](README.md)) y en alemán ([README_DE.md](README_DE.md)).

## Instalar

Hacen falta FoxDock y [FoxPack](https://irwinrodriguez.dev/products/foxpack).

- En FoxDock: **FoxDock > Plugins > Centro de plugins...**, **Disponibles**, elige `editor` y pulsa **Instalar**.
- Desde una consola: `foxpack plugin add editor`.

Si `editor` vino con tu instalador de FoxDock, el centro de plugins enseña sus versiones nuevas en **Actualizaciones**.

## El paquete `editor`

**FoxDock > Editor** reúne las utilidades pequeñas del editor de programas, como módulos de un solo
plugin (§ 13). Hoy tiene uno, `guid`, con dos barras:
- **Crear GUID** (Create GUID) (`ALT+G`; otra tecla, o ninguna, con `"keys": { "editor.CreateGuid": "CTRL+K" }` en
  `config.json`, o `""`) deja un GUID nuevo en el portapapeles, y el aviso de arriba a la derecha de VFP lo enseña. Sale en
  minúsculas y sin llaves (`3af9df3c-b3ac-42b0-8a87-38620462676f`); para otro formato, las opciones de
  abajo.
- **Insertar GUID en el cursor** (Insert GUID at cursor) lo escribe donde está el cursor, en el editor que tienes delante. **F11** hace
  lo mismo con un editor delante (§ 5).

Las opciones van en `"options": { "editor": { "guid": { ... } } }`:

| Opción | Por defecto | |
|---|---|---|
| `enabled` | `.T.` | `.F.` apaga el módulo: sin barras y sin `F11` |
| `upper` | `.F.` | en minúsculas; `.T.` lo escribe en mayúsculas |
| `braces` | `.F.` | sin llaves; `.T.` le pone `{}` alrededor |

Hasta la 0.9.5 era el plugin `guid`, y sus opciones iban en `"options": { "guid": { ... } }`. Si solo
están esas, FoxDock las lee y el log lo dice: pásalas a `editor` cuando puedas.

No tiene tools para el agente.

## Sobre este manual

Este texto es la sección sobre `editor` del manual de plugins de FoxDock. Las referencias a otras secciones (§) y a AGENT-TOOLS apuntan a los documentos que FoxDock instala en su carpeta `docs`.

## Licencia

MIT. Está en [LICENSE](LICENSE).
