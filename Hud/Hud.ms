/** Manage text in viewport
 */
struct Hud_v
(
	id,
	items,
	--color	= yellow,
	--position	= [0, 0, 0],
	position	= #(#center, #top, 0),

	/** Instance
	 */
	function instance _id =
	(
		this.setId _id

		_instance = 	global_vievporttext.getVal _id

		if( _instance == undefined ) then
		(
			global_vievporttext.setVal _id this
			_instance = global_vievporttext.getVal _id
		)

		_instance --return 
	),
	/** Box
	 */
	function box _items =
	(
		--items	= _items
		if( items == undefined ) then
			items	= List_v()

		for i=1 to _items.count do
			this._setItem _items[i] i
		--print ( "items = " + items as string )
	),

	/** Update
	 */
	function update =
	(
		print "HudItem_v.update()"
		for i=1 to items.keys.count do
			items.values[i].update()
	),
	/** Hide
	 */
	function hide =
	(
		if( items != undefined ) then
			for i=1 to items.keys.count do
				items.values[i].hide()
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set id
	 */
	function setId _id =
	(
		id = "gw_"+_id
	),
	/** _set _item
	 */
	function _setItem _item i =
	(
		item = this._getItem _item[1]

		item	= this._setStateValue item _item[2]

		item.position 	= [gw.getWinSizeX()/2 , gw.getWinSizeY() - (i*20) - 40 , 0]
		--item.position 	= [ gw.getWinSizeX()/2, (i*20) + 40 , 0]
		--item.position 	= [ 0, (i*20) + 40 , 0]


		--item.setProp ( filterString _item[3]  )
		item.color = _item[3]
		
		items.setVal _item[1] item

	),
	/** _get item
	 */
	function _getItem _id =
	(
		item = items.getVal _id

		if( item == undefined ) then
			item = items.setVal _id (HudItem_v id:_id)

		item --return	
	),
	/** _set state value
	 */
	function _setStateValue item state_value =
	(
		if( classOf state_value == BooleanClass ) then
			item.state = state_value
		else
		(
			item.state = true
			item.text = state_value
		)
			--item.state = true
			--item.text = state_value as string
		
		item --return
	),
	/** _get position
	 */
	function _getPosition =
	(
		position as string --return
	),

	function test =
	(
		messagebox "Hud.test()"
	)

)
