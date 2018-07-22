
/*------------------------------------------------------------------------------
	AUTOLOADER
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/../Library/_UI/Lib/List/List.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/MacroAutoLoader/MacroAutoLoader.ms" )
/*------------------------------------------------------------------------------
	VIEWPORTEXT
--------------------------------------------------------------------------------*/

if( global_vievporttext == undefined ) then
(
	global global_vievporttext
	global_vievporttext = List_v()
	--messageBox "INCLUDE"
)
	filein ( getFilenamePath(getSourceFileName()) + "/Hud/HudItem/HudItem.ms" )
	filein ( getFilenamePath(getSourceFileName()) + "/Hud/Hud.ms" )

/*------------------------------------------------------------------------------
	SELECTION 
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Selection/Selection.ms" )

/*------------------------------------------------------------------------------
	MODIFIER 
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/RelaxModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/ShellModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/ChamferModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/EditPolyModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/XFormModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/NoiseModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/VolumeSelect.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers/NormalModifier.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifiers.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Modifiers/Modifier.ms" )

/*------------------------------------------------------------------------------
	MATERIAL 
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Material/Material.ms" )

/*------------------------------------------------------------------------------
	SUBOBJECT
--------------------------------------------------------------------------------*/ 
filein ( getFilenamePath(getSourceFileName()) + "/_Subobject/SubobjectModifiers/SubobjectModifiers.ms" ) 
filein ( getFilenamePath(getSourceFileName()) + "/_Subobject/Subobject.ms" )

/*------------------------------------------------------------------------------
	EPOLY
--------------------------------------------------------------------------------*/

filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyMod/EditPoly/EditPoly.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyMod/EditablePoly/EditablePoly.ms" )


filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyMod/EpolyMod.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyOptions/EpolyOptions.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyEdges/EpolyEdges.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyEdit/EpolyEdit.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolySmoothGroups/EpolySmoothGroups.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EditPolyMaterial/EditPolyMaterial.ms" )

filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolySelection/EditPolyRingLoop/EditPolyLoop/EditPolyLoop.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolySelection/EditPolyRingLoop/EditPolyRingLoop.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolySelection/EpolySelection.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EditPolyExplode/EditPolyExplode.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/Epoly.ms" )

filein ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolyCallbacks/EpolyCallbacks.ms" )

/*------------------------------------------------------------------------------
	PIVOT
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Pivot/Pivot.ms" )

/*------------------------------------------------------------------------------
	OBJECTS
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Objects/Objects.ms" )

/*------------------------------------------------------------------------------
	GIZMO
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Transform/Gizmo.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_Transform//CoordMode/CoordMode.ms" )

/*------------------------------------------------------------------------------
	TOOLMODE
--------------------------------------------------------------------------------*/
filein ( getFilenamePath(getSourceFileName()) + "/_Tools/ToolMode.ms" )

/*------------------------------------------------------------------------------
	MAIN UI
--------------------------------------------------------------------------------*/
--filein ( getFilenamePath(getSourceFileName()) + "/_MainUI/Mini-Transform-Type-In/Mini-Transform-Type-In.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_MainUI/Mini-Transform-Type-In/Mini-Transform-Type-In-Start.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_MainUI/MainUI.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/_MainUI/Snap/Snap.ms" )
