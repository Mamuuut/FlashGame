package com.objects.actions 
{
	import com.events.GameEvent;
	import com.objects.model.GameObjectModel;
	import com.objects.model.PlayerModel;
	/**
	 * LevelCompleteAction
	 * @author mamutdelaunay
	 */
	public class LevelCompleteAction implements IAction
	{
		/**
		 * @param	gameObject
		 * @return true if the target gameObjectModel is a PlayerModel
		 */
		public function acceptsObject(sourceModel:GameObjectModel, targetModel:GameObjectModel):Boolean
		{
			return targetModel is PlayerModel;
		}
		
		/**
		 * Execute a U-Turn on the Dwarf by reverting its velocity
		 * @param	gameObjectModel
		 */
		public function execute(sourceModel:GameObjectModel, targetModel:GameObjectModel):void 
		{
			targetModel.dispatchEvent(new GameEvent(GameEvent.LEVEL_COMPLETE));
		}
	}
}