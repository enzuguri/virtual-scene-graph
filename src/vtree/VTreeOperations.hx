package vtree;

interface VTreeOperations
{
    function createInstance<T>(type:Class<T>, args:Array<Dynamic>):T;

    function appendChild<T,C>(parent:T, child:C):C;
}
