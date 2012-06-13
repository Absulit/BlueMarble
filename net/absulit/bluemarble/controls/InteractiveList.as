  /**
	BlueMarble - actionscript3 framework
    Copyright (C) 2012  Sebastián Sanabria Díaz - admin@absulit.net

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
   */

package net.absulit.bluemarble.controls {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.absulit.arbolnegro.controls.Grid;
	import net.absulit.arbolnegro.events.ContainerEvent;
	import net.absulit.arbolnegro.interfaces.Container;
	import net.absulit.arbolnegro.interfaces.Destroy;
	import net.absulit.bluemarble.events.InteractiveListEvent;
	
	[Event(name="selectedItemChanged", type="net.absulit.arbolnegro.events.InteractiveListEvent")]
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */

	public class InteractiveList extends Grid implements Destroy{
		private const CONS:String = "constructor";
		private const ERR:String = "child must be InteractiveListItem Class";
		private var _selectedItemID:uint;
		private var _selectedItem:InteractiveListItem;
		private var _container:Container;
		private var _drag:Boolean;
		private var _mask:Sprite;
		
		public function InteractiveList() {
			super();
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}	
		
		private function init():void {
			_selectedItemID = NaN;
			_drag = false;
			_selectedItem = null;
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0xff0000,.3);
			_mask.graphics.drawRect(0, 0, 10, 10);
			_mask.graphics.endFill();
		}
		
		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			_container = new Container();
			_container.addEventListener(ContainerEvent.START_DRAG, onStartDragContainer);
			_container.addEventListener(ContainerEvent.STOP_DRAG, onStopDragContainer);
			//_container.scaleState = "auto";
			_container.content = this;
			_container.width = _width;
			_container.height = _height;	
			_container.constraintH = true;
			
			_container.drag = true;
			
			mask = _mask;
			_mask.width = _width;
			_mask.height = _height;
			this.parent.addChild(_mask);
		}
		
		private function onStartDragContainer(e:ContainerEvent):void {
			//trace("onStartDragContainer");
			_drag = true;			
		}
		
		private function onStopDragContainer(e:ContainerEvent):void {
			//trace("onStopDragContainer");
			//_drag = false;// si da problemas remover	
		}
		

		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child[CONS] != InteractiveListItem ) {
				throw new Error(ERR);
			}
			child.addEventListener(MouseEvent.CLICK, onClickChild);
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):flash.display.DisplayObject {
			if (child[CONS] != InteractiveListItem ) {
				throw new Error(ERR);
			}
			child.addEventListener(MouseEvent.CLICK, onClickChild);
			return super.addChildAt(child, index);
		}
		
		private function onClickChild(e:MouseEvent):void {
			if (!_drag) {
				_selectedItem = InteractiveListItem(e.currentTarget);
				_selectedItemID = getChildIndex(_selectedItem);
				dispatchEvent(new InteractiveListEvent(InteractiveListEvent.SELECTED_ITEM_CHANGED));
			}else {
				_drag = false;
			}
			
		}
		
		override public function sort():void {
			if (numChildren == 0) {
				throw new Error("You must add at least one DisplayObject with addChild or addChildAt");
			}
			var item:DisplayObject;
			for (var k:uint = 0; k < this.numChildren ; k++ ) {
				item = this.getChildAt(k);
				item.width = _width;
			}
			super.sort();
			if (height < _container.height) {
				_container.height = height
			}
			//_mask.width = _width;
			//_mask.height = _height;//******************?
		}
				
		override public function get width():Number {
			return super.width;
		}
		
		override public function set width(value:Number):void {
			_width = value;
			if (_container != null) {
				_container.width = _width;
				
				_mask.width = _width;
				//_mask.height = _height;
			}
		}
		
		override public function get height():Number {
			return super.height;
		}
		
		override public function set height(value:Number):void {
			_height = value;
			if (_container != null) {
				_container.height = _height;
				
				//_mask.width = _width;
				_mask.height = _height;
			}
		}
		
		public function get selectedItemID():uint {
			return _selectedItemID;
		}
		
		public function get selectedItem():InteractiveListItem {
			return _selectedItem;
		}
		
		override public function destroy():void {
			super.destroy();
			for each (var child:DisplayObject in this) {
				child.removeEventListener(MouseEvent.CLICK, onClickChild);
				Destroy(child).destroy();
				removeChild(child);
				child = null;
			}
			_selectedItem = null;
			_selectedItemID = NaN;
			_drag = false;
			if ((_mask != null) && (this.parent != null)) {
				this.parent.removeChild(_mask);
			}			
			_mask = null;
			_container.destroy();
			_container.removeEventListener(ContainerEvent.START_DRAG, onStartDragContainer);
			_container.removeEventListener(ContainerEvent.STOP_DRAG, onStopDragContainer);
			_container = null;
		}
	}

}