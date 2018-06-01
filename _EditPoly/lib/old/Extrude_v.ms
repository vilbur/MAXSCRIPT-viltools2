
Function Extrude_v withOptions =  --start
(
	curmod = modPanel.getCurrentObject ()

	case subobjectLevel of
	(	
		1:(SubObjVar = #ExtrudeVertex)
		2:(SubObjVar = #ExtrudeEdge)
		3:(SubObjVar = #ExtrudeEdge)
		4:(SubObjVar = #ExtrudeFace)
		5:(SubObjVar = #ExtrudeFace	)				
	)
					
					
	case  classof curmod  of
	(
	
		Edit_Poly:(
					if withOptions == 1 then curmod.PopupDialog SubObjVar else	curmod.EnterCommandMode  SubObjVar  

					)
		Editable_Poly: (

			if withOptions == 1 then curmod.PopupDialog #Extrude else  curmod.toggleCommandMode   SubObjVar

					) 	

	)

	
	
)--end

			
