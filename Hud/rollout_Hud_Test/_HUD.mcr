macroscript	_HUD_add_test
category:	"Hud"
buttontext:	"Text"
toolTip:	"Add"
--icon:	"#(path, index)"
(
	HudItem = HudItem_v id:"gw_test"
	HudItem.show "Test"
)

macroscript	_HUD_remove_test
category:	"Hud"
buttontext:	"Text"
toolTip:	"Remove"
--icon:	"#(path, index)"
(
	--HudItem = HudItem_v id:"Test"
	unregisterRedrawViewsCallback gw_test
)
