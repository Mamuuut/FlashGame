package com.scroller 
{
	import flash.utils.getDefinitionByName;
	import com.helpers.XmlPropertiesHelper;
	import com.level.LevelController;
    
    /**
	 * ScrollerFactory
     * @author mamutdelaunay
     */
    public class ScrollerFactory 
    {
		/**
		 * @param	level
		 * @param	xmlObject
		 * @return A new level scroller from its xml description
		 */
        public static function createScroller(level:LevelController, xmlObject:Object):LevelScroller
        {
			// Scroll Start
			var scrollX:Number = XmlPropertiesHelper.getNumberValue(xmlObject.scrollX, 0);
			var scrollY:Number = XmlPropertiesHelper.getNumberValue(xmlObject.scrollY, 0);
			
			// Scroller Class
            var scrollerClassName:String = null == xmlObject.className ? DEFAULT_CLASS_NAME : xmlObject.className;
			var ScrollerClass:Class = getDefinitionByName(CLASS_NAME_PREFIX + scrollerClassName) as Class;
            
            var scroller:LevelScroller = new ScrollerClass(level);
            scroller.initXmlProperties(xmlObject);
            
			return scroller;
        }
		
		// Private static const
		private static const DEFAULT_CLASS_NAME:String = "PlayerScroller";
		private static const CLASS_NAME_PREFIX:String = "com.scroller."
        
		// Compilation 
		private var __horizontalAutoScrollerForCompiler:HorizontalAutoScroller;
		private var __verticalAutoScrollerForCompiler:VerticalAutoScroller;
		private var __playerScrollerForCompiler:PlayerScroller;        
    }
}