/*
Requies vil_Explode_Elements.ms
*/

(
	
function Explode_By_SG_v =
	(
		sel = #()
		for o in selection where (superclassof o == GeometryClass) do append sel o
			
		for obj in sel do
		(
			objName = obj.name
			SG = 1;
			selArray = #{};
				
			maxops.CollapseNode obj off
			--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
			FaceCount = polyop.getNumFaces obj;
			
		
			for SG in 1 to 32 do
				(	
					for i=1 to FaceCount do 
					(
					 FaceSG = polyop.getFaceSmoothGroup obj i;
						
						if (FaceSG == SG) then 
							(
								append selArray i; 
							)
					)
					polyop.detachFaces obj selArray delete:true asNode:false -- name:(uniquename objNane)
				)
			Explode_Elements_v obj
		)		
	)
)	

