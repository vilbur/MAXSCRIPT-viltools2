




_text  = "global GW_displayText"
_text += "\nunregisterRedrawViewsCallback GW_displayText"
_text += "\nfn GW_displayText ="
_text += "\n("
_text += "\ngw.htext [40,40,0] \"LoremIpsum\" color:green"
_text += "\ngw.updateScreen() "
_text += "\n)"
_text += "\nregisterRedrawViewsCallback GW_displayText"

execute _text 

--unregisterRedrawViewsCallback GW_displayText




----(
--	global GW_displayText
--	unregisterRedrawViewsCallback GW_displayText
--	fn GW_displayText =
--	(
--		gw.htext [40,40,0] "LoremIpsum" color:green
--		
--		gw.updateScreen() 
--	)
--	registerRedrawViewsCallback GW_displayText
----)
--
--unregisterRedrawViewsCallback GW_displayText