package game.view 
{
	import flash.events.Event;
	import game.ui.mainUI;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.net.navigateToURL;
	import flash.display.StageScaleMode;
	import com.SwfLoader;
	
	/**
	 * ...
	 * @author sasou admin@php-gene.com
	 */
	public class main_view extends mainUI 
	{
		public var loader:Loader;
		public var request:URLRequest;
		public var b_swf:MovieClip;
		public var pagenum:int;
		public var allnum:int;
		public var params:Object;
		
		public var view_main:main_view;
		
		public function main_view() 
		{
			init();
			creatmenu();
		}
		public function creatmenu():void {
			var menu:ContextMenu = new ContextMenu();
			var item1:ContextMenuItem = new ContextMenuItem("PPT文档浏览器 1.3");
			var item2:ContextMenuItem = new ContextMenuItem("author:sasou <admin@php-gene.com>",true);
			item1.addEventListener("menuItemSelect",handle);
			menu.customItems.push(item1,item2);
			menu.hideBuiltInItems();
			contextMenu = menu;
			function handle(event:ContextMenuEvent):void{
				navigateToURL(new URLRequest("http://www.php-gene.com/"),"_blank");
			}
		}
		public function init():void {
			params = new Object();
			params.file_url = null;
			params.width = 755;
			params.height = 566;
			if (ExternalInterface.available) {
				if (Main.params != null) {
					for(var str:String in Main.params)
					{
						setPara(str, Main.params[str]);
					}
				}
				ExternalInterface.addCallback("sy_open", sy_open_call);
				ExternalInterface.addCallback("sy_go", sy_go_call);
				ExternalInterface.addCallback("sy_count", sy_count_call);
				ExternalInterface.addCallback("sy_current", sy_current_call);
				
			}
			if (params.callback == null) params.callback = 'sy_notice';
			if (params.botton_hidden == 1) {
				nav.visible = false;
				params.botton_height = 0;
			} else {
				nav.visible = true;
				params.botton_height = 47;
			}
			
			pagenum = new int (page.text);
			
			pre.addEventListener(MouseEvent.CLICK, preOnClick);
			next.addEventListener(MouseEvent.CLICK, nextOnClick);
			page.addEventListener(KeyboardEvent.KEY_UP, pageOnKey_up);
			//btn_left.addEventListener(MouseEvent.CLICK,btnleftOnClick);
			//btn_right.addEventListener(MouseEvent.CLICK, btnrightOnClick);
			
			full.addEventListener(MouseEvent.CLICK, fullScreen);
			noFull.addEventListener(MouseEvent.CLICK, noFullScreen);
			
			if (params.file_url != null) {
				btnOnClick(null);
			}
			notice('sy_complete', '初始化完成！');
		}
		
		private function setPara(para:String, value:Object):Boolean
		{
			if(value == null)return false;
			switch(para) {
				case 'swf_id':		//标识id
					params.swf_id = String(value);
					break;
				case 'file_url':		//加载url
					params.file_url = String(value);
					break;
				case 'botton_hidden':		//隐藏按钮
					params.botton_hidden = int(value);
					break;
				case 'callback':		//回调函数
					params.callback = (String(value)=='')?'sy_notice':String(value);
					break;
				case 'width':		//宽度
					params.width = Number(value);
					break;
				case 'height':		//高度
					params.height = Number(value);
					break;
				default:
					return false;
					break;
			}
			return true;
		}
			
		public function btnOnClick(e:MouseEvent):void {
			notice('start', '开始加载！');
			progress.visible = true;
			progress.x = (this.width -progress.width) / 2 + 80;
			progress.y = (this.height -progress.height) / 2 + 50;
			var loader:Loader = new Loader();
			var fLoader:SwfLoader = new SwfLoader(loader, loadPROGRESS);
			request = new URLRequest(params.file_url); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler); 
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			fLoader.load(request);
		}
		/*
		public function btnleftOnClick(e:MouseEvent):void {
			preOnClick(null);
		}
		public function btnrightOnClick(e:MouseEvent):void {
			nextOnClick(null);
		}
		*/
		public function sy_open_call(file_url:String):Boolean { 
			if (file_url == '') {
				notice('error', '打开文件不能为空！');
				return false;
			}else {
				params.file_url = file_url;
				btnOnClick(null);
			}
			return true;
		} 
		public function sy_go_call(type:String, p:int):Boolean { 
			switch(type) {
				case 'pre':
					preOnClick(null);
					break;
				case 'next':
					nextOnClick(null);
					break;
				case 'page':
					if (p > 0) {
						pagenum = p;
						page.text = pagenum.toString();
						b_swf.gotoAndStop(pagenum);
					}
					break;
				default:
					notice('error', '错误的操作类型！');
					break;
			}
			return true;
		} 
		
		public function sy_count_call():int { 
			return allnum;
		} 
		
		public function sy_current_call():int { 
			return pagenum;
		} 
		
		public function preOnClick(e:MouseEvent):void {
			pagenum = b_swf.currentFrame;
			--pagenum;
			if (pagenum > 0) {
				page.text = pagenum.toString();
				b_swf.gotoAndStop(pagenum);
			} else {
				page.text = '1';
				pagenum = 1;
			}
		}
		
		public function setCurPage(e:MouseEvent):void {
			pagenum = b_swf.currentFrame;
			page.text = pagenum.toString();
		}
		
		public function nextOnClick(e:MouseEvent):void {
			pagenum = b_swf.currentFrame;
			if (pagenum < allnum) {
				++pagenum;
				page.text = pagenum.toString();
				b_swf.gotoAndStop(pagenum);
			} else {
				page.text = allnum.toString();
				pagenum = allnum;
			}
		}
		
		public function pageOnKey_up(e:KeyboardEvent):void {
			pagenum = new int (page.text);
			
			if (e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 96 && e.keyCode <= 105 || e.keyCode == 8) {
				if (pagenum > 0 && pagenum <= new int (allnum)) {
					b_swf.gotoAndStop(pagenum);
				}	
			}
			else if (e.keyCode >= 65 && e.keyCode <= 90 || e.keyCode >= 106 && e.keyCode <= 107 || e.keyCode >= 109 && e.keyCode <= 111 || e.keyCode >= 186 && e.keyCode <= 188)
			{
				page.text = page.text.substring(0, page.text.length - 1);
			}
		}
		
		public function fullScreen(e:MouseEvent):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			full.visible = false;
			noFull.visible = true;
			stage.displayState = "fullScreen";
		}
		
		public function noFullScreen(e:MouseEvent):void 
		{
			full.visible = true;
			noFull.visible = false;
			stage.displayState = "normal";
		}

		public function completeHandler(e:Event):void {
			if (b_swf) {
				content.removeChild(b_swf);
			}
			try { 
				b_swf = e.target.content;
			} catch (e:Error) {
				notice('error', '不支持的文件类型！');
			}
			if (b_swf) {
				allnum = b_swf.totalFrames;
				b_swf.height = this.height - params.botton_height;
				var bfb:Number = Math.floor(this.height / b_swf.height);
				b_swf.width = this.width * bfb;
				if (allnum > 0) {
					content.addChild(b_swf);
					content.width = b_swf.width;
					content.height = b_swf.height;
					nav.width = stage.stageWidth;
					botBg.width = stage.stageWidth;
					
					b_swf.gotoAndStop(1);
					pagenum = 1;
					page.text = pagenum.toString();
					totPage.text = allnum.toString();
				}
			}
			progress.visible = false;
			notice('complete', '开始完成！');
		}
		
		public function securityErrorHandler(e:Event):void {
			notice('error', '安全沙箱错误！');
		}
		
		public function ioErrorHandler(e:Event):void {
			notice('error', 'io错误！');
		}
		
		public function loadPROGRESS(e:ProgressEvent):void {
			var total:Number = e.bytesTotal;
			var loaded:Number = e.bytesLoaded;
			doproggress(total, loaded);
		}
		
		public function doproggress(total:Number,loaded:Number):void {
			var bfb:Number = loaded / total;
			progress.value = bfb;
		}
		
		private function notice(type:String,str:String):void
		{
			if (ExternalInterface.available) {
				ExternalInterface.call(params.callback,params.swf_id, type, str); 
			} else {
				trace("test:" + str);
			}
		}
		
	}

}