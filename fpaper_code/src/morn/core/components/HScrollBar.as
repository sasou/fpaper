/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * admin@sy-y.com
 */
package morn.core.components {
	
	/**水平滚动条*/
	public class HScrollBar extends ScrollBar {
		
		public function HScrollBar(skin:String = null) {
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			_slider.direction = HORIZONTAL;
		}
	}
}