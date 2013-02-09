package com.objects.actions 
{
	import com.events.ObjectEvent;
	import com.objects.model.GameObjectModel;
	/**
	 * KillAction dispatch the DYING GameEvent if the target object must be killed
	 * @author mamutdelaunay
	 */
	public class KillAction implements IAction
	{
		/**
		 * @param	sourceModel
		 * @param	targetModel
		 * @return true if the predatorBits and target preyBits fit togother
		 */
		public function acceptsObject(sourceModel:GameObjectModel, targetModel:GameObjectModel):Boolean
		{
			return sourceModel.isAlive && 0 != (sourceModel.predatorBits & targetModel.preyBits);
		}
		
		/**
		 * Kill the targetModel 
		 * @param	sourceModel
		 * @param	targetModel
		 */
		public function execute(sourceModel:GameObjectModel, targetModel:GameObjectModel):void 
		{
			var event:ObjectEvent = new ObjectEvent(ObjectEvent.DYING);
			targetModel.dispatchEvent(event);
		}
	}

}