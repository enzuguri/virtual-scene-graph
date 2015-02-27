package;
import impl.flash.DisplayListOperations;
import flash.display.DisplayObject;
import flash.Lib;
import vtree.create.CreateOperations;
import flash.text.TextField;
import flash.display.Sprite;
import vnode.VNodeFactory;
import vnode.VNode;

class Simple
{
    var v:VNodeFactory;
    var c:CreateOperations;

    var currentNode:VNode<Sprite>;
    var rootObject:DisplayObject;

    function new()
    {
        v = new VNodeFactory();
        c = new CreateOperations(new DisplayListOperations());
        var node = render(cast {x:0, y:0});
        handleNodeUpdate(node);
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
            // TODO: diff implementation
        }

        currentNode = node;
    }

    function render(state:ViewState):VNode<Sprite>
    {
        return v.parent(Sprite, {x:state.x, y:state.y}, null, [
            v.leaf(TextField, {text:"Hello World"}),
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
    y:Float
}
