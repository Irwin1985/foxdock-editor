*==================================================================
* EditorGuid.prg: el módulo «guid» del paquete «editor» de FoxDock.
*
*   Create GUID              un GUID nuevo al portapapeles (_CLIPTEXT), y avisa;
*                            atajo ALT+G (KEY no admite CTRL+SHIFT+G)
*   Insert GUID at cursor    un GUID nuevo donde está el cursor del editor;
*                            sin editor delante, lo dice y no escribe nada
*   F11 (tecla de editor)    lo mismo que «Insert», solo con un editor delante
*
* El GUID sale de CoCreateGuid (ole32), y el texto de StringFromGUID2: ni COM
* ni ventanas, nada que pueda abrir un diálogo. Opciones en config.json:
*   "options": { "editor": { "guid": { "braces": true, "upper": true } } }
* (las dos .F. por defecto: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx, en minúsculas
* y sin llaves). Cuando «guid» era un plugin aparte, sus opciones iban en
* "options": { "guid": {...} }: si solo está esa, se lee, y el log lo dice
* una vez al cargar.
*==================================================================

DEFINE CLASS EditorGuid AS Custom
	cId = "guid"
	oHost = .NULL.
	cLast = ""
	cLastClip = ""        && lo último que puso en el portapapeles (para las pruebas)
	lOldOptions = .F.     && las opciones vienen del sitio antiguo, options.guid

	PROCEDURE Init
		LPARAMETERS toHost
		LOCAL loO
		This.oHost = toHost
		loO = toHost.Options
		IF !loO.Has("editor", "guid.braces") AND !loO.Has("editor", "guid.upper") AND ;
				(loO.Has("guid", "braces") OR loO.Has("guid", "upper"))
			This.lOldOptions = .T.
			toHost.Log("editor: config.json has options.guid and no options.editor.guid; the old one is read " + ;
				"(move it to options.editor.guid)")
		ENDIF
	ENDPROC

	*-- Los textos, en el idioma de FoxDock (EditorStrings.prg).
	PROCEDURE BuildMenu
		LPARAMETERS toMenu
		toMenu.AddBar(This.oHost.Translate("editor.guid.create"), "CreateGuid", This.oHost.Translate("editor.guid.create.message"), ;
			"ALT+G")
		toMenu.AddBar(This.oHost.Translate("editor.guid.insert"), "InsertGuid", This.oHost.Translate("editor.guid.insert.message"))
		toMenu.AddEditorKey("F11", "InsertGuid")
	ENDPROC

	PROCEDURE GetAgentTools
		LPARAMETERS toTools
		RETURN 0
	ENDPROC

	*-- Una opción del módulo: options.editor.guid.<clave>, o la antigua de options.guid.
	PROCEDURE GetOption
		LPARAMETERS tcKey, tvDefault
		IF This.lOldOptions
			RETURN This.oHost.Options.Get("guid", tcKey, tvDefault)
		ENDIF
		RETURN This.oHost.Options.Get("editor", "guid." + tcKey, tvDefault)
	ENDPROC

	PROCEDURE CreateGuid
		LOCAL lcGuid
		lcGuid = This.NewGuid()
		This.cLastClip = lcGuid
		*-- Si otro programa tiene el portapapeles, el aviso da el GUID, para que
		*-- no se pierda.
		This.oHost.NotifyKey(IIF(This.oHost.ToClipboard(lcGuid, "Create GUID"), "editor.guid.onClipboard", "editor.guid.clipHeld"), lcGuid)
		RETURN lcGuid
	ENDPROC

	*-- Desde la barra, sin parámetro: el editor de encima. Desde la tecla de
	*-- editor, con su toKey: ese editor, por su wh.
	PROCEDURE InsertGuid
		LPARAMETERS toKey
		LOCAL lcGuid, llOk
		lcGuid = This.NewGuid()
		IF VARTYPE(toKey) == "O" AND PEMSTATUS(toKey, "wh", 5) AND toKey.wh > 0
			llOk = This.oHost.Editor.Insert(lcGuid, toKey.wh)
		ELSE
			llOk = This.oHost.Editor.Insert(lcGuid)
		ENDIF
		IF llOk
			This.oHost.Log("editor.guid: inserted " + lcGuid)
		ELSE
			This.oHost.NotifyKey("editor.guid.noEditor", lcGuid)
		ENDIF
		RETURN llOk
	ENDPROC

	PROCEDURE NewGuid
		LOCAL lcBin, lcWide, lnChars, lcGuid
		DECLARE INTEGER CoCreateGuid IN ole32 AS FdCoCreateGuid STRING @pguid
		DECLARE INTEGER StringFromGUID2 IN ole32 AS FdStringFromGUID2 STRING @rguid, STRING @lpsz, INTEGER cchMax
		lcBin = REPLICATE(CHR(0), 16)
		IF FdCoCreateGuid(@lcBin) # 0
			ERROR "editor.guid: CoCreateGuid failed"
		ENDIF
		lcWide = REPLICATE(CHR(0), 80)
		lnChars = FdStringFromGUID2(@lcBin, @lcWide, 40)
		*-- UTF-16 de solo ASCII: quitar los ceros basta. lnChars cuenta el
		*-- terminador.
		lcGuid = CHRTRAN(LEFT(lcWide, (lnChars - 1) * 2), CHR(0), "")
		IF !This.GetOption("upper", .F.)
			lcGuid = LOWER(lcGuid)
		ENDIF
		IF !This.GetOption("braces", .F.)
			lcGuid = CHRTRAN(lcGuid, "{}", "")
		ENDIF
		This.cLast = lcGuid
		RETURN lcGuid
	ENDPROC
ENDDEFINE
