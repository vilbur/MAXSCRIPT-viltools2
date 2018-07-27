/** Pivot
 */
struct Pivot_v
(

	/** Reset to word
	 */
	function resetToWord =
	(
		selection.pivot = [0, 0, 0]
	),
	/** Center to object
	 */
	function centerToObject =
	(
		CenterPivot selection
	),
	
	--/** Reset to object
	-- */
	--function resetToObject =
	--(
	--	(for i in selection do i.pivot = i.center)		
	--),
	/** Reset to object
	 */
	function freePivot =
	(
		if (maxops.pivotmode != #pivotonly) then
			maxops.pivotmode = #pivotonly
		else
			maxops.pivotmode = #none
	),
	function test =
	(
		messagebox "Objects.test()"
	)
	
)
