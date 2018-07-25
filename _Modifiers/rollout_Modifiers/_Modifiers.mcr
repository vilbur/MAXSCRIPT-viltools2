macroscript	modifier_add_editpoly
category:	"_Modifiers"  
buttonText:	"EditPoly"
tooltip:	"Add EditPoly"
(
	_Edit_Poly = (Modifier_v type:#Edit_Poly ).add()

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