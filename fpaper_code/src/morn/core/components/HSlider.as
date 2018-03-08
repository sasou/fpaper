/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * admin@sy-y.com
 */
package morn.core.components {
	
	/**水平滚动条*/
	public class HSlider extends Slider {
		
		public function HSlider(skin:String = null) {
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = HORIZONTAL;
		}
	}
}