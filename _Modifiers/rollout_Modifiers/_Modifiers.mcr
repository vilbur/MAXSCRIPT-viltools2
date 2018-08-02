macroscript	modifier_add_editpoly
category:	"_Modifiers"  
buttonText:	"EditPoly"
tooltip:	"Add EditPoly"
(
	sub_obj	= subObjectLevel
	
	_Edit_Poly = (Modifier_v type:#Edit_Poly ).add()

	if( sub_obj != 0 ) then 
		subObjectLevel = sub_obj
		
	redrawViews()
)
macroscript	modifier_add_normal
category:	"_Modifiers"  
buttonText:	"Normal"
tooltip:	"Add Normal"
(
	_Normal = (Modifier_v type:#Normal ).add()

	redrawViews()
)
macroscript	modifier_add_shell
category:	"_Modifiers"  
buttonText:	"Shell"
tooltip:	"Add Shell"
(
	_Shell = (Modifier_v type:#Shell ).add()

	_Shell.overrideMatID = on
	_Shell.matID = 255
	
	_Shell.selectInnerFaces = on
	_Shell.innerAmount = 30
	_Shell.outerAmount = 0
	
	redrawViews()
)

macroscript	modifier_resetXform
category:	"_Modifiers"  
buttonText:	"Xform"
tooltip:	"Add Reset Xform"
(
	--clearListener()
	Xform = (XForm_Modifier_v())

	Xform.resetObject()
)

macroscript	modifier_Relax
category:	"_Modifiers"  
buttonText:	"Relax"
tooltip:	"Add Reset Relax"
(
	--clearListener()
	(Modifier_v type:#Relax).add()

)



macroscript	modifier_chamfer
category:	"_Modifiers"  
buttonText:	"Chamfer"
tooltip:	"Add Chamfer"
(
	--clearListener()
	(Modifier_v type:#Chamfer).add()

)

macroscript	modifier_noise
category:	"_Modifiers"  
buttonText:	"Noise"
tooltip:	"Add Noise"
(
	_Noise	= (Modifier_v type:#Noise).add()
	_Noise.strength	= [15, 15, 15]
	_Noise.scale	= 20
	_Noise.fractal	= false

)
macroscript	modifier_noise_more
category:	"_Modifiers"  
buttonText:	"Noise"
tooltip:	"Add Noise MORE"
(
	--clearListener()
	_Noise	= (Modifier_v type:#Noise).add()
	_Noise.strength	= [90, 90, 90]
	_Noise.scale	= 100
)
macroscript	modifier_smooth
category:	"_Modifiers"  
buttonText:	"Smooth"
tooltip:	"Add Smooth"
(
	--clearListener()
	(Modifier_v type:#Smooth).add()

)

macroscript	modifier_volume_select
category:	"_Modifiers"  
buttonText:	"Volume Select"
tooltip:	"Add Volume Select"
(
	--clearListener()
	(Modifier_v type:#VolumeSelect).add()

)

macroscript	modifier_face_extrude
category:	"_Modifiers"  
buttonText:	"Face Extrude"
tooltip:	"Add Volume Select"
(
	--clearListener()
	
	dialog	= dotNetObject "MaxCustomControls.RenameInstanceDialog" ""
	dialog.text	= "Extrude Name"
	modal	= dialog.Showmodal()
	modifier_name	= dialog.InstanceName
	
	if( modifier_name!="" ) then
		modifier_name += "-"
	
	_Mesh_Select	= (Modifier_v type:#Mesh_Select	name:(modifier_name+"Select"	)).add()
	_Face_Extrude	= (Modifier_v type:#Face_Extrude	name:(modifier_name+"Extrude"	)).add()
	
	_Mesh_Select.ignoreBackfacing = on

	modPanel.setCurrentObject _Mesh_Select
	subObjectLevel = 4 
)



