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

package net.absulit.bluemarble.controls
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.absulit.arbolnegro.data.DPIManager;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Text extends TextField{
		//private static const COLOR:uint = 0xFF8000;
		//private static const COLOR:uint = 0x0000ff;
		private static const COLOR:uint = 0xffffff;
		private static const SIZE:uint = 8;
		//private static const SIZE:uint = 50;
		//private static const FONT:String = "Courier New";
		private static const FONT:String = "Arial";
		public function Text() {
			super();
			init();
		}

		private function init():void {
			trace("Text size: ",DPIManager.instance.recalibratePxls(SIZE));
			trace("Text 1cm: ",DPIManager.instance.cmToPxls(1));
			this.defaultTextFormat = new TextFormat(FONT, DPIManager.instance.recalibratePxls(SIZE), COLOR);
			//border = true;
			//borderColor = 0xffffff;
		}
		
		override public function get text():String {
			return super.text;
		}
		
		override public function set text(value:String):void {
			super.text = value;
			//this.width = DPIManager.instance.recalibratePxls( this.textWidth + 4);
			this.width = this.textWidth + 4;
			//this.height = DPIManager.instance.recalibratePxls( this.textHeight + 5);
			this.height = this.textHeight + 5;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}