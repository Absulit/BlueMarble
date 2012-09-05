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
	import flash.events.Event;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	import net.absulit.arbolnegro.interfaces.image.SimpleImageContained;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class TabBarItem extends Button {
		
		private var _thumb:SimpleImageContained;
		private var _id:uint;
		public function TabBarItem() {
			super();
		}
		
		override protected function addedToStage(e:Event=null):void {
			super.addedToStage(e);
			if(_thumb != null){
				adjustThumb();
			}
		}
		

		
		public function get thumbPath():String {
			var path:String = "";
			if (_thumb != null) {
				path = _thumb.path;
			}
			return path;
		}
		
		public function set thumbPath(value:String):void {			
			_thumb = new SimpleImageContained();
			_thumb.container.scaleState = ContainerScaleStates.AUTO;
			_thumb.width = 20;
			_thumb.height = 20;
			_thumb.path = value;	
			
			//TP
			if(_label.text != ControlsConstants.UNDEFINED){
				adjustThumb();
			}
			
			addChild(_thumb);
		}
		
		override public function get label():String {
			return super.label;
		}
		
		override public function set label(value:String):void {
			super.label = value;
			if(_thumb != null){
				adjustThumb();
			}
		}
 
		public function get id():uint {
			return _id;
		}
		
		public function set id(value:uint):void {
			_id = value;
		}
		
		private function adjustThumb():void {
			_thumb.x = ((this.width - _thumb.width) / 2);
			//trace((_label.y - _thumb.height)/2);
			_thumb.y += ((_label.y - _thumb.height)) + ControlsConstants.TEXT_MARGIN;
			/*_label.y = _thumb.y + _thumb.height + ControlsConstants.TEXT_MARGIN;
			super.height = _thumb.height + _label.height + (ControlsConstants.TEXT_MARGIN * 2);*/
			_label.y = height - _label.height;
		}
		
		override public function get selected():Boolean {
			return super.selected;
		}
		
		override public function set selected(value:Boolean):void {
			super.selected = value;
			mouseEnabled = !value;
		}
		
		override public function destroy():void {
			super.destroy();
			if(_thumb != null){
				removeChild(_thumb);
				_thumb.destroy();
				_thumb = null;
			}		
			_id = NaN;
			
		}
		

	}

}