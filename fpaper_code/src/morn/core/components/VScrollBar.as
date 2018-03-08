/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * admin@sy-y.com
 */
package morn.core.components {
	
	/**垂直滚动条*/
	public class VScrollBar extends ScrollBar {
		
		public function VScrollBar(skin:String = null) {
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			_slider.direction = VERTICAL;
		}
	}
}