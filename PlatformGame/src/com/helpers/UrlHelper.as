package com.helpers
{
	import mx.utils.StringUtil;
	
	/**
	 * UrlHelper
	 * @author mamutdelaunay
	 */
	public class UrlHelper
	{
		// Public static
		public static var swfPath:String;
		
		/**
		 * @return the swfPath if locale or "" if not
		 */
		public static function getSwfPath():String
		{
			if (-1 == swfPath.indexOf("file"))
			{
				return swfPath;
			}
            else
            {
                return "";
            }
		}
		
		/**
		 * Set the swf path
		 * @param	path
		 */
		public static function setSwfPath(path:String):void
		{
			swfPath = path;
		}
	}

}