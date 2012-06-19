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

package  {
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.absulit.bluemarble.controls.Button;
	import net.absulit.bluemarble.controls.Window;
	import net.absulit.bluemarble.controls.WindowManager;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class MainWindow extends Window {
		
		public function MainWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_actionBar.title = "Blue Marble Demo 1";
			
			_actionBar.navigation = new Button();
			_actionBar.navigation.label = "Exit";
			_actionBar.navigation.addEventListener(MouseEvent.CLICK, onClickActionBarNavigation);
			
			_actionBar.action = new Button();
			_actionBar.action.label = "Test";
		}
		
		private function onClickActionBarNavigation(e:MouseEvent):void {
			NativeApplication.nativeApplication.exit();
		}
		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			//Proceda aqui a programar su ventana
		}
		
	}

}