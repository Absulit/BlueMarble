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
	import net.absulit.arbolnegro.data.DPIManager;
	import net.absulit.arbolnegro.interfaces.image.SimpleImageContained;
	import net.absulit.bluemarble.interfaces.InteractiveItem;

	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class InteractiveListItem extends Button implements InteractiveItem{
		private var _thumb:SimpleImageContained;
		private const SIDE:uint = DPIManager.instance.recalibratePxls(50);
		private var _centerThumb:Boolean;
		private var _id:uint;
		private var _data:Object;
		//private var _controlBackground:ControlBackground;
		public function InteractiveListItem(label:String, data:Object = null) {
			super(/*400,SIDE*/);
			_label.text = label;
			_data = data;
		}
		

		
		override protected function init():void {
			super.init();
			width = 400;
			height = SIDE;
			_thumb = new SimpleImageContained();
			_thumb.height = SIDE - 2;
			_thumb.width = SIDE - 2;
			_thumb.addEventListener(Event.COMPLETE, onCompleteThumb);
			//_label = new Text();

			super.width = _thumb.width + _label.width;
			//super.width = this.parent.width;
			super.height = SIDE;
			_centerThumb = true;
		}
		
		override protected function addedToStage(e:Event = null):void {
			super.addedToStage(e);
			addChild(_label);
			addChildAt(_thumb,0);
		}
		
		private function onCompleteThumb(e:Event):void {
			//_thumb.x = _thumb.width - _thumb.mask.width;
			_thumb.y = (SIDE - _thumb.height) / 2;
			
			_label.x = _thumb.width + 2;
			if(_centerThumb){
				_label.y = (_thumb.height - _label.height) / 2;
			}
		}
		
		public function get thumbPath():String {
			return _thumb.path;
		}
		
		public function set thumbPath(value:String):void {
			_thumb.path = value;
		}
		
		public function get centerThumb():Boolean {
			return _centerThumb;
		}
		
		public function set centerThumb(value:Boolean):void {
			_centerThumb = value;
			if(_centerThumb){
				_label.y = (_thumb.height - _label.height) / 2;
			}else {
				_label.y = 0;
			}
		}
		
		
		public function get id():uint {
			return _id;
		}
		
		public function set id(value:uint):void {
			_id = value;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		override public function destroy():void {
			super.destroy();
			_centerThumb = false;
			_id = NaN;
			_data = null;
		}
	}

}