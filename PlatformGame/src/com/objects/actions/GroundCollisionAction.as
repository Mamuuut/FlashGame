package com.objects.actions 
{
	import com.events.ObjectEvent;
	import com.objects.model.CollideBits;
	import com.objects.model.GameObjectModel;
	/**
	 * GroundCollisionAction
	 * @author mamutdelaunay
	 */
	public class GroundCollisionAction implements IAction
	{
		/**
		 * @param	sourceModel
		 * @param	targetModel
		 * @return true if the target collideBits is DECOR_PLAYER
		 */
		public function acceptsObject(sourceModel:GameObjectModel, targetModel:GameObjectModel):Boolean
		{
			return 0 != (targetModel.collideBits & CollideBits.DECOR_PLAYER);
		}
		
		/**
		 * Kill the sourceModel 
		 * @param	sourceModel
		 * @param	targetModel
		 */
		public function execute(sourceModel:GameObjectModel, targetModel:GameObjectModel):void 
		{
			var event:ObjectEvent = new ObjectEvent(ObjectEvent.DYING);
			sourceModel.dispatchEvent(event);
		}
	}

}