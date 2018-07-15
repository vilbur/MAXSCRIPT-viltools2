




struct MyStruct (
    fn MyNestedStruct = ((struct _(
        firstValue,
        secondValue = 42;
    );)())
)




_instance = MyStruct.MyNestedStruct()


print ( "_instance = " + _instance.secondValue as string )
