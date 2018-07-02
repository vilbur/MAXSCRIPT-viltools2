/** Modifiers
 */

struct Modifiers_v
(
	Edit_Poly	= (EditPoly_Modifier_v()).get(),
	XForm	= (XForm_Modifier_v()).get(),
	Chamfer	= (Chamfer_Modifier_v()).get(),
	Shell	= (Shell_Modifier_v()).get(),
	Relax	= (Relax_Modifier_v()).get(),
	--Relax	= (Relax Relax_Value:1 iterations:2),
	--Relax	= (Relax ()),
	--Normal, -- Normalmodifier

	/** Add edit poly
	 */
	function addChamfer =
	(
		messagebox "Modifiers_v.addChamfer() - Method will be remoed" beep:false
		--is_chmafered	= this.search selection[1] Chamfer
		--print ( "is_chmafered=" + is_chmafered as string )
		--if( is_chmafered==undefined ) then
		--(
		--modPanel.addModToSelection (Edit_Poly name:"select_hardedges" ignoreBackfacing:on selectAngle:20 SelectByAngle:on ) ui:on
		--for i=1 to selection.count do
		--	(EditPoly_v_old obj: selection[i]).selectHardEdges()
		--	
		--	_Chamfer = Chamfer()
		--	_Chamfer.amount = 10.0
		--	_Chamfer.name	= "Chamfer-rock"
		--	/* disable subdivi */
		--	_Chamfer.chamfertype = 1
		--	_Chamfer.limiteffect = on
		--				
		--	_Chamfer.materialID = 99
		--
		--	modPanel.addModToSelection _Chamfer ui:on
		--)else
		--(
		--	modPanel.setCurrentObject $.modifiers[#Chamfer_rock]
		--	
		--	deleteModifier $ 1
		--	
		--	modPanel.setCurrentObject $.modifiers[#select_hardedges]
		--	deleteModifier $ 1
		--)
	),
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
