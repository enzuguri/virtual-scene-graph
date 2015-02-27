package vtree.diff;
import vnode.VParentNode;
import vnode.VNode;

class DiffOperations
{
    public function new()
    {
    }

    function createDiffClass<T>(left:VNode<T>, right:VNode<T>):VNodeDiff<T>
    {
        //update reference on right side
        right.realNode = left.realNode;

        if(Std.is(left, VParentNode))
        {
            return new VParentNodeDiff(right);
        }

        return new VNodeDiff(right);
    }

    public function diff<T>(left:VNode<T>, right:VNode<T>):VNodeDiff<T>
    {
        var diff:VNodeDiff<T> = createDiffClass(left, right);
        var hasChanged = false;

        // if same type and key
        if (left.type == right.type && left.key == right.key)
        {
            var propDiff = diffProps(left.properties, right.properties);
            if (propDiff != null)
            {
                hasChanged = true;
                diff.properties = propDiff;
            }

            if(Std.is(diff, VParentNodeDiff))
            {
                var childChange = diffChildren(cast left, cast right, cast diff);
                if(childChange){
                    hasChanged = true;
                }
            }
        }

        return hasChanged ? diff : null;
    }

    function diffChildren<T>(left:VParentNode<T>, right:VParentNode<T>, parentDiff:VParentNodeDiff<T>):Bool
    {
        var hasChanged = false;
        var l = left.children.length;
        for(i in 0...l)
        {
            var leftChild = left.children[i];
            var rightChild = right.children[i];

            var childDiff = diff(leftChild, rightChild);
            if(childDiff != null)
            {
                hasChanged = true;
                parentDiff.changedChildren.push(childDiff);
            }
        }

        return hasChanged;
    }

    function diffProps(left:Dynamic, right:Dynamic):VPropertyDiff
    {
        var diff:VPropertyDiff;

        var hasChanged:Bool = false;

        var removed:Array<String> = [];
        var changed:Dynamic = {};
        var checked:Map<String, Bool> = new Map<String,Bool>();

        for (leftKey in Reflect.fields(left))
        {
            checked.set(leftKey, true);
            // if not in new object
            if(!Reflect.hasField(right, leftKey))
            {
                hasChanged = true;
                removed.push(leftKey);
                continue;
            }

            var leftVal:Dynamic = Reflect.field(left, leftKey);
            var rightVal:Dynamic = Reflect.field(right, leftKey);

            if(leftVal == rightVal)
            {
                continue;
            }
            else
            {
                hasChanged = true;
                untyped changed[leftKey] = rightVal;
            }
        }

        for (rightKey in Reflect.fields(right))
        {
            if(!checked.exists(rightKey))
            {
                hasChanged = true;
                untyped changed[rightKey] = Reflect.field(right, rightKey);
            }
        }

        if(hasChanged)
        {
            return cast {
                changed:changed,
                removed:removed
            }
        }

        return null;
    }

}
