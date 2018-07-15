macroscript	objects_collapse_to
category:	"_Objects"
buttontext:	"Collapse to"
toolTip:	"Collapse selected nodes to"
--icon:	"#(path, index)"
(
	with redraw off
	(
		undo "Collapse to" on
		(
			(Objects_v()).collapseNode()
		)
	)
)
	
macroscript	objects_copy
category:	"_Objects"
buttontext:	"Copy\Paste"
toolTip:	"Copy selected object"
--icon:	"#(path, index)"
(
	(Objects_v()).copy()
)

macroscript	objects_paste
category:	"_Objects"
buttontext:	"Copy\Paste"
toolTip:	"Paste selected object"
--icon:	"#(path, index)"
(
	(Objects_v()).paste()
)

/**  Isolate selection then undo viewport position  
 *	
 */	
macroscript	objects_isolate_selection
category:	"_Objects"
buttontext:	"Isolate Selection"
toolTip:	"Isolate Selection Toggle & undo viewport"
--icon:	"#(path, index)"
(
	actionMan.executeAction 0 "268"  -- Tools: Isolate Selection Toggle

	actionMan.executeAction 0 "40104"  -- Views: Undo Viewport Operation
)
	


