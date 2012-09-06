package net.absulit.bluemarble.controls {
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import flash.filters.DropShadowFilter;
	import net.absulit.bluemarble.interfaces.InteractiveItem;
	import flash.events.Event;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	import net.absulit.arbolnegro.interfaces.image.SimpleImageContained;
	import net.absulit.bluemarble.controls.ControlBase;
	import net.absulit.bluemarble.interfaces.InteractiveItem;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class ExpandableItem extends ControlBase implements InteractiveItem {
		private const SIDE:uint = 50;
		private var _image:SimpleImageContained;
		private var _label:Text;
		private var _data:Object;
		private var _tweenA:Tween;
		public function ExpandableItem() {
			super(SIDE, SIDE);			
		}
		
		/* INTERFACE net.absulit.bluemarble.interfaces.InteractiveItem */
		
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		override protected function init():void {
			super.init();
			_image = new SimpleImageContained();
			_image.addEventListener(Event.COMPLETE, onCompleteImage);
			_label = new Text();
			_label.y = ControlsConstants.TEXT_MARGIN;
			
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 0;
			shadow.color = 0x000000;
			shadow.blurX = 2;
			shadow.blurY = 2;
			shadow.quality = 3;
			
			_label.filters = [shadow];
			_label.addEventListener(Event.CHANGE, onChangeText);
			_label.selectable = false;
			_label.wordWrap = true;
			_label.multiline = true;
		}
		
		private function onChangeText(e:Event):void {
			_label.width = width;
		}
		
		private function onCompleteImage(e:Event):void {
			_image.container.scaleState = ContainerScaleStates.AUTO;
			_image.x = 2;
			_image.y = 2;
			_image.width = width - 2;
			_image.height = height - 2;
			//height = _label.textHeight;
			_tweenA = new Tween(_image, "alpha", Strong.easeOut, 0, 1, 1, true);
		}
		
		override protected function addedToStage(e:Event = null):void {
			super.addedToStage(e);
			addChild(_image);
			addChild(_label);
		}
		
		override public function get width():Number {
			return super.width;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			if (_image)  {
				_image.width = width - 2;
			}
			_label.x = ControlsConstants.TEXT_MARGIN;
			_label.width = width - (ControlsConstants.TEXT_MARGIN * 2);
			_label.height = _label.textHeight + 5;
			var side:Number = _label.height + ControlsConstants.TEXT_MARGIN;
			if (side > SIDE) {
				height = side;
			}
			
		}
		
		override public function get height():Number {
			return super.height;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			if (_image)  {
				_image.height = value;
			}

		}
		
		public function get image():SimpleImageContained {
			return _image;
		}
		
		public function get label():Text {
			return _label;
		}
	}

}