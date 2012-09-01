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
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import net.absulit.arbolnegro.data.CircularList;
	/**
	 * ...
	 * @author Sebastian Sanabria Diaz
	 */
	public class WindowManager extends Sprite {
		private static var _instance:WindowManager;
		private var _circulaList:CircularList;
		private var _tweenRY:Tween;
		private var _tweenX:Tween;
		private var _currentWindow:Window;
		private var _previousWindow:Window;
		private var _actionBar:ActionBar;
		private var _tabBar:TabBar;
		private var _history:Vector.<HistoryItem>;
		private var _windowWidth:uint;
		private var _windowHeight:uint;
		private var _windowY:uint;
		private var _backPressed:Boolean;
		private var _portrait:Boolean;
		private var _stageWidth:uint;
		private var _stageHeight:uint;
		private var _vars:Object;
		public function WindowManager(pvt:SingletonEnforcer) {
			super();
			init();
			if (stage != null){
				addedToStage();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function init():void {
			_vars = new Object();
			_tabBar = new TabBar();		
			//_tabBar.cacheAsBitmap = true;
			//_tabBar.cacheAsBitmapMatrix = new Matrix();//send to hardware
			_circulaList = new CircularList();
			_actionBar = new ActionBar();
			_currentWindow = null;
			_previousWindow = null;
			
			_history = new Vector.<HistoryItem>();
			_backPressed = false;
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);
			//NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			
		}
		
		private function onKeyboardEvent(e:KeyboardEvent):void {
			switch (e.keyCode){
				case Keyboard.BACK:
					e.preventDefault();
					back();
					trace("Back key is pressed.");
				break;
				case Keyboard.MENU:
				trace("Menu key is pressed.");
				break;
				case Keyboard.SEARCH:
				trace("Search key is pressed.");
				break;
			 }
		}
		
		public function back():void {
			
			var historyItem:HistoryItem = _history.pop()
			if (historyItem != null) {
				_backPressed = true;
				var value:int = historyItem.index;	
				var offsetX:int = getOffsetX(value);
				_circulaList.itemIndex = value;
				_tabBar.getChildAt(_circulaList.itemIndex).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				transition(offsetX, historyItem.data, historyItem.reference);
			}else {
				_backPressed = false;
			}
		}
		
		public function backToFirst(disableCurrentTabBarItem:Boolean = false):void {
			if (_history.length > 0) {
				_backPressed = true;
				_history = new Vector.<HistoryItem>();
				_circulaList.itemIndex = 0;
				var offsetX:int = getOffsetX(0);
				TabBarItem(_tabBar.getChildAt(0)).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				if (disableCurrentTabBarItem) {
					_tabBar.previousSelectedItem.mouseEnabled = false;
				}
				
				transition(offsetX);
			}
		}

		
		private function addedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.color = 0x00393F;
			if (stage.stageHeight > stage.stageWidth) {
				_stageWidth = stage.stageWidth;
				_stageHeight = stage.stageHeight;
			}
			
			/*_windowWidth = stage.stageWidth;
			_windowHeight = stage.stageHeight - _actionBar.height - _tabBar.height;
			_windowY = _actionBar.height;*/
			windowDimensions();
			
			_tabBar.y = _windowHeight;
			_tabBar.width = _windowWidth;
			_actionBar.width = stage.stageWidth;		

			addChild(_actionBar);
			addChild(_tabBar);
			stage.addEventListener(Event.RESIZE, onResizeStage);
		}
		
		private function onResizeStage(e:Event = null):void {
			trace("onResizeStage WindowManager");
			windowDimensions();		
			_tabBar.y = stage.stageHeight - _tabBar.height
			_tabBar.width = _windowWidth;
			_actionBar.width = stage.stageWidth;
			
			/*_currentWindow.width = _windowWidth;
			_currentWindow.height = _windowHeight;
			_currentWindow.y = _windowY;*/
			
			sort();
		}
		
		public function update():void {
			trace("update");
			onResizeStage();
		}
		
		/**
		 * calculates window position and dimensions based on actionbar and tabbar visibility
		 */
		private function windowDimensions():void {
			var tabBarHeight:int = _tabBar.height;
			var actionBarHeight:int = _actionBar.height;
			if (!_tabBar.visible) {
				tabBarHeight = 0;
			}
			if (!_actionBar.visible) {
				actionBarHeight = 0;
			}
			_windowWidth = stage.stageWidth;
			_windowHeight = stage.stageHeight - actionBarHeight - tabBarHeight;
			_windowY = actionBarHeight;
		}
		
		public static function get instance():WindowManager {
			if ( _instance == null ) {
				_instance = new WindowManager( new SingletonEnforcer() );
			}
			return _instance;
		}
		
		public function get index():int {
			return _circulaList.itemIndex;
		}
		
		public function set index(value:int):void {
			var offsetX:int = getOffsetX(value);
			_circulaList.itemIndex = value;
			transition(offsetX);
		}
		
		public function get actionBarVisible():Boolean {
			return _actionBar.visible;
		}
		
		public function set actionBarVisible(value:Boolean):void {
			_actionBar.visible = value;
			/*var tabBarHeight:int = _tabBar.height;
			var actionBarHeight:int = _actionBar.height;			
			if(!_tabBar.visible){
				tabBarHeight = 0;
			}
			if (!_actionBar.visible) {
				actionBarHeight = 0;
			}
			_windowWidth = stage.stageWidth;
			_windowHeight = stage.stageHeight - actionBarHeight - tabBarHeight;
			_windowY = actionBarHeight;*/
			windowDimensions();
			_currentWindow.width = _windowWidth;
			_currentWindow.height = _windowHeight;
			_currentWindow.y = _windowY;
		}
		
		public function get tabBarVisible():Boolean {
			return _tabBar.visible;
		}
		
		public function set tabBarVisible(value:Boolean):void {
			trace("If Stage is null cant call tabBarVisible");
			if (stage == null) {
				throw new Error("Stage is null cant call tabBarVisible")
			}
			_tabBar.visible = value;
			/*var tabBarHeight:int = _tabBar.height;
			var actionBarHeight:int = _actionBar.height;			
			if(!_tabBar.visible){
				tabBarHeight = 0;
			}
			if (!_actionBar.visible) {
				actionBarHeight = 0;
			}
			_windowWidth = stage.stageWidth;
			_windowHeight = stage.stageHeight - actionBarHeight - tabBarHeight;
			_windowY = actionBarHeight;*/
			windowDimensions();
			_currentWindow.width = _windowWidth;
			_currentWindow.height = _windowHeight;
			_currentWindow.y = _windowY;
		}
		
		public function get tabBar():TabBar {
			return _tabBar;
		}
		
		public function get currentWindow():Window {
			return _currentWindow;
		}
		
		public function get vars():Object {
			return _vars;
		}
		
		public function set vars(value:Object):void {
			_vars = value;
		}
		
		public function setIndex(index:int, data:Object):void {
			var value:int = index;	
			var offsetX:int = getOffsetX(value);
			_circulaList.itemIndex = value;
			transition(offsetX, data);
		}
		
		public function setWindow(WindowClass:Class, data:Object = null):void {
			if (WindowClass == null) throw new ArgumentError("WindowClass must not be null");
			var value:int = _circulaList.indexOfItem(WindowClass);	
			if (value == -1) {
				throw new ArgumentError("WindowClass has not been added to WindowManager with push");
			}
			var offsetX:int = getOffsetX(value);
			_circulaList.itemIndex = value;
			transition(offsetX, data);
		}
		
		private function getOffsetX(index:int):int {
			return _circulaList.itemIndex < index? -1:1;
		}
		
		private function transition(offsetX:int, data:Object = null, reference:Window = null):void {
			stage.frameRate = 60;
			_tabBar.mouseEnabled = false;
			_tabBar.mouseChildren = false;
			_actionBar.mouseEnabled = false;
			_actionBar.mouseChildren = false;
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);			
			_currentWindow.swipe(offsetX);
			//_currentWindow.rotate(offsetX);
			_currentWindow.fadeOut().addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishCurrentWindow);
			_currentWindow.mouseEnabled = false;		
			//push on history
			if (!_backPressed) {
				var referenceCache:Window = null;
				if (_currentWindow.cache) {
					referenceCache = _currentWindow;
					trace("almacenado en CACHE",_currentWindow[ControlsConstants.CONSTRUCTOR]);
				}
				_history.push(new HistoryItem(_circulaList.indexOfItem(_currentWindow[ControlsConstants.CONSTRUCTOR]), _currentWindow.data, referenceCache));
			}			
			_backPressed = false;
			//			
			_previousWindow = _currentWindow;
			
			if (reference == null) {
				var WindowClass:Class = _circulaList.item;
				_currentWindow = new WindowClass(_windowWidth, _windowHeight, data) as Window;				
			}else {
				_currentWindow = reference;
				//_currentWindow.backFromCache();
				_currentWindow.alpha = 1;
				_currentWindow.x = 0;
				_currentWindow.y = 0;
			}

			
			/*****/			
			windowDimensions();
			
			
			_currentWindow.y = _windowY;
			_currentWindow.width = _windowWidth;
			_currentWindow.height = _windowHeight;
			
			
			//_actionBar = _currentWindow.actionBar;
			replaceActionBar(_currentWindow.actionBar);		
			
			addChild(_currentWindow);
			addChild(_tabBar);
			//_currentWindow.center();
			_currentWindow.visible = true;
			_currentWindow.mouseEnabled = true;
			
			
			_currentWindow.swipeFrom(offsetX);
			//_currentWindow.rotateFrom(offsetX);
			_currentWindow.fadeIn();
			if(_currentWindow.cache){
				_currentWindow.backFromCache();
			}
		}
		
		private function replaceActionBar(value:ActionBar):void {
			_actionBar.title = value.title;
			_actionBar.navigation = value.navigation;
			_actionBar.action = value.action;
		}
		

		
		/*static function getSuperClass(o: Object): Object {
		var n: String = getQualifiedSuperclassName(o);
		if(n == null)return(null);
		return(getDefinitionByName(n));
		}*/
		
		public function push(WindowClass:Class, title:String, visible:Boolean = true, iconPath:String = ""):void { 
			if (WindowClass == null) throw new ArgumentError("WindowClass must not be null");
			//getDefinitionByName(getQualifiedClassName(obj))
			var window:Window
			if (_circulaList.length == 0) {
				window = new WindowClass(_windowWidth, _windowHeight) as Window;
				window.y = _windowY;
				_currentWindow = window;
				_currentWindow.title = title;
				
				
			/*windowDimensions();
			
			
			_currentWindow.y = _windowY;
			_currentWindow.width = _windowWidth;
			_currentWindow.height = _windowHeight;*/
				
				
				//_actionBar = _currentWindow.actionBar;
				replaceActionBar(_currentWindow.actionBar);
				addChild(window);
				stage.frameRate = _currentWindow.frameRate;
			}
			var tabBarItem:TabBarItem = new TabBarItem();
			tabBarItem.addEventListener(MouseEvent.CLICK, onClickTabBarItem);
			tabBarItem.id = _circulaList.length;
			tabBarItem.label = title;
			tabBarItem.visible = visible
			//tabBarItem.thumbPath = "back.png";

			_tabBar.addChild(tabBarItem);
			//_tabBar.width = stage.stageWidth;
			
			
			
			addChild(_tabBar);
			_circulaList.push(WindowClass);
		}
		
		public function sort():void {
			windowDimensions();
			if(_currentWindow != null){
				_currentWindow.width = _windowWidth;
				_currentWindow.height = _windowHeight;
				_currentWindow.y = _windowY;
			}
			if(_tabBar.numChildren != 0){
				_tabBar.sort();
				_tabBar.y = stage.stageHeight - _tabBar.height
			}
			
		}
		
		private function onClickTabBarItem(e:MouseEvent):void {
			var tabBarItem:TabBarItem = e.currentTarget as TabBarItem;
			var offsetX:int = getOffsetX(tabBarItem.id);
			
			if (_circulaList.itemIndex != tabBarItem.id) {
				_circulaList.itemIndex = tabBarItem.id;
				transition(offsetX);
			}

		}
		

		/**
		 * Preserva que solo haya un Window en memoria
		 * @param	e
		 */
		private function onMotionFinishCurrentWindow(e:TweenEvent):void {
			/*var index:uint = this.numChildren - 1;
			//getDefinitionByName(getQualifiedClassName(obj))
			var windowRemoved:Destroy;
			while (--index > 2) {//it is 1 because the tabBar is on top all the time
					windowRemoved = Destroy(removeChildAt(0));
					windowRemoved.destroy();
					trace("destroy");
			}*/
			if(!_previousWindow.cache){
				_previousWindow.destroy();
			}
			
			stage.frameRate = _currentWindow.frameRate;
			_tabBar.mouseEnabled = true;
			_tabBar.mouseChildren = true;
			_actionBar.mouseEnabled = true;
			_actionBar.mouseChildren = true;
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);
			
		}
	}

}

internal class SingletonEnforcer{}