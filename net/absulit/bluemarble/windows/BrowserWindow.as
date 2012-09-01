package net.absulit.bluemarble.windows {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import net.absulit.bluemarble.controls.Window;
	import net.absulit.bluemarble.events.WindowEvent;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class BrowserWindow extends Window {
		protected var _stageWebView:StageWebView;
		public function BrowserWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
		}
		
		override protected function init():void {
			super.init();
			_stageWebView = new StageWebView();		
			addEventListener(WindowEvent.BEFORE_EXIT, onBeforeExit);
		}
		
		override protected function addedToStage(e:Event=null):void {
			super.addedToStage(e);			
			_stageWebView.viewPort = new Rectangle(0, _actionBar.height, width, height);
			_stageWebView.addEventListener(Event.COMPLETE, onCompleteStageWebView);
			
		}
		
		private function onCompleteStageWebView(e:Event):void {
			trace("onCompleteStageWebView");
			_stageWebView.stage = stage;
		}
		
		protected function call(functionName:String, ...rest):void {
			var params:String;
			var loadURL:String
			
			if (rest.length > 0) {
				var item:String = "";
				for (var i:int = 0; i < rest.length; i++) {
					if (rest[i] != null) {
						params += "'" + rest[i] + "',";
					}
				}
				params = params.slice( 0, -1 );
				params = params.replace("null","");
			}
			loadURL = "javascript:" + functionName + "(" + params + ")";
			_stageWebView.loadURL(loadURL);
		}		
		
		protected function onBeforeExit(e:WindowEvent):void {
			try {
				var bitmapData:BitmapData = new BitmapData(_stageWebView.viewPort.width, _stageWebView.viewPort.height); 
				_stageWebView.drawViewPortToBitmapData(bitmapData); 
				var webViewBitmap:Bitmap = new Bitmap(bitmapData); 
				addChild(webViewBitmap);
				
				
				_stageWebView.stage = null;
				_stageWebView.dispose();	
			}catch (err:Error){
				trace("onBeforeExit",err);
			}

		}
		
		override protected function onResizeStage(e:Event):void {
			super.onResizeStage(e);
			_stageWebView.viewPort = new Rectangle(0, _actionBar.height, width, height);
		}
		
		
		override public function destroy():void {
			super.destroy();
			
			//_stageWebView = null;
		}
	}

}