
/*------------------------------------------------------------------------------
	HERLPERS FUNCTIONS
--------------------------------------------------------------------------------*/
/** Layer button left click
  
	Toggle show\hide
	Set layer active
	Hide other layers
	
	Move objects to layer
	Copy objects to layer
	
	Rename objects in layer by layer name
	
	
 */
function layerButtonLeftClick _button  =
(
	--key_press

	Layer 	= (Layer_v())
	
	--Layer.toggle _button.text
	
	--messageBox (_button.state as string)
	
	
)
/**  
 *	
 */
function layerButtonRightClick _button  =
(
	--key_press

	--Layer 	= (Layer_v())
	
	--Layer.toggle _button.text
	setLayerButtonsState()
	--messageBox (_button.text as string)
	--messageBox "layerButtonRightClick" beep:false

)
/** Layer button changed
 */
function layerButtonChanged _button =
(
	ctrl = keyboard.controlPressed; alt = keyboard.altPressed; shift = keyboard.shiftPressed
	if ctrl == true  and alt == true and shift == true then
		print "Control and Alt and Shift"
	else if ctrl == true  and alt then
		print "Control and Alt"
	else if ctrl == true  and shift == true  then
		print "Control and Shift"
	else if ctrl == true then
		isolateLayer _button.text
	else if alt == true then
		print "Alt"
	else if shift == true  then
		print "Shift"
	else
		(LayerManager.getLayerFromName _button.text).on = _button.state -- set layer visibility by state of button
	
	setLayerButtonsState()
	--layer.on = _button.state
)


function isolateLayer layers_on =
(

	with redraw off
	(
		Layer 	= (Layer_v())
		Layer.turnOnAllLayers()
		Layer.hideAllLayers excludes:#(layers_on)
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
--	--isolateLayer "Edit"
--	LayerButtonLeftClick "Edit"
--)
--
--macroscript	layer_turn_on_layer_export
--category:	"_Layer"
--buttontext:	"Export"
--toolTip:	"Turn on 'Export' layer"
----icon:	"#(path, index)"
--(
--	--isolateLayer "Export"
--	LayerButtonLeftClick "Export"
--	
--)

/** Set layer buttons state
 */
function setLayerButtonsState =
(
	print "============== setLayerButtonsState ==============\n"
	for layer_button in layer_buttons do
		layer_button.prop #checked ((LayerManager.getLayerFromName (layer_button.prop #text #get)).on)
)

global layer_names	= #( "Edit", "Export", "Xref" )
global layer_buttons	= #()



rollout_objects	= __GLOBAL__v.Floater.roll "" "rollout_layer" 
layer_controls	= rollout_objects.controls groupbox:"Test"
--
--
--(layer_controls.checkbutton "checkbutton test").changed "(Layer_v()).toggle #export #edit"
--(layer_controls.button "checkbutton_test").rightclick "layerButtonRightClick \"checkbutton_test\""
--
print "=============================================================="
for layer_name in layer_names do
(
	--print ( "layer_name = " + layer_name as string )
	_button = layer_controls.checkbutton layer_name
	print ( "_button = " + _button.path as string )
	--_button.param #checked ((LayerManager.getLayerFromName layer_name).on)

	_button.changed ("layerButtonChanged "+layer_name)
	_button.rightclick ("layerButtonRightClick "+layer_name)
	
	append layer_buttons _button
)

--setLayerButtonsState()
--
----(layer_controls.button "button_foo").pressed ( "messagebox ("+_Checkbox_A.prop ("state") +" as string) ")













