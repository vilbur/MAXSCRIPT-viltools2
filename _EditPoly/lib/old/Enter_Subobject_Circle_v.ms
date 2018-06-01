/*
subObj = 1
Enter_Subobject_v 4
*/
	--start

fn Enter_Subobject_Circle_v direction =
(
	ModClass = classof (modPanel.getCurrentObject ())
	
	If SubObjectLevel == undefined then
	if CurModTest_v() == true then (modPanel.addModToSelection (Edit_Poly ()) ui:on	)
	
	if direction == 1 then
	(
		case subobjectlevel of
		(
			0: subobjectlevel =  1
			1: subobjectlevel =  2
			2: subobjectlevel =  3
			3: subobjectlevel =  4
			4: subobjectlevel =  5
			5: subobjectlevel =  0	
		)
	)
	else
	(
		case subobjectlevel of
		(
			0: subobjectlevel =  5
			1: subobjectlevel =  0
			2: subobjectlevel =  1
			3: subobjectlevel =  2
			4: subobjectlevel =  3
			5: subobjectlevel =  4
		)
	)
	
)

--end

/*
local solIniFile = (getFilenamePath (getSourceFileName()))+ "SubObjLEvelINI.ini"
	if (doesFileExist solIniFile == true) then
	(
		local sL = (getINISetting solIniFile "SOL" "curSOL") as integer
		local tL = (getINISetting solIniFile "SOL" "topSOL") as booleanclass
		if sL != 0 and not tL then 
		(
			setIniSetting solIniFile "SOL" "curSOL" (subobjectlevel as string)
			subobjectlevel = 0				
			setIniSetting solIniFile "SOL" "topSOL" (true as string)
			
		)
		else		
		(	
			if subobjectlevel	!= ((getINISetting solIniFile "SOL" "curSOL") as integer) and subobjectlevel != 0 then
			(
				setIniSetting solIniFile "SOL" "curSOL" (subobjectlevel as string)
				subobjectlevel = 0				
				setIniSetting solIniFile "SOL" "topSOL" (true as string)
			)
			else
			(
				subobjectlevel = (getINISetting solIniFile "SOL" "curSOL") as integer
				setIniSetting solIniFile "SOL" "curSOL" (subobjectlevel as string)
				setIniSetting solIniFile "SOL" "topSOL" (false as string)
			)
		)
	)
	else
	(
		setIniSetting solIniFile "SOL" "curSOL" (subobjectlevel as string)
		setIniSetting solIniFile "SOL" "topSOL" (false as string)
	)


*/