package net.absulit.bluemarble.windows {
	import flash.events.Event;
	import net.absulit.bluemarble.controls.InteractiveList;
	import net.absulit.bluemarble.controls.Window;
	
	/**
	 * Just a Window with an InteractiveList
	 * @author Sebastian Sanabria Diaz
	 */
	public class InteractiveListWindow extends Window {
		protected var _interactiveList:InteractiveList;
		public function InteractiveListWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_interactiveList = new InteractiveList();
		}
		
		private function addedToStage(e:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			_interactiveList.width = width;
			_interactiveList.height = height;
			addChild(_interactiveList);
			stage.addEventListener(Event.RESIZE, onResizeStage);
		}
		
		private function onResizeStage(e:Event):void {
			_interactiveList.width = width;
			_interactiveList.height = height;
			_interactiveList.sort();
		}
		
		override public function destroy():void {
			super.destroy();			
			removeChild(_interactiveList);
			_interactiveList.destroy();
			_interactiveList = null;
			stage.removeEventListener(Event.RESIZE, onResizeStage);
		}
		
	}

}