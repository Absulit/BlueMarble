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

package {
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import net.absulit.bluemarble.controls.WindowManager;
	
	/**
	 * Blue Marble Demo 1 - junio, 2012 
	 * @author Sebastian Sanabria Diaz
	 */
	public class Main extends Sprite {
		private var _windowManager:WindowManager;
		public function Main():void {			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			// entry point
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			//inicializar variables
			//k = 0;
			//my_boolean = false;
			//button = new Button();
		}
		

		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			/**
			 * importante mantener esto en NO_SCALE y TOP_LEFT
			 * pero pueden modificarlos para ver las consecuencias
			 */
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			_windowManager = WindowManager.instance;
			addChild(_windowManager);
			
			/**
			 * Agregamos ventanas
			 */
			_windowManager.push(MainWindow, "Home");
			//_windowManager.push(FakeWindow1, "FW1");
			//_windowManager.push(FakeWindow2, "FW2");
			/**
			 * Terminamos de agregar ventanas
			 */
			
			_windowManager.sort();
		}
		
		private function deactivate(e:Event):void {
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}