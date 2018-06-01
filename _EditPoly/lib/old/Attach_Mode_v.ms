fn Attach_Selected_v  =
(	
			
	curmod = Modpanel.getcurrentObject()

	if curmod == undefined do
	(
		max modify mode
		curmod = Modpanel.getcurrentObject()
	)
	
	modClass =  classof curmod
	
	if	(modClass != Editable_Poly  AND modClass!= Edit_Poly and modClass != Wall) then 
	(
		addmodifier selection (Edit_Poly ())
			max create mode
			max modify mode
	)
	
	case modClass of
	(	
	
		(Editable_Poly or Edit_Poly) :(curmod = Modpanel.getcurrentObject(); curmod.EnterPickMode #Attach)
		
	
	)

)
