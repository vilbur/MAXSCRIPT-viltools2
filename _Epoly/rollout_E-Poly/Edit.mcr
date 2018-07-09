macroscript	epoly_remove
category:	"_Epoly-Edit"  
buttonText:	"Remove"
tooltip:	"Remove subobject"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)

macroscript	epoly_target_weld
category:	"_Epoly-Edit"  
buttonText:	"Target Weld"
tooltip:	"Target Weld"
(
	Epoly = Epoly_v()

	if( subObjectLevel != 1  ) then
		subObjectLevel = 1

	Epoly.targetWeld()

)

macroscript	epoly_connect
category:	"_Epoly-Edit"  
buttonText:	"Connect"
tooltip:	"Connect"
(
	undo "Connect subobject" on
	(
		(Epoly_v()).connect()
	)
)