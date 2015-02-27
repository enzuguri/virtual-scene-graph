package vnode;

class VNodePool
{
    public function acquireLeafNode<T>():VNode<T>
    {
        // TODO: actual pooling implementation
        return new VNode<T>();
    }

    public function acquireParentNode<T>():VParentNode<T>
    {
        // TODO: actual pooling implementation
        return new VParentNode<T>();
    }

    // Empty constructor
    public function new(){ }
}
