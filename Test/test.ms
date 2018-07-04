

/** Test struct
 */
struct TestStruct_v
(
	
	function test param =
	(
		messagebox ("TestStruct.test() " +param)
	)
)

--(TestStruct_v()).test "TEST PARAM"


execute "(TestStruct_v()).test @TEST PARAM@"