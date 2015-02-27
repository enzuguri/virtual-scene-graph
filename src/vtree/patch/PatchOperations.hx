package vtree.patch;

import vtree.diff.VParentNodeDiff;
import vtree.diff.VPropertyDiff;
import vtree.diff.VNodeDiff;

class PatchOperations
{

    public function new()
    {

    }

    public function patch<T>(diff:VNodeDiff<T>)
    {
        if(diff == null)
        {
            return;
        }

        patchProperties(diff.properties, diff.vNode.realNode);

        if(Std.is(diff, VParentNodeDiff))
        {
            patchChildren(cast diff);
        }
    }

    function patchChildren<T>(diff:VParentNodeDiff<T>)
    {
        for(changed in diff.changedChildren)
        {
            patch(changed);
        }
    }

    function patchProperties<T>(diff:VPropertyDiff, realNode:T)
    {
        if(diff == null)
        {
            return;
        }

        for(removed in diff.removed)
        {
            Reflect.setProperty(realNode, removed, null);
        }

        for (key in Reflect.fields(diff.changed))
        {
            var value:Dynamic = Reflect.getProperty(diff.changed, key);
            Reflect.setProperty(realNode, key, value);
        }
    }
}
