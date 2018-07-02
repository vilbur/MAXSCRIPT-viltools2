/** ShellModifier_ modifier
 */
struct Relax_Modifier_v
(
	/** Get
	 */
	function get =
	(
		--Edit_Poly()
		Relax Relax_Value:1 --return

	),
	
	
	function test =
	(
		messagebox "EditPoly_Modifier.test()"
	)
)


--mapped function mappedTest obj _tring =
--(
--	print ( "obj.name = " + obj.name as string )
--	print ( "_tring = " + _tring as string )
--)
--
--collection = for o in selection where superclassof o == GeometryClass collect o
--
--mappedTest collection[1] "STRING"