package net.absulit.bluemarble.windows {
	import flash.events.Event;
	import net.absulit.bluemarble.controls.InteractiveList;
	import net.absulit.bluemarble.controls.Window;
	import net.absulit.bluemarble.events.InteractiveListEvent;
	
	/**
	 * Just a Window with an InteractiveList
	 * @author Sebastian Sanabria Diaz
	 */
	public class InteractiveListWindow extends Window {
		protected var _interactiveList:InteractiveList;
		public function InteractiveListWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
		}
		
		override protected function init():void {
			super.init();
			_interactiveList = new InteractiveList();
			_interactiveList.addEventListener(InteractiveListEvent.SELECTED_ITEM_CHANGED, onSelectedItemChangedInteractiveList);
		}
		
		protected function onSelectedItemChangedInteractiveList(e:InteractiveListEvent):void {
			
		}
		
		override protected function addedToStage(e:Event=null):void {
			super.addedToStage(e);
			_interactiveList.width = width;
			_interactiveList.height = height;
			addChild(_interactiveList);
		}
		
		override protected function onResizeStage(e:Event):void {
			_interactiveList.width = width;
			_interactiveList.height = height;
			_interactiveList.sort();
		}
		
		override public function destroy():void {
			super.destroy();			
			removeChild(_interactiveList);
			_interactiveList.destroy();
			_interactiveList = null;
		}
		
	}

}