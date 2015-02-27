package vtree.diff;

import vnode.VNode;

class VNodeDiff<T>
{
	public var properties:VPropertyDiff;

	public var vNode:VNode<T>;

	public function new(node:VNode<T>)
	{
		vNode = node;
	}
}
