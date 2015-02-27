package vtree;

class TypedVTreeOperations implements VTreeOperations
{
    public function createInstance<T>(type:Class<T>, args:Array<Dynamic>):T
    {
        if (args == null){
            args = [];
        }
        return Type.createInstance(type, args);
    }

    public function appendChild<T,C>(parent:T, child:C):C
    {
        return child;
    }
}
