package vtree.create;

import vnode.VParentNode;
import vnode.VNode;

class CreateOperations
{
    var opertations:VTreeOperations;

    public function new(ops:VTreeOperations)
    {
        opertations = ops;
    }

    public function create<T>(vNode:VNode<T>):T
    {
        var realNode = opertations.createInstance(vNode.type, vNode.constructArgs);

        for (key in Reflect.fields(vNode.properties))
        {
            var value:Dynamic = Reflect.field(vNode.properties, key);
            untyped realNode[key] = value;
        }

        if(Std.is(vNode, VParentNode))
        {
            var parentNode:VParentNode<T> = cast vNode;
            for(child in parentNode.children)
            {
                opertations.appendChild(realNode, create(child));
            }
        }

        return realNode;
    }
}
