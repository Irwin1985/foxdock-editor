*==================================================================
* EditorStrings.prg: las cadenas del plugin editor, en inglés,
* español y alemán. Lo ejecuta el host al cargar el plugin (LoadPluginStrings),
* antes de su BuildMenu: una llamada toHost.AddString(<idioma>, <clave>, <texto>)
* por cadena. Las tres listas llevan las mismas claves, en el mismo orden; una que
* falte en español o alemán sale en inglés. {1} a {4}, los valores. \< marca la
* tecla de acceso. Los nombres propios (FoxDock, FoxAgent, VFP, GUID, JSON) no se
* traducen. Fichero en CP1252, con los acentos escritos: lo lee el usuario.
*==================================================================

LPARAMETERS toHost

*-- English
toHost.AddString("en", "editor.title", "Editor")
toHost.AddString("en", "editor.guid.create", "\<Create GUID")
toHost.AddString("en", "editor.guid.create.message", "Put a new GUID on the clipboard")
toHost.AddString("en", "editor.guid.insert", "\<Insert GUID at cursor")
toHost.AddString("en", "editor.guid.insert.message", "Write a new GUID where the cursor is")
toHost.AddString("en", "editor.guid.clipHeld", "GUID {1}: the clipboard is held by another program, nothing was copied.")
toHost.AddString("en", "editor.guid.onClipboard", "GUID on the clipboard: {1}")
toHost.AddString("en", "editor.guid.noEditor", "No editor in front: the GUID was not inserted ({1})")

*-- Español
toHost.AddString("es", "editor.title", "Editor")
toHost.AddString("es", "editor.guid.create", "\<Crear GUID")
toHost.AddString("es", "editor.guid.create.message", "Pone un GUID nuevo en el portapapeles")
toHost.AddString("es", "editor.guid.insert", "\<Insertar GUID en el cursor")
toHost.AddString("es", "editor.guid.insert.message", "Escribe un GUID nuevo donde está el cursor")
toHost.AddString("es", "editor.guid.clipHeld", "GUID {1}: otro programa tiene ocupado el portapapeles, no se ha copiado nada.")
toHost.AddString("es", "editor.guid.onClipboard", "GUID en el portapapeles: {1}")
toHost.AddString("es", "editor.guid.noEditor", "No hay ningún editor delante: el GUID no se insertó ({1})")

*-- Deutsch
toHost.AddString("de", "editor.title", "Editor")
toHost.AddString("de", "editor.guid.create", "GUID \<erstellen")
toHost.AddString("de", "editor.guid.create.message", "Legt eine neue GUID in die Zwischenablage")
toHost.AddString("de", "editor.guid.insert", "GUID am Cursor ein\<fügen")
toHost.AddString("de", "editor.guid.insert.message", "Schreibt eine neue GUID an die Stelle des Cursors")
toHost.AddString("de", "editor.guid.clipHeld", "GUID {1}: Ein anderes Programm hält die Zwischenablage fest, es wurde nichts kopiert.")
toHost.AddString("de", "editor.guid.onClipboard", "GUID in der Zwischenablage: {1}")
toHost.AddString("de", "editor.guid.noEditor", "Kein Editor im Vordergrund: Die GUID wurde nicht eingefügt ({1})")
