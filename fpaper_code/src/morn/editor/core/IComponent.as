/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * admin@sy-y.com
 */
package morn.editor.core {
	/**组件接口，实现了编辑器组件类型*/
	public interface IComponent{
		function get comXml():XML;
		function set comXml(value:XML):void;
	}
}