package vnode;

class VNodeFactory
{
    var pool:VNodePool;

    public function new()
    {
        pool = new VNodePool();
    }

    public function leaf<T>(type:Class<T>, props:Dynamic, ?constructArgs:Array<Dynamic>, ?key:String):VNode<T>
    {
        var node:VNode<T> = pool.acquireLeafNode();
        setLeafProps(node, type, props, constructArgs, key);
        return node;
    }

    public function parent<T>(type:Class<T>, props:Dynamic, ?constructArgs:Array<Dynamic>, ?children:Array<VNode<Dynamic>>, ?key:String):VParentNode<T>
    {
        var node:VParentNode<T> = pool.acquireParentNode();
        setLeafProps(node, type, props, constructArgs, key);
        node.children = children;
        return node;
    }

    function setLeafProps<T>(node:VNode<T>, type:Class<T>, props:Dynamic, constructArgs:Array<Dynamic>, key:String)
    {
        node.type = type;
        node.constructArgs = constructArgs;
        node.properties = props;
        node.key = key;
    }

}
