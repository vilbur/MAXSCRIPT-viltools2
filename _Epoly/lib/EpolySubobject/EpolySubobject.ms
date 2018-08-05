/** Subobject
 */
struct EpolySubobject_v
(
	Epoly,
	
	_subobject_names	= #(#vertex, #edge, #border, #face, #element),

	/** Get sub object index
	  @ @return	integer	
	 */
	function getIndex sub_obj =
	(
		if( classOf sub_obj == name ) then (findItem _subobject_names sub_obj) else sub_obj  --return
	),
	/** Get sub object name
	  * @return	name	
	 */
	function getName sub_obj =
	(
		if( classOf sub_obj == name ) then sub_obj else _subobject_names[sub_obj]  --return
	),
	
	function test =
	(
		messagebox "Subobject.test()"
	)
)
