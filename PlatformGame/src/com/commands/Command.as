package com.commands 
{
	/**
	 * Command associate a key event with a listener.
	 * @author mamutdelaunay
	 */
	public class Command 
	{
		/**
		 * Constructor
		 * @param	commandManager
		 * @param	key
		 * @param	eventType
		 * @param	listener
		 */
		public function Command(commandManager:CommandManager, key:uint, eventType:String, listener:Function) 
		{
			_key = key;
			_eventType = eventType;
			_commandManager = commandManager;
			
			_listener = commandManager.addKeyListener(key, eventType, listener);
		}
		
		/**
		 * Remove the command event listener
		 */
		public function remove():void {
			_commandManager.removeEventListener(_eventType, _listener);
		}
		
		// Private members
		private var _key:uint;
		private var _eventType:String;
		private var _listener:Function;
		private var _commandManager:CommandManager;
	}

}