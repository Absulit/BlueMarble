package net.absulit.bluemarble.windows {
	import flash.events.Event;
	import net.absulit.bluemarble.controls.Text;
	import net.absulit.bluemarble.controls.Window;
	import net.absulit.bluemarble.controls.ControlsConstants;
	/**
	 * Class with a full width/height Text 
	 * @author Sebastian Sanabria Diaz
	 */
	public class TextWindow extends Window {
		protected var _content:Text;
		public function TextWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
		}
		
		override protected function init():void {
			super.init();
			_content = new Text();
			_content.multiline = true;
			_content.wordWrap = true;
		}
		
		override protected function addedToStage(e:Event=null):void {
			super.addedToStage(e);
			_content.x = ControlsConstants.TEXT_MARGIN;
			_content.y = ControlsConstants.TEXT_MARGIN;
			_content.width = width - (ControlsConstants.TEXT_MARGIN * 2);
			_content.height = height - (ControlsConstants.TEXT_MARGIN * 2);
			addChild(_content);
		}
		
		override protected function onResizeStage(e:Event):void {
			super.onResizeStage(e);
			_content.width = width;
			_content.height = height;
		}
		
		override public function destroy():void {
			super.destroy();
			removeChild(_content);
			_content = null;
		}
	}

}