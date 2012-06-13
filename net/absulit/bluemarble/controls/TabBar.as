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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.absulit.arbolnegro.controls.Grid;
	import net.absulit.arbolnegro.interfaces.Destroy;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class TabBar extends Grid implements Destroy {
		private static const ERR:String = "child must be TabBarItem Class";
		private var previousSelectedIndex:uint;
		private var _selectedItem:TabBarItem;
		private var _previousSelectedItem:TabBarItem;
		public function TabBar() {
			super();
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			previousSelectedIndex = 0;
		}
		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child[ControlsConstants.CONSTRUCTOR] != TabBarItem ) {
				throw new Error(ERR);
			}
			//TabBarItem(child).toggle = true;
			if (numChildren == 0) {
				TabBarItem(child).selected = true;
			}
			child.addEventListener(MouseEvent.CLICK, onClickChild);
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):flash.display.DisplayObject {
			if (child[ControlsConstants.CONSTRUCTOR] != TabBarItem ) {
				throw new Error(ERR);
			}
			//TabBarItem(child).toggle = true;
			if (numChildren == 0) {
				TabBarItem(child).selected = true;
			}
			child.addEventListener(MouseEvent.CLICK, onClickChild,false,1);
			return super.addChildAt(child, index);
		}
		
		private function onClickChild(e:MouseEvent):void {
			var clickedChild:TabBarItem = TabBarItem(e.currentTarget);
			var previousChild:TabBarItem = TabBarItem(getChildAt(previousSelectedIndex));
			previousChild.selected = false;
			clickedChild.selected = true;
			/*if (previousChild.id != clickedChild.id) {
				clickedChild.selected = true;
			}*/
			_selectedItem = clickedChild;
			_previousSelectedItem = previousChild;
			previousSelectedIndex = getChildIndex(clickedChild);

		}
		
		public function getTabBarItemAt(index:uint):TabBarItem {
			return TabBarItem(getChildAt(index));
		}
		
		override public function sort():void {
			super.sort();
			//trace(_rows.length);
			/*var row:Vector.<DisplayObject>;
			var item:DisplayObject;
			var newItemWidth:int;
			var widthCurrentItems:int;
			var previousItem:DisplayObject;
			for (var k:int = 0; k < _rows.length; k++) {
				previousItem = null;
				row = _rows[k];
				newItemWidth = _width / row.length;
				widthCurrentItems = 0;
				for (var i:int = 0; i < row.length; i++) {
					item = row[i];
					//trace(item.width, newItemWidth);
					if (item.width > newItemWidth) {
						//create newItemWidth
						widthCurrentItems += item.width
						newItemWidth = (_width - widthCurrentItems) / (row.length - (i+1))//****
						//item.width = newItemWidth;
					}else {
						item.width = newItemWidth;
					}
					widthCurrentItems += item.width;
					if (previousItem != null) {
						item.x = previousItem.x + previousItem.width;
					}
					previousItem = item;
				}
			}*/
			//super.sort();
		}
		
		public function get selectedItem():TabBarItem {
			return _selectedItem;
		}
		
		public function get previousSelectedItem():TabBarItem {
			return _previousSelectedItem;
		}
		
		override public function destroy():void {
			super.destroy();
			for each (var child:DisplayObject in this) {
				child.removeEventListener(MouseEvent.CLICK, onClickChild);
				removeChild(child);
				Destroy(child).destroy();
				child = null;
			}
			previousSelectedIndex = NaN;
			_selectedItem = null;
		}
	}

}