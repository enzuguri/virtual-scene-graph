package;

import js.Browser;
import impl.js.DOMOperations;
import js.html.ParagraphElement;
import js.html.DivElement;

import vnode.VNode;
import vnode.VNodeFactory;
import vtree.create.CreateOperations;
import vtree.diff.DiffOperations;
import vtree.patch.PatchOperations;

class DOMExample
{
    var v:VNodeFactory;
    var c:CreateOperations;
    var d:DiffOperations;
    var p:PatchOperations;

    var currentNode:VNode<DivElement>;
    var rootObject:DivElement;

    function new()
    {
        v = new VNodeFactory();
        c = new CreateOperations(new DOMOperations());
        d = new DiffOperations();
        p = new PatchOperations();
        var node = render(cast {divClass:"firstClass", text:"Hello World"});
        handleNodeUpdate(node);
        handleNodeUpdate(render(cast {divClass:"secondClass", text:"hello world 2"}));
    }

    function handleNodeUpdate(node:VNode<DivElement>)
    {
        if(currentNode == null)
        {
            rootObject = c.create(node);
            js.Browser.document.body.appendChild(rootObject);
        }
        else
        {
            var diff = d.diff(currentNode, node);
            p.patch(diff);
        }

        currentNode = node;
    }

    function render(state:ViewState):VNode<DivElement>
    {
        return v.parent(DivElement, {className:state.divClass}, null, [
            v.leaf(ParagraphElement, {textContent:state.text}),
            v.leaf(ParagraphElement, {textContent:"Hello again"})
        ]);
    }

    public static function main()
    {
        new DOMExample();
    }
}

typedef ViewState =
{
    divClass:String,
    text:String
}
