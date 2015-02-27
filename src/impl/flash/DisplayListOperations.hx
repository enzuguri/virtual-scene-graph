package impl.flash;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import vtree.TypedVTreeOperations;

class DisplayListOperations extends TypedVTreeOperations
{
    public function new() { }

    override public function appendChild<T,C>(parent:T, child:C):C
    {
        var container:DisplayObjectContainer = cast parent;
        container.addChild(cast child);
        return child;
    }
}
