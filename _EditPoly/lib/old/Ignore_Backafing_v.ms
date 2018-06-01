fn Ignore_Backafing_v = 	
(

		curObj = modpanel.getcurrentobject ()
		if curObj.ignoreBackfacing == off  then 
		(
		curObj.ignoreBackfacing = on 
		)
		else
		curObj.ignoreBackfacing = off 
		
		
)