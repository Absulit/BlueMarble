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
	import net.absulit.arbolnegro.interfaces.Destroy;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class HistoryItem implements Destroy{
		private var _index:int;
		private var _data:Object;
		public function HistoryItem(index:int,data:Object = null) {
			_index = index;
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			_index = value;
		}
		
		
		/* INTERFACE net.absulit.arbolnegro.interfaces.Destroy */
		
		public function destroy():void {
			_index = NaN;
			_data = null;
		}
		
	}

}