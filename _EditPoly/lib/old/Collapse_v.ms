
fn Collapse_v  = --start	
(
	undo "Collapse_v" on
	(
		sel = for o in selection where superclassof o == GeometryClass collect o
		curObj = modPanel.getCurrentObject ()
		
		if classof curObj == editable_poly then
		(
			
			$.EditablePoly.collapse  #CurrentLevel
		
		)
		else if classof curObj == edit_poly then
		(
			for o in sel do
			(
				curObj = modPanel.getCurrentObject ()
				
			case subobjectLevel of
				(	
					1:(componentToCollapse = #CollapseVertex)
					2:(componentToCollapse = #CollapseEdge )
					3:(componentToCollapse = #CollapseEdge )
					4:(componentToCollapse = #CollapseFace )
					5:(componentToCollapse = #CollapseFace )
				)
				
				curObj.ButtonOp componentToCollapse
				
			)
		)	
	)
	
)

