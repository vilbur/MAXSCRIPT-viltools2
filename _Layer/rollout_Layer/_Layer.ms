
/*------------------------------------------------------------------------------
	HERLPERS FUNCTIONS
--------------------------------------------------------------------------------*/
/** Layer button left click
 */
function layerButtonLeftClick _button  =
(
	--key_press
	Layer 	= (Layer_v())
	
	Layer.toggle _button.text
	--print ( "_button = " + _button as string )
	print ( "_button = " + _button.text as string )
)

function macrosTest layers_on =
(

	with redraw off
	(
		Layer 	= (Layer_v())
		Layer.turnOnAllLayers()
		Layer.hideAllLayers excludes:#("Edit")
		Layer.activate layers_on
	)
)

--/*------------------------------------------------------------------------------
--	MACROS
----------------------------------------------------------------------------------*/
--macroscript	layer_turn_on_layer_edit
--category:	"_Layer"
--buttontext:	"Edit"
--toolTip:	"Turn on 'Edit' layer"
----icon:	"#(path, index)"
--(
--	--with redraw off
--	--(
--	--	Layer 	= (Layer_v())
--	--	Layer.turnOnAllLayers()
--	--	Layer.hideAllLayers excludes:#("Edit")
--	--	Layer.activate "Edit"
--	--)
--	--macrosTest "Edit"
--	LayerButtonLeftClick "Edit"
--)
--
--macroscript	layer_turn_on_layer_export
--category:	"_Layer"
--buttontext:	"Export"
--toolTip:	"Turn on 'Export' layer"
----icon:	"#(path, index)"
--(
--	--macrosTest "Export"
--	LayerButtonLeftClick "Export"
--	
--)
--

layer_buttons	= #( "Edit", "Export" )

rollout_objects	= __GLOBAL__v.Floater.roll "" "rollout_layer" 
_controls_1	= rollout_objects.controls groupbox:"Test"
--
--
----(_controls_1.checkbutton "checkbutton test").changed "(Layer_v()).toggle #export #edit"
--(_controls_1.checkbutton "checkbutton test").changed "checkbuttonTest()"
--
print "=============================================================="
for layer_button in layer_buttons do
(
	--(_controls_1.button layer_button).pressed ( "messagebox ("+_Checkbox_A.prop ("state") +" as string) ")
	print ( "layer_button = " + layer_button as string )
	(_controls_1.button layer_button).pressed ("layerButtonLeftClick "+layer_button)
	
)

--
----(_controls_1.button "button_foo").pressed ( "messagebox ("+_Checkbox_A.prop ("state") +" as string) ")













