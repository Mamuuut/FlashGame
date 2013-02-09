package com.helpers 
{
	import flash.external.ExternalInterface;
	/**
	 * AnalyticsHelper
	 * @author mamutdelaunay
	 */
	public class AnalyticsHelper 
	{
		// Public static const
		public static const ACTIONS:Object = 
		{
			loadLevel: "LoadLevel"
		}
		
		/**
		 * Call the JavaScript swfInterface.trackEvent method with the FlashEvent event category
		 * @param	action
		 * @param	label
		 */
		public static function trackEvent(action:String, label:String):void
		{
			try {
				ExternalInterface.call("swfInterface.trackEvent", CATEGORY, action, label);
			} 
			catch (e:Error) 
			{
				trace(e)
			}
		}
		
		// Private static const
		private static const CATEGORY:String = "FlashEvent";
	}

}