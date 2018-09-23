
fn compareNames str1 str2 = stricmp str1.name str2.name
 




macroscript	materials_random_id_gradient
category:	"_Lasvit-Materials"
buttontext:	"Mat id gradient"
toolTip:	"Set random gradient material ID for seected objects"
--icon:	"#(path, index)"
(
	
	_objects	= for obj in selection where superClassOf obj == GeometryClass collect obj
	qSort _objects compareNames
	
	id_max	= 4
	id_current	= 1
	obj_per_id	= 1
	direction	= #up
	
	for obj in _objects do
	(
		
		if( obj_per_id == 0 ) then
		(
			obj_per_id	= random 1 3

			case direction of
			(	
				#up:	id_current +=1
				#down:	id_current -=1
			)
			
			case of
			(	
				(id_current == id_max ):	direction = #down
				(id_current == 1 ):	direction = #up
			)
			
		)

		addModifier obj ( Materialmodifier materialID:id_current )

		obj_per_id -= 1
		
	)
)
