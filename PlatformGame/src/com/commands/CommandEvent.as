package com.commands
{
	import flash.events.Event;
	
	/**
	 * CommandEvent
	 * @author mamutdelaunay
	 */
	public class CommandEvent extends Event
	{
		// Static
		public static const KEY_PRESSED:String = "keyPressed";
		public static const KEY_RELEASED:String = "keyReleased";
		
		// Public properties
		public var keyCode:uint;
		
		/**
		 * Constructor
		 * @param	type
		 * @param	keyCode
		 */
		public function CommandEvent(type:String, keyCode:uint)
		{
			this.keyCode = keyCode;
			super(type);
		}
	}
}