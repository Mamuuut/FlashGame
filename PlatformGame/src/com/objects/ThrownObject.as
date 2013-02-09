package com.objects 
{
	import com.helpers.RelativePositionHelper;
	import com.level.LevelController;
	import com.objects.actions.GroundCollisionAction;
	import com.objects.actions.KillAction;
	
	/**
	 * ThrownObject
	 * @author mamutdelaunay
	 */
	public class ThrownObject extends GameObject
	{	
		/**
		 * Constructor
		 * @param	throwingObject
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function ThrownObject(throwingObject:GameObject, level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.mass = 1;
			xmlGameObject.predatorBits = throwingObject.model.predatorBits;

			super(level, xmlGameObject);
			
			model.position.x = RelativePositionHelper.getXPos(throwingObject, view.width, X_POSITION_OFFSET);
			model.position.y = RelativePositionHelper.getYPos(throwingObject, view.height, Y_POSITION_OFFSET);
			model.velocity.x = throwingObject.view.xFlip ? throwingObject.model.velocity.x - X_VELOCITY_OFFSET : throwingObject.model.velocity.x + X_VELOCITY_OFFSET;
			model.velocity.y = throwingObject.model.velocity.y + Y_VELOCITY_OFFSET;
			
			addAction(new KillAction());
			addAction(new GroundCollisionAction());
		}
		
		private static const X_POSITION_OFFSET:int = 0;
		private static const Y_POSITION_OFFSET:int = -40;
		private static const X_VELOCITY_OFFSET:int = 20;
		private static const Y_VELOCITY_OFFSET:int = -20;
	}

}