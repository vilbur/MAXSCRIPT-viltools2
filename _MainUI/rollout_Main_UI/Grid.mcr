macroscript	grid_grid_toggle
category:	"_MainUI"
buttontext:	"Grid"
toolTip:	"Grid on, set space & size"
--icon:	"#(path, index)"
(
	if( viewport.getLayout() == #layout_1 and viewport.getGridVisibility 1 == false ) then 
	(
		actionMan.executeAction 0 "40078"  -- Views: Show Home Grid
		
		gridPrefs.perspViewGridExtents	= 12
		gridPrefs.spacing	= 100.0
	)
	else
		actionMan.executeAction 0 "40077"  -- Views: Hide Grids Toggle
	
)

