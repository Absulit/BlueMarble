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
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import net.absulit.arbolnegro.util.MathUtil;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class Button extends ControlBase {
		protected var _label:Text;
		protected var _previousLabel:String;
		private var _selection:Sprite;
		private var _notEnabled:Sprite;
		private var _tweenASelection:Tween;
		private var _toggle:Boolean;
		//private var _selected:Boolean;
		public function Button() {
			super(100, 50);
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_label = new Text();
			_label.text = ControlsConstants.UNDEFINED;
			_label.selectable = false;
			_previousLabel = _label.text;
			
			_selection = new Sprite();
			//_selection.graphics.beginFill(0xffff00, 1);
			var mat:Matrix = new Matrix();
			mat.createGradientBox(10, 10, MathUtil.radians(90));
			_selection.graphics.beginGradientFill(GradientType.LINEAR, [ControlsConstants.CONTROL_BASE_COLOR, ControlsConstants.CONTROL_BASE_COLOR], [1, .1], [0, 255 * .2], mat);
			_selection.graphics.drawRect(0, 0, 10, 10);
			_selection.graphics.endFill();
			_selection.visible = false;
			
			_notEnabled = new Sprite();
			_notEnabled.graphics.beginFill(ControlsConstants.CONTROL_NOT_ENABLED,.5);
			_notEnabled.graphics.drawRect(0, 0, 10, 10);
			_notEnabled.graphics.endFill();
			_notEnabled.visible = false;
			_notEnabled.blendMode = BlendMode.OVERLAY;
			
			mouseChildren = false;
			buttonMode = true;
		}

		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);			
			addChild(_selection);
			addChild(_notEnabled);
			//_previousLabel = _label.text;
			centerLabel()	
			addChild(_label);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
		}
		
		private function onMouseDown(e:MouseEvent):void {
			if (_toggle) {
				_selection.visible = !_selection.visible;
				//_selected = _selection.visible;
			}else {
				_selection.visible = true;
				//_selected = _selection.visible;
			}
			if (!_selection.visible) {
				_tweenASelection = new Tween(_selection, "alpha", Strong.easeIn, 1, 0, .5, true);
				_tweenASelection.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinish);
			}
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
		}
		
		
		private function onMouseUp(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			_selection.visible = false;
		}
		
		
		private function onMotionFinish(e:TweenEvent):void {
			_tweenASelection.removeEventListener(TweenEvent.MOTION_FINISH, onMotionFinish);
			_selection.visible = false;
			_tweenASelection = null;
		}
	
		public function get label():String {
			return _label.text;
		}
		
		public function set label(value:String):void {
			_label.text = value;
			_previousLabel = _label.text;			
			centerLabel();

		}
		
		private function centerLabel():void {
			super.width = _label.width + (ControlsConstants.TEXT_MARGIN * 2);
			_label.x = (super.width - _label.width) / 2;			
			_label.y = (super.height - _label.height) / 2;	
			//
			_selection.width = super.width;
			_selection.height = super.height;
			_notEnabled.width = super.width;
			_notEnabled.height = super.height;
		}
		
		public function get toggle():Boolean {
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void {
			_toggle = value;
		}
		
		public function get selected():Boolean {
			return _selection.visible;
		}
		
		public function set selected(value:Boolean):void {
			//var previousValue:Boolean = _selected;

			_selection.visible = value;
			/*if (!_selection.visible) {
				_selection.visible = true;
				_tweenASelection = new Tween(_selection, "alpha", Strong.easeIn, 1, 0, .5, true);
				_tweenASelection.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinish);
			}*/
		}
		
		override public function get width():Number {
			return super.width;
		}
		
		override public function get height():Number {
			return super.height;
		}
		
		override public function set height(value:Number):void {
			_selection.height = value;
			_notEnabled.height = value;
			super.height = value;
		}
		
		override public function set width(value:Number):void {
			_selection.width = value;
			_notEnabled.width = value;
			super.width = value;
		}
		
		override public function get mouseEnabled():Boolean {
			return super.mouseEnabled;
		}
		
		override public function set mouseEnabled(value:Boolean):void {
			_notEnabled.visible = !value;
			super.mouseEnabled = value;
		}

		override public function destroy():void {
			super.destroy();	
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);	
			
			_label = null;	
			removeChild(_label);
			_previousLabel = null;			
			_tweenASelection = null;
			_toggle = false;			
			
					
			
			
			removeChild(_selection);
			_selection = null;			
			removeChild(_notEnabled);
			_notEnabled = null;
		}
		
	}

}