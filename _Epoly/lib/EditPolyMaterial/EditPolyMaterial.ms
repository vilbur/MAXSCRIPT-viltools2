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
