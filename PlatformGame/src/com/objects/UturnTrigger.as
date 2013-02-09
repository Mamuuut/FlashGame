package com.objects
{
	import com.level.LevelController;
	import com.objects.actions.UturnAction;
	import com.objects.model.CollideBits;
	import physic.events.PhysicEvent;
	
	/**
	 * UturnTrigger revert object velocity when an object intersects
	 * @author mamutdelaunay
	 */
	public class UturnTrigger extends GameObject
	{
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function UturnTrigger(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.objectViewClass = "ObjectView";
			super(level, xmlGameObject);
			
			addAction(new UturnAction());
		}
	}
}