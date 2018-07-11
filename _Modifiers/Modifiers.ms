/** Modifiers
 */

struct Modifiers_v
(
	Edit_Poly	= (EditPoly_Modifier_v()).get(),
	XForm	= (XForm_Modifier_v()).get(),
	Chamfer	= (Chamfer_Modifier_v()).get(),
	Shell	= (Shell_Modifier_v()).get(),
	Relax	= (Relax_Modifier_v()).get(),
	Noise	= (Noise_Modifier_v()).get(),
	VolumeSelect	= (VolumeSelect_Modifier_v()).get(),
	Normal	= (Normal_Modifier_v()).get(),

	/** Delete
	 */
	function delete =
	(
		
	),
	/** Search for first edit poly modifier from top
	 */
	function search obj _modifier =
	(
		edit_poly_mods	= this._getEditPolyModifiers obj _modifier

		if( edit_poly_mods.count > 0 ) then
			edit_poly_mods[1] --return
		--print ( "edit_poly_mods=" + edit_poly_mods as string )
	),
	/** Get edit poly modifiers
	 */
	function _getEditPolyModifiers obj _modifier =
	(
		modifiers	= obj.modifiers
		edit_poly_mods	= #()
		print ( "modifiers=" + modifiers as string )

		for m=1 to modifiers.count where  classOf modifiers[m] == _modifier do
			append edit_poly_mods m
		
		edit_poly_mods --return
	),
	
	function test =
	(
		messagebox "Modifiers.test()"
	)
)
