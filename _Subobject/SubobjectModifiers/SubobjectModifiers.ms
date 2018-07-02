/** Subobject
 */
struct SubobjectModifiers_v
(
	_modfier_elements = #(                              -- Available types of subobjects for modifier per type
		#(#vertex, #edge, #border, #polygon, #element), -- EPoly
		#(#vertex, #edge, #volume),                     -- FFD
		#(#vertex, #edge, #polygon)                     -- Unwrap_UVW
	),
	
	Editable_Poly	= _modfier_elements[1],
	Edit_Poly	= _modfier_elements[1],
	FFDBox	= _modfier_elements[2],
	FFD_2x2x2	= _modfier_elements[2],
	FFD_3x3x3	= _modfier_elements[2],
	FFD_4x4x4	= _modfier_elements[2],
	Unwrap_UVW	= _modfier_elements[3],

	--property_1 = "property_1 value", 
	--property_2 = "property_2 value", 
	--
	/** Get subobjects of give modifier
	  * @property	string	_modifier
	  *
	  * @return	array|undefined Of subobjects for modifier, or undefined if modifier has not subobjects 
	  *
	 */
	function get _modifier =
	(
		_modifier_class = classOf _modifier as string
		
		if( hasProperty this _modifier_class ) then
			 getProperty this _modifier_class --return
		--else
			--false
	)
	
)


--props = getPropNames (SubobjectModifiers_v())
--print ( "props = " + props as string )
--print ( superClassOf props[3] )
