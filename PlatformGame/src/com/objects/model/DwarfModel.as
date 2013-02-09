package com.objects.model
{
	import physic.model.Vector2D;
	
	/**
	 * DwarfModel
	 */
	public class DwarfModel extends GameObjectModel
	{
		/**
		 * When the dwarf start burning, its velocity value change to burningVelocity
		 */
		public var burningVelocity:Vector2D = new Vector2D(0, 0);
        
		/**
         * Constructor
         */
		public function DwarfModel(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height);
		}    
		
		/**
		 * Initialize DwarfModel specific properties
		 * @param	xmlObject
		 */
		override public function initPropertiesFromXml(xmlObject:Object):void
		{
			super.initPropertiesFromXml(xmlObject);
			
			burningVelocity.fromString(xmlObject.burningVelocity);
			airResistanceCoefficient = 0;
		}
	}

}