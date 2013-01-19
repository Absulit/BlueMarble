package net.absulit.bluemarble.windows {
	import flash.events.Event;
	import net.absulit.arbolnegro.interfaces.ContainerScaleStates;
	import net.absulit.arbolnegro.interfaces.image.SimpleImageContained;
	import net.absulit.bluemarble.controls.Window;
	
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class ImageWindow extends Window {
		protected var _image:SimpleImageContained;
		public function ImageWindow(width:int=400, height:int=400, data:Object=null) {
			super(width, height, data);
			
		}
		
		override protected function init():void {
			super.init();
			_image = new SimpleImageContained();
			_image.addEventListener(Event.COMPLETE, onCompleteImage);
			_image.x = 2;
			_image.y = 2;
		}
		
		private function onCompleteImage(e:Event):void {
			_image.container.scaleState = ContainerScaleStates.AUTO;
			_image.width = width - 4;
			_image.height = height - 4;
		}
		
		override protected function addedToStage(e:Event = null):void {
			super.addedToStage(e);
			addChild(_image);
		}
		
		override protected function onResizeStage(e:Event):void {
			super.onResizeStage(e);
			_image.width = width - 4;
			_image.height = height - 4;
		}
		
		override public function destroy():void {
			super.destroy();
			removeChild(_image);
			_image.destroy();
			_image = null;
		}
		
	}

}