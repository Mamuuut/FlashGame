package com.objects.model
{
	import com.helpers.XmlPropertiesHelper;
	import physic.model.ObjectModel;
	
	/**
	 * GameObjectModel
	 */
	public class GameObjectModel extends ObjectModel
	{
		public var isAlive:Boolean = false;
		public var preyBits:int = 0;
		public var predatorBits:int = 0;
		
		/**
		 * Constructor
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 */
		public function GameObjectModel(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height );
			mass = int.MAX_VALUE;
		}
		
		/**
		 * Init the model from its XML description
		 * @param	xmlObject
		 */
		public function initPropertiesFromXml(xmlObject:Object):void
		{
			velocity.fromString(xmlObject.velocity);
			
            mass = XmlPropertiesHelper.getNumberValue(xmlObject.mass, mass);
                        
			preyBits = XmlPropertiesHelper.getNumberValue(xmlObject.preyBits, preyBits);
			predatorBits = XmlPropertiesHelper.getNumberValue(xmlObject.predatorBits, predatorBits);
			collideBits = XmlPropertiesHelper.getNumberValue(xmlObject.collideBits, collideBits);
		}
	}
}