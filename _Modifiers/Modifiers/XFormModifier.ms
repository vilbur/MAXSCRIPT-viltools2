/** Edit poly_ modifier
 */
struct XForm_Modifier_v
(
	/** Get
	 */
	function get =
	(
		XForm() --return
	),
	/** Reset xform, apply "Normal" modifier if object is mirrored
	 */
	function resetObject pivot:true =
	(
		for o in selection where superClassOf o == GeometryClass do
		(
			--if (classof o  != Editable_Poly) do
			--(
			--	addModifier o (Edit_Poly ())
			--	maxOps.CollapseNodeTo o 1 off
			--)
	
			if (this.isObjectMirrored o == true) then
				addModifier o (Normalmodifier ()) 
			
			--if( pivot==true ) then 
				--ResetPivot o
			
			ResetXForm o

			maxOps.CollapseNodeTo o 1 off
		)
	),
					

	/** Is object mirrored
	 */
	function isObjectMirrored obj =
	(
		obj.scale.x < 0 or obj.scale.y < 0  or obj.scale.z < 0 --return
	), 
	
	function test =
	(
		messagebox "EditPoly_Modifier.test()"
	)
)
