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
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import net.absulit.arbolnegro.interfaces.Destroy;
	import net.absulit.bluemarble.events.WindowEvent;
	//import flash.system.System;
	
	[Event(name="beforeExit",type="net.absulit.bluemarble.events.WindowEvent")]
	[Event(name="fadeInFinished",type="net.absulit.bluemarble.events.WindowEvent")]
	[Event(name="fadeOutFinished",type="net.absulit.bluemarble.events.WindowEvent")]
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Window extends ControlBase implements Destroy{
		private var _tweenRY:Tween;
		private var _tweenX:Tween;
		private var _tweenA:Tween;
		private var _title:String;
		protected var _frameRate:uint;
		protected var _data:Object;
		protected var _actionBar:ActionBar;
		protected var _cache:Boolean;
		public function Window(width:int = 400, height:int = 400, data:Object = null) {
			super(width, height);	
			_data = data;
		}
		
		override protected function init():void {
			super.init();
			_frameRate = 30;
			_cache = false;
			//items inside must be reachable for interaction
			_title = "undefined";
			this.mouseChildren = true;
			_actionBar = new ActionBar();
		}
		
		
		override protected function addedToStage(e:Event=null):void {
			super.addedToStage(e);
			stage.addEventListener(Event.RESIZE, onResizeStage);
		}
		
		protected function onResizeStage(e:Event):void {
			
		}

		/**
		 * Fade in from 0 alpha to 1
		 * @return
		 */
		public function fadeIn():Tween {
			/*if(_cache){
				backFromCache();
			}*/
			_tweenA = new Tween(this, "alpha", Strong.easeOut, 0, 1, 1, true);
			_tweenA.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishFadeIn);
			return _tweenA;
		}
		
		private function onMotionFinishFadeIn(e:TweenEvent):void {
			_tweenA.removeEventListener(TweenEvent.MOTION_FINISH, onMotionFinishFadeIn);
			dispatchEvent(new WindowEvent(WindowEvent.FADE_IN_FINISHED));
		}
		
		public function fadeOut():Tween {
			dispatchEvent(new WindowEvent(WindowEvent.BEFORE_EXIT));
			_tweenA = new Tween(this, "alpha", Strong.easeOut, 1, 0, 1, true);
			_tweenA.addEventListener(TweenEvent.MOTION_FINISH,  onMotionFinishFadeOut);
			return _tweenA;
		}
		
		private function onMotionFinishFadeOut(e:TweenEvent):void {
			_tweenA.removeEventListener(TweenEvent.MOTION_FINISH, onMotionFinishFadeOut);
			dispatchEvent(new WindowEvent(WindowEvent.FADE_OUT_FINISHED));
		}
		
		public function rotate(offsetX:int):Tween {
			if (offsetX == 1) {;
				_tweenRY = new Tween(this, "rotationY", Strong.easeOut, this.rotationY, this.rotationY - 90, 1, true);
			}else if(offsetX == -1) {
				_tweenRY = new Tween(this, "rotationY", Strong.easeOut, this.rotationY, this.rotationY + 90, 1, true);
			}
			return _tweenRY;
		}
		
		public function rotateFrom(offsetX:int):Tween {
			if (offsetX == 1) {;
				_tweenRY = new Tween(this, "rotationY", Strong.easeOut, this.rotationY + 90, this.rotationY, 1, true);
			}else if(offsetX == -1) {				
				_tweenRY = new Tween(this, "rotationY", Strong.easeOut, this.rotationY - 90, this.rotationY, 1, true);
			}
			return _tweenRY;
		}
		
		public function swipe(offsetX:int):Tween {
			if (offsetX == 1) {
				_tweenX = new Tween(this, "x", Strong.easeOut, this.x , this.x + (stage.stageWidth / 2) + (this.width/2), 1, true);
			}else if(offsetX == -1) {
				_tweenX = new Tween(this, "x", Strong.easeOut, this.x , this.x - (stage.stageWidth / 2) - (this.width/2), 1, true);
			}
			return _tweenX;
		}
		
		public function swipeFrom(offsetX:int):Tween {
			if (offsetX == 1) {				
				_tweenX = new Tween(this, "x", Strong.easeOut, this.x - (stage.stageWidth / 2) - (this.width/2), this.x , 1, true);
			}else if(offsetX == -1) {
				_tweenX = new Tween(this, "x", Strong.easeOut, this.x + (stage.stageWidth / 2) + (this.width / 2), this.x , 1, true);
			}
			return _tweenX;
		}
		


		public function get title():String {
			return _title;
		}
		
		public function set title(value:String):void {
			_title = value;
		}
		

		/**
		 * Provides a way to modify the global framerate when this window is visible
		 */
		public function get frameRate():uint {
			return _frameRate;
		}
		
		public function set frameRate(value:uint):void {
			_frameRate = value;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get actionBar():ActionBar {
			return _actionBar;
		}
		
		public function get cache():Boolean {
			return _cache;
		}
		
		public function set cache(value:Boolean):void {
			_cache = value;
		}
		
		public function backFromCache():void {
			
		}
		
		override public function destroy():void {
			super.destroy();
			_frameRate = NaN;
			_title = null;
			_tweenX = _tweenA = _tweenRY = null;
			data = null;
			_actionBar = null;
			for each (var child:DisplayObject in this) {
				removeChild(child);
				Destroy(child).destroy();
				child = null;
			}
			stage.removeEventListener(Event.RESIZE, onResizeStage);
		}
		
		
	}

}