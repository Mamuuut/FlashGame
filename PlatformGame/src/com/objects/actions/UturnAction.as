package com.objects.actions 
{
	import com.objects.model.DwarfModel;
	import com.objects.model.GameObjectModel;
	
	/**
	 * Action to execute on an object
	 * @author mamutdelaunay
	 */
	public class UturnAction implements IAction
	{		
		/**
		 * @param	gameObject
		 * @return true if the target gameObjectModel is a DwarfModel
		 */
		public function acceptsObject(sourceModel:GameObjectModel, targetModel:GameObjectModel):Boolean
		{
			return targetModel is DwarfModel;
		}
		
		/**
		 * Execute a U-Turn on the Dwarf by reverting its velocity
		 * @param	gameObjectModel
		 */
		public function execute(sourceModel:GameObjectModel, targetModel:GameObjectModel):void 
		{
			targetModel.velocity.x *= -1;
		}
	}

}