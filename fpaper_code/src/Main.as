package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.view.main_view;
	import morn.core.handlers.Handler;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;
	import flash.events.FullScreenEvent;
	
	/**
	 * ...
	 * @author sasou admin@php-gene.com
	 */
	public class Main extends Sprite 
	{
		public var view_main:main_view;
		public static var params:Object = new Object();
		public var scale:Number;
		
		
		public function Main():void 
		{
			scale = stage.stageWidth / stage.stageHeight;
			this.addEventListener(Event.ADDED_TO_STAGE,init);			
		}
		public function init(e:Event):void{
			var mouseStyle:Sprite = new Sprite();			
			if (ExternalInterface.available) {
				params = stage.loaderInfo.parameters;
			}
			if (params.skin == null) params.skin = 'assets/comp';
			App.init(this);
			App.loader.loadAssets([params.skin+'.swf'], new Handler(loadComplete));
			this.addEventListener(Event.RESIZE, onStageResize);
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, screenHandle);

			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, gensui);
						
			function leaveStage(event:Event):void {
					mouseStyle.graphics.clear();
					stage.removeEventListener(MouseEvent.CLICK, view_main.preOnClick);
					stage.removeEventListener(MouseEvent.CLICK, view_main.nextOnClick);
					Mouse.show();
			}
			
			function gensui(event:MouseEvent):void {
				if (!(view_main && stage)) return;
				if (event.stageX > 0 && event.stageX < stage.stageWidth / 6 && event.stageY > 0 && event.stageY < stage.height - view_main.params.botton_height && view_main.pagenum > 0) {
					mouseStyle.graphics.beginFill(0x5884c3);
					mouseStyle.graphics.moveTo(-10, 0);
					mouseStyle.graphics.lineTo(-10, -10);
					mouseStyle.graphics.lineTo(-30, -10);
					mouseStyle.graphics.lineTo(-30, -15);
					mouseStyle.graphics.lineTo(-40, -5);
					mouseStyle.graphics.lineTo(-30, 5);
					mouseStyle.graphics.lineTo(-30, 0);
					mouseStyle.graphics.lineTo(-10,0);
					mouseStyle.graphics.endFill();
					
					addChild(mouseStyle);
					Mouse.hide();
					
					mouseStyle.x=mouseX;
					mouseStyle.y=mouseY;
					event.updateAfterEvent();	
					stage.addEventListener(MouseEvent.CLICK, view_main.preOnClick);
					stage.addEventListener(Event.MOUSE_LEAVE, leaveStage);

				}
				else if (event.stageX > stage.stageWidth * 5 / 6 && event.stageX < stage.stageWidth && event.stageY > 0 && event.stageY < stage.height - view_main.params.botton_height && view_main.pagenum < view_main.allnum) {
					mouseStyle.graphics.beginFill(0x5884c3);
					mouseStyle.graphics.moveTo(-10, 0);
					mouseStyle.graphics.lineTo(-10, -10);
					mouseStyle.graphics.lineTo(10, -10);
					mouseStyle.graphics.lineTo(10, -15);
					mouseStyle.graphics.lineTo(20, -5);
					mouseStyle.graphics.lineTo(10, 5);
					mouseStyle.graphics.lineTo(10, 0);
					mouseStyle.graphics.lineTo(-10, 0);
					mouseStyle.graphics.endFill();
					
					addChild(mouseStyle);
					Mouse.hide();
					
					mouseStyle.x=mouseX;
					mouseStyle.y=mouseY;
					event.updateAfterEvent();	
					stage.addEventListener(MouseEvent.CLICK, view_main.nextOnClick);
					stage.addEventListener(Event.MOUSE_LEAVE, leaveStage);
					stage.removeEventListener(MouseEvent.CLICK, view_main.setCurPage);
				}
				else 
				{
					mouseStyle.graphics.clear();
					if (stage && view_main) {
						stage.addEventListener(MouseEvent.CLICK, view_main.setCurPage);
						stage.removeEventListener(MouseEvent.CLICK, view_main.preOnClick);
						stage.removeEventListener(MouseEvent.CLICK, view_main.nextOnClick);
						Mouse.show();
					}
				}
			}
		}
		private function screenHandle(e:FullScreenEvent):void {    
			if(e.fullScreen){  
				view_main.full.visible = false;
				view_main.noFull.visible = true;
				stage.displayState = "fullScreen";
            }
			else{ 
				view_main.full.visible = true;
				view_main.noFull.visible = false;
				stage.displayState = "normal";
			} 
		} 
		
		
		private function loadComplete():void {
			view_main = new main_view();
			addChild(view_main);
			onStageResize(null);
		}
		public function onStageResize(e:Event):void {
			//stage.height = 300;
			//stage.width = 400;
			stage.stageHeight = view_main.params.height;
			stage.stageWidth = view_main.params.width;
			view_main.height = stage.stageHeight;
			view_main.width = view_main.height * scale;
			//view_main.btn_left.top = stage.stageHeight / 2 - view_main.params.botton_height;
			//view_main.btn_right.top = stage.stageHeight / 2 - view_main.params.botton_height;

			if (view_main.content) {
				view_main.content.height = stage.stageHeight - view_main.params.botton_height;
				view_main.content.width = stage.stageHeight * scale;
				
				view_main.nav.width = view_main.stage.stageWidth;
				view_main.botBg.width = view_main.stage.stageWidth;
				view_main.zoom.right = 4;

				if (view_main.b_swf) {
					if (view_main.b_swf.width > 0) {
						view_main.b_swf.height = view_main.content.height;
						view_main.b_swf.width = view_main.content.width

						
						view_main.b_swf.x = (stage.stageWidth - view_main.b_swf.width) / 2;
						//view_main.b_swf.y = (view_main.content.height - view_main.b_swf.height) / 2;
						view_main.full.x = stage.stageWidth - view_main.full.width;
						view_main.noFull.x = stage.stageWidth - view_main.noFull.width;
						view_main.nav.x = (stage.stageWidth - view_main.nav.width) / 2;
					}
				}
			}
		}
		
		public function _onEnterFrame(e:Event):void {
			if (view_main) {
				onStageResize(null);
				/*
				var mouse_x:int = this.mouseX;
				if ((mouse_x > 0) && (mouse_x <= 50)) {
					view_main.btn_left.visible = true;
				}else {
					view_main.btn_left.visible = false;
				}
				if ((mouse_x > (stage.stageWidth-50)) && (mouse_x <= stage.stageWidth)) {
					view_main.btn_right.visible = true;
				}else {
					view_main.btn_right.visible = false;
				}
				*/
			}
		}
		
	}
	
}