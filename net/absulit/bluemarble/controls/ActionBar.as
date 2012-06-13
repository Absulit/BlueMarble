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
	import flash.display.Sprite;
	import flash.events.Event;
	import net.absulit.arbolnegro.layouts.LiquidLayoutAlign;
	import net.absulit.arbolnegro.layouts.LiquidLayoutObject;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class ActionBar extends ControlBase {
		private var _title:Text;
		private var _navigation:Button;
		private var _action:Button;
		private var _llo:LiquidLayoutObject;
		public function ActionBar() {
			super(320,50);
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_title = new Text();
			_title.selectable = false;
			//_title.text ="eliminar luego"
		}
		
		private function addedToStage(e:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			if(_action != null){
				_llo = new LiquidLayoutObject(_action, LiquidLayoutAlign.RIGHT, .1)
			}
			addChild(_title);
		}
		
		public function get title():String { return _title.text; }
		
		public function set title(value:String):void {
			_title.text = value;			
			_title.x = (width - _title.width) / 2;
			_title.y = (height - _title.height) / 2;
			
		}
		
		public function get navigation():Button {
			return _navigation;
		}
		
		public function set navigation(value:Button):void {
			if (_navigation != null) {
				removeChild(_navigation);
			}
			_navigation = value;
			if (_navigation != null) {
				addChild(_navigation);
				
			}
			sortTitle();
		}
		
		public function get action():Button {
			return _action;
		}
		
		public function set action(value:Button):void {
			if (_action != null) {
				removeChild(_action);
			}
			_action = value;
			if ((_action != null) ) {
				//_action.x = width - _action.width;				
				addChild(_action);
				if(stage != null){
					_llo = new LiquidLayoutObject(_action, LiquidLayoutAlign.RIGHT, .1)
				}				
			}
			sortTitle();
		}
		
		private function sortTitle():void {
			if ( (_action != null) &&(_navigation != null)) {				
				var space:int = width - (_navigation.width + _action.width);
				
				if (_title.width > space) {
					_title.width = space - (ControlsConstants.TEXT_MARGIN * 2);
				}
				
				_title.x = _navigation.width + ControlsConstants.TEXT_MARGIN;
				_title.y = (height - _title.height) / 2;
			}
		}
		
		override public function get width():Number {
			return super.width;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			if (_title != null) {
				_title.x = (width - _title.width) / 2;
			}
			sortTitle();
		}
		
		override public function destroy():void {
			super.destroy();
			if (_title != null) {
				removeChild(_title);
				_title = null;
			}
			if (_navigation != null) {
				removeChild(_navigation);
			}
			_navigation = null;
			if (_action != null) {
				removeChild(_action);
			}
			_action = null;
			_llo = null;
		}
	}

}