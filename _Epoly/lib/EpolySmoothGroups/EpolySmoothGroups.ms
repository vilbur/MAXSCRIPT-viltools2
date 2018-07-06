/** Epoly SmoothGroups
 */
struct EpolySmoothGroups_v
(
	EpolyMod	= EpolyMod_v(),
	
	/** Set smooth group
	  * @param	integer	smooth_group	
	  * @param	bitArray	facelists 	All faces used if facelist==undefined
	 */
	function setSmoothGroup smooth_group facelist:undefined =
	(
		(EpolyMod.getEpoly()).setSmoothGroup smooth_group facelist:facelist
	),
	
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		(EpolyMod.getEpoly()).autoSmooth _angle
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		(EpolyMod.getEpoly()).clearSmoothGroups()
	),
	
	function test =
	(
		messageBox "EpolyOptions_v.test()"
	)
)
