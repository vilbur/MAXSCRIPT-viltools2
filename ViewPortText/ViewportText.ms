/** Manage text in viewport
 */
struct ViewportText_v
(
	id,
	items,
	--color	= yellow,
	position	= [0, 0, 0],

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
		(
			item	= _items[i]
			_item = items.getVal item[1]

			if( _item == undefined ) then
				_item = items.setVal item[1] (ViewportTextItem_v id:item[1])

			_item.text	= item[1]
			_item.position 	= [40, i*20, 0]

			_item.setState item[2]
		)
		print ( "items = " + items as string )
	),

	/** Update
	 */
	function update =
	(
		print "ViewportTextItem_v.update()"
		for i=1 to items.keys.count do
			items.values[i].update()
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

	/** _get position
	 */
	function _getPosition =
	(
		position as string --return
	),

	function test =
	(
		messagebox "ViewportText.test()"
	)

)
