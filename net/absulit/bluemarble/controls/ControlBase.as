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
	import net.absulit.arbolnegro.interfaces.Destroy;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class ControlBase extends Sprite implements Destroy {

		
		private var _width:uint;
		private var _height:uint;
		public function ControlBase(width:uint, height:uint) {
			super();
			_width = width;
			_height = height;		
			init();			
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		

		
		/**
		 * If pivot is null creates a new one
		 */
		protected function init():void {
			drawGraphics();
		}
		
		protected function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);	
			//drawGraphics();
		}
		/**
		 * Creates gradient background and line border according with the pivot
		 */
		protected function drawGraphics():void {
			/*var mat:Matrix = new Matrix();
			mat.createGradientBox(_width, _height, MathUtil.radians(90));*/
			graphics.clear();
			//graphics.lineStyle(1, 0x0000ff,.5,true);
			graphics.lineStyle(1, ControlsConstants.CONTROL_BASE_COLOR,.5,true);
			//graphics.beginGradientFill(GradientType.LINEAR, [0x0000ff, 0x000000], [.1, 0], [0, 255], mat);
			graphics.beginFill(ControlsConstants.CONTROL_BASE_COLOR,.1);
			graphics.drawRect(1, 1, (_width-1), (_height-1));
			graphics.endFill();
		}
		
		override public function get width():Number {
			//return super.width;
			return _width;
		}
		
		/**
		 * Does not provide a escale, resizes limits
		 */
		override public function set width(value:Number):void {
			//super.width = value;
			_width = value;
			drawGraphics();
		}
		
		override public function get height():Number {
			//return super.height;
			return _height;
		}
		
		/**
		 * Does not provide a escale, resizes limits
		 */
		override public function set height(value:Number):void {
			//super.height = value;
			_height = value;
			drawGraphics();
		}
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			_width = NaN;
			_height = NaN;
		}
		
	}

}