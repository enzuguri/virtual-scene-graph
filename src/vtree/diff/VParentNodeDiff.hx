package vtree.diff;

import vnode.VNode;

class VParentNodeDiff<T> extends VNodeDiff<T>
{
    public var changedChildren:Array<VNodeDiff<Dynamic>>;

    public function new(node:VNode<T>)
    {
        changedChildren = [];
        super(node);
    }
}
