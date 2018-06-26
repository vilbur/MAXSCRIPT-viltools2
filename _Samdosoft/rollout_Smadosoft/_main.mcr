macroscript modifier_chamfer
category:"_Smadosoft"  
buttonText:"Stairs"
tooltip:"Create stairs from selected objects"
(
	for o=1 to selection.count do
	(
		obj = selection[o]	
		
		obj.pos.z = o * 40 as float  
		obj.pos.x = o * 100 as float  
		--print ( "o=" + (o *40) as string )
	)
	
)