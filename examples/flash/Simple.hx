package;

import impl.flash.DisplayListOperations;
import flash.display.DisplayObject;
import flash.Lib;
import vtree.create.CreateOperations;
import vtree.diff.DiffOperations;
import vtree.patch.PatchOperations;
import flash.text.TextField;
import flash.display.Sprite;
import vnode.VNodeFactory;
import vnode.VNode;

class Simple
{
    var v:VNodeFactory;
    var c:CreateOperations;
    var d:DiffOperations;
    var p:PatchOperations;

    var currentNode:VNode<Sprite>;
    var rootObject:DisplayObject;

    function new()
    {
        v = new VNodeFactory();
        c = new CreateOperations(new DisplayListOperations());
        d = new DiffOperations();
        p = new PatchOperations();
        var node = render(cast {x:0, y:0, text:"Hello World"});
        handleNodeUpdate(node);
        handleNodeUpdate(render(cast {x:0, y:50, text:"Hello again"}));
    }

    function handleNodeUpdate(node:VNode<Sprite>)
    {
        if(currentNode == null)
        {
            rootObject = c.create(node);
            flash.Lib.current.addChild(rootObject);
        }
        else
        {
            var diff = d.diff(currentNode, node);
            p.patch(diff);
        }

        currentNode = node;
    }

    function render(state:ViewState):VNode<Sprite>
    {
        return v.parent(Sprite, {x:state.x, y:state.y}, null, [
            v.leaf(TextField, {text:state.text}),
            v.leaf(TextField, {y:50, text:"Hello again"})
        ]);
    }

    public static function main()
    {
        new Simple();
    }
}

typedef ViewState =
{
    x:Float,
    y:Float,
    text:String
}
