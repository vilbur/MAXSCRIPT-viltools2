/** Close info center on top right conrner of Max window
 */
fn getIChwnd=
(
	controlshwnds=windows.getChildrenHWND #max
	out=for c in controlshwnds where c[5]=="InfoCenterHwndSource" collect c
	out
)

mh=getIChwnd()

if( mh.count > 0 ) do
	UIAccessor.CloseDialog mh[1][1]