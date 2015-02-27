package impl.js;
import js.html.SelectElement;
import js.html.TableElement;
import js.html.SpanElement;
import Class;
import js.Browser;
import js.html.ParagraphElement;
import js.html.DivElement;
import vtree.VTreeOperations;
import js.html.Node;

class DOMOperations implements VTreeOperations
{
    public function new() { }

    public function createInstance<T>(type:Class<T>, args:Array<Dynamic>):T
    {
        if (args == null){
            args = [];
        }

        //TODO: Can this be better?
        var tagName = findTagName(type);

        if(tagName != null)
        {
            return cast js.Browser.document.createElement(tagName);
        }

        return null;
    }

    function findTagName<T>(type:Class<T>):String
    {
        switch(type)
        {
            case DivElement: return "div";
            case ParagraphElement: return "p";
            case SpanElement: return "span";
            case TableElement: return "table";
            case SelectElement: return "select";
            default: return null;
        }

        return null;
    }

    public function appendChild<T,C>(parent:T, child:C):C
    {
        var container:Node = cast parent;
        container.appendChild(cast child);
        return child;
    }
}
