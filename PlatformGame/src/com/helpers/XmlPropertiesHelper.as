package com.helpers
{
	import mx.core.Singleton;
	
	/**
	 * XmlPropertiesHelper
	 * @author mamutdelaunay
	 */
	public class XmlPropertiesHelper
	{
		/**
		 * @param	xmlProperty
		 * @param	defaultValue
		 * @return an Object as a Number or a default Number value
		 */
		public static function getNumberValue(xmlProperty:Object, defaultValue:Number):Number
		{
			if (xmlProperty is Number)
			{
				return xmlProperty as Number;
			}
			return defaultValue;
		}
		
		/**
		 * @param	xmlProperty
		 * @param	defaultValue
		 * @return an Object as a Boolean or a default Boolean value
		 */
		public static function getBooleanValue(xmlProperty:String, defaultValue:Boolean):Boolean
		{
			if (null != xmlProperty)
			{
				return "true" == xmlProperty;
			}
			return defaultValue;
		}
		
		/**
		 * @param	xmlProperty
		 * @param	defaultValue
		 * @return an Object as a uint color or a default uint color value
		 */
		public static function getColorValue(xmlProperty:String, defaultValue:uint):uint
		{
			if (null != xmlProperty)
			{
				return Singleton.getInstance("mx.styles::IStyleManager2").getColorName(xmlProperty);
			}
			return defaultValue;
		}
	}

}