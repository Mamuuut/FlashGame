package com.objects.model 
{
    import com.helpers.XmlPropertiesHelper;
	
    
	/**
	 * LinearMoveObjectModel
	 * @author mamutdelaunay
	 */
    public class LinearMoveObjectModel extends GameObjectModel
    {        
        public var xMin:int = 0;
		public var xMax:int = 0;
        public var yMin:int = 0;
		public var yMax:int = 0;
        		
        /**
         * Constructor
         */
		public function LinearMoveObjectModel(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height);
		}
		
		/* Getters/Setters */
        public function get xAnimSpeed():int {
            return _xAnimSpeed;
        }
        
		public function set xAnimSpeed(xAnimSpeed:int):void {
			_xAnimSpeed = xAnimSpeed;
			velocity.x = _xAnimSpeed;
		}
        
        public function get yAnimSpeed():int {
            return _yAnimSpeed;
        }
		
		public function set yAnimSpeed(yAnimSpeed:int):void {
			_yAnimSpeed = yAnimSpeed;
			velocity.y = _yAnimSpeed;
		}
        
		/**
		 * Initialize LinearMoveObjectModel specific properties
		 * @param	xmlObject
		 */
        override public function initPropertiesFromXml(xmlObject:Object):void
        {
            super.initPropertiesFromXml(xmlObject);
            
			xMin = XmlPropertiesHelper.getNumberValue(xmlObject.xMin, xMin);
			xMax = XmlPropertiesHelper.getNumberValue(xmlObject.xMax, xMax);
			yMin = XmlPropertiesHelper.getNumberValue(xmlObject.yMin, yMin);
			yMax = XmlPropertiesHelper.getNumberValue(xmlObject.yMax, yMax);
			xAnimSpeed = XmlPropertiesHelper.getNumberValue(xmlObject.xAnimSpeed, xAnimSpeed);
			yAnimSpeed = XmlPropertiesHelper.getNumberValue(xmlObject.yAnimSpeed, yAnimSpeed);
        }
        
		protected var _xAnimSpeed:int = 0;
		protected var _yAnimSpeed:int = 0;
    }

}