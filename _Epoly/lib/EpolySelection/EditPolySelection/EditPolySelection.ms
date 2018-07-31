/** Edit poly selection
 */
struct EditPolySelection_v
(

	_objects,
	
	/** Get current selection of subobject
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSelection sub_obj =
	(		
		this._setObjects()
		--messageBox "EditPolySelection_v.getSelection()" beep:false
		--this.init()
		for o in _objects collect ( mod.GetSelection sub_obj node:o) --return

		--mod.GetSelection sub_obj --return
	),	

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set mod
	 */
	function setMod _mod_ =
	(
		_mod = _mod_
	),
	/** Set object
	 */
	function _setObjects =
	(
		--_selection = (Selection_v()).get()
		_objects	= for obj in selection where superClassOf obj == GeometryClass collect obj
	),
	
	
	
	
	
	
	
	
	/*---------------------------------------
		OLD
	-----------------------------------------*/
	
	_mod,
	
	function getAUsingB modOrObj bInVar aType:#currentLevel bType:#currentLevel =
	(
		
		
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "EditPolySelection.test()"
	)
)
