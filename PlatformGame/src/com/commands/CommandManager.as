package com.commands
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * COmmandManager
	 * @author mamutdelaunay
	 */
	public class CommandManager extends EventDispatcher
	{
		// Static 
        public static const KEY_P:uint = 80; 
        
		/**
		 * Constructor
		 * @param	stage
		 */
		public function CommandManager(stage:Stage)
		{
			_keys = new Vector.<uint>();
			_keysDown = new Vector.<uint>();
			
			// Add the keys to check
			addKey(Keyboard.UP);
			addKey(Keyboard.LEFT);
			addKey(Keyboard.RIGHT);
			addKey(Keyboard.SPACE);
			addKey(Keyboard.CONTROL);
			addKey(Keyboard.ESCAPE);
			addKey(KEY_P);
			
			// Set the KeyboardEvent listeners
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		
		// Public methods
		
		/**
		 * Add a new key to check
		 * @param	key
		 */
		public function addKey(key:uint):void
		{
			_keys.push(key);
		}
		
		/**
		 * Add a listener for a the key event
		 * @param	key
		 * @param	eventType
		 * @param	keyListener
		 * @return the listener
		 */
		public function addKeyListener(key:uint, eventType:String, keyListener:Function):Function {
			var listener:Function = function(event:CommandEvent):void {
				if (key == event.keyCode) {
					keyListener(event);
				}
			}
			addEventListener(eventType, listener, false, 0, true);
			return listener;
		}
		
		/**
		 * @param	key
		 * @return true if a key is down
		 */
		public function isKeyDown(key:uint):Boolean {
			return -1 != _keysDown.indexOf(key)
		}
		
		// Private methods
		
		/**
		 * KeyboardEvent.KEY_UP event listener.
		 * Dispatch a CommandEvent.KEY_RELEASED with the keyCode.
		 * Remove the keyCode from _keysDown
		 * @param	event
		 */
		private function onKeyUp(event:KeyboardEvent):void
		{
			if (-1 != _keys.indexOf(event.keyCode) && isKeyDown(event.keyCode))
			{
				dispatchEvent(new CommandEvent(CommandEvent.KEY_RELEASED, event.keyCode));
				_keysDown.splice(_keysDown.indexOf(event.keyCode), 1);
			}
		}
		
		/**
		 * KeyboardEvent.KEY_DOWN event listener.
		 * Dispatch a CommandEvent.KEY_PRESSED with the keyCode.
		 * Add the keyCode to _keysDown
		 * @param	event
		 */
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (-1 != _keys.indexOf(event.keyCode) && !isKeyDown(event.keyCode))
			{
				dispatchEvent(new CommandEvent(CommandEvent.KEY_PRESSED, event.keyCode));
				_keysDown.push(event.keyCode);
			}
		}
		
		// Private members
		private var _keys:Vector.<uint>;
		private var _keysDown:Vector.<uint>;
	
	}
}