*==================================================================
* EditorPlugin.prg: el paquete «editor» de FoxDock.
*
* Un PAQUETE es un plugin con módulos dentro: una utilidad nueva del editor
* de código entra aquí como módulo y no abre otra línea en el menú ni en
* «Plugins >». Es el molde que copian «data» y «designer»
* (docs\PLUGINS_EN.md, «A package with modules»):
*
*   - un módulo es una clase con cId, en su propio .prg dentro de la carpeta
*     del paquete y con el prefijo del paquete (EditorGuid.prg: un .prg de un
*     plugin no puede llamarse como uno del usuario: VFP correría el del plugin);
*   - se enciende y se apaga en config.json, sin pantalla (por defecto,
*     encendido):
*       "options": { "editor": { "guid": { "enabled": false } } }
*     y apagado NO EXISTE: ni sus barras ni sus tools. El log lo dice al cargar;
*   - aporta sus barras en su BuildMenu(toMenu) y sus tools en su
*     GetAgentTools(toTools), y el paquete los llama uno detrás de otro;
*   - una barra llama a un método DEL PAQUETE por su nombre (así es el
*     contrato de AddBar), así que el paquete tiene un método por acción que
*     se lo pasa al módulo (CreateGuid -> Module("guid").CreateGuid());
*   - sus opciones viven bajo las suyas: options.editor.guid.<clave>.
*
* Los módulos (ModuleList): guid (Create GUID, Insert GUID at cursor,
* F11 en un editor).
*
* Fichero en CP1252, con los acentos escritos.
*==================================================================

DEFINE CLASS EditorPlugin AS PluginBase
	cId = "editor"
	cTitle = "Editor"
	nOrder = 930
	cVersion = "0.2.0"
	oModules = .NULL.

	*-- Los módulos del paquete, uno por línea: id, clase y .prg.
	PROCEDURE ModuleList
		RETURN "guid,EditorGuid,EditorGuid.prg"
	ENDPROC

	*-- Los módulos encendidos (una Collection por id). Se cargan la primera
	*-- vez que hacen falta, que es en BuildMenu: el host ya puso cHome.
	PROCEDURE Modules
		LOCAL lnI
		LOCAL ARRAY laM[1], laP[1]
		IF ISNULL(This.oModules)
			This.oModules = CREATEOBJECT("Collection")
			FOR lnI = 1 TO ALINES(laM, This.ModuleList(), 1 + 4)
				IF ALINES(laP, laM[lnI], 1, ",") = 3
					This.LoadModule(LOWER(laP[1]), laP[2], laP[3])
				ENDIF
			ENDFOR
		ENDIF
		RETURN This.oModules
	ENDPROC

	*-- Un módulo por su id, o .NULL. si está apagado o no cargó.
	PROCEDURE Module
		LPARAMETERS tcId
		LOCAL loMods
		loMods = This.Modules()
		IF loMods.GetKey(LOWER(tcId)) > 0
			RETURN loMods.Item(LOWER(tcId))
		ENDIF
		RETURN .NULL.
	ENDPROC

	PROTECTED PROCEDURE LoadModule
		LPARAMETERS tcId, tcClass, tcPrg
		LOCAL loM, loErr
		IF !This.oHost.Options.Get(This.cId, tcId + ".enabled", .T.)
			This.oHost.Log(This.cId + ": module " + tcId + " is off in config.json (options." + This.cId + "." + ;
				tcId + ".enabled): its bars and tools are not there")
			RETURN
		ENDIF
		TRY
			SET PROCEDURE TO (This.CodeFile(tcPrg)) ADDITIVE
			loM = CREATEOBJECT(tcClass, This.oHost)
			This.oModules.Add(loM, tcId)
			This.oHost.Log(This.cId + ": module " + tcId + " loaded")
		CATCH TO loErr
			This.oHost.LogFault(This.cId + ": module " + tcId + " failed to load: " + TRANSFORM(loErr.ErrorNo) + ;
				" " + loErr.Message)
		ENDTRY
	ENDPROC

	PROCEDURE BuildMenu
		LPARAMETERS toMenu
		LOCAL loMods, loM
		*-- El título, en el idioma de FoxDock (EditorStrings.prg).
		This.cTitle = This.oHost.Translate("editor.title")
		loMods = This.Modules()
		FOR EACH loM IN loMods
			loM.BuildMenu(toMenu)
		ENDFOR
	ENDPROC

	PROCEDURE GetAgentTools
		LPARAMETERS toTools
		LOCAL loMods, loM, lnN
		lnN = 0
		loMods = This.Modules()
		FOR EACH loM IN loMods
			lnN = lnN + loM.GetAgentTools(toTools)
		ENDFOR
		RETURN lnN
	ENDPROC

	*-- Las acciones de los módulos. Con el módulo apagado no hay barra que
	*-- las llame; si llega una (una barra vieja), se dice y no pasa nada.
	PROCEDURE CreateGuid
		LOCAL loM
		loM = This.Module("guid")
		RETURN IIF(ISNULL(loM), This.Off("guid"), loM.CreateGuid())
	ENDPROC

	PROCEDURE InsertGuid
		LPARAMETERS toKey
		LOCAL loM
		loM = This.Module("guid")
		RETURN IIF(ISNULL(loM), This.Off("guid"), loM.InsertGuid(toKey))
	ENDPROC

	PROTECTED PROCEDURE Off
		LPARAMETERS tcId
		This.oHost.LogWarn(This.cId + ": module " + tcId + " is off or did not load")
		RETURN .F.
	ENDPROC
ENDDEFINE
