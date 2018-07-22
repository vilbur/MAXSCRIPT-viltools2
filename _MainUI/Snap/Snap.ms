/** Snap ui
 */
struct Snap_v
(
	/** Turn off all snaps
	 */
	function disableAll =
	(
		for i = 1 to snapMode.numOSnaps do
			for j = 1 to (snapmode.getOSnapNumItems i) do
				snapmode.setOSnapItemActive i j false
	),
	/** Print All snaps
	 */
	function printAll =
	(
		for i = 1 to snapMode.numOSnaps do
		(
			format "------------------\n%: name: \"%\"\n" i (snapmode.getOSnapName i)
			for j = 1 to (snapmode.getOSnapNumItems i) do
				format " %: name: \"%\";	tooltip: \"%\";	state: %\n" j \
				(snapmode.getOSnapItemName i j) \
				(snapmode.getOSnapItemToolTip i j) \
				(snapmode.getOSnapItemActive i j)
		)
	),
	/** Snap off
	 */
	function snapOff =
	(
		actionMan.executeAction 0 "40077"  -- Views: Hide Snaps Toggle
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "MainUI.test()"
	)
)

