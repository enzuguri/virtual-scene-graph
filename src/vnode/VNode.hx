package vnode;

class VNode<T>
{
    public var type:Class<T>;

    public var constructArgs:Array<Dynamic>;

    public var properties:Dynamic;

    public var key:String;

    // Empty constructor
    public function new(){ }
}
