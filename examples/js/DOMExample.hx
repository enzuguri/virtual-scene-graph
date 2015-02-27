package;

import js.Browser;
import impl.js.DOMOperations;
import js.html.ParagraphElement;
import js.html.DivElement;

import vnode.VNode;
import vnode.VNodeFactory;
import vtree.create.CreateOperations;

class DOMExample
{
    var v:VNodeFactory;
    var c:CreateOperations;

    var currentNode:VNode<DivElement>;
    var rootObject:DivElement;

    function new()
    {
        v = new VNodeFactory();
        c = new CreateOperations(new DOMOperations());
        var node = render(cast {text:"Hello World"});
        handleNodeUpdate(node);
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
            // TODO: diff implementation
        }

        currentNode = node;
    }

    function render(state:ViewState):VNode<DivElement>
    {
        return v.parent(DivElement, {className:"myClass"}, null, [
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
    text:String
}
