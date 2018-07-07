/** Edit poly objects
 */
struct EditPolyMaterial_v
(
	EpolyMod	= EpolyMod_v(),

	/** Set mat id
	 */
	function setMatId id =
	(
		Epoly = EpolyMod.getEpoly()

		Epoly.setMatId (Epoly.getSelectedOrAllFaces()) id 
	),
	/** Set mat id
	 */
	function setMatIdToObject id =
	(
		Epoly = EpolyMod.getEpoly()

		Epoly.setMatId (Epoly._allFaces()) id 
	),
	
	--/** Select material
	-- */
	--function selectMaterial id =
	--(
	--	
	--),
	--/** Unselect material
	-- */
	--function unselectMaterial id =
	--(
	--	
	--),
	
	function test =
	(
		messagebox "EditPolyObjects.test()"
	)
)
