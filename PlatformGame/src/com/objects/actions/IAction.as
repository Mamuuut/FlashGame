package com.objects.actions 
{
	import com.objects.model.GameObjectModel;
	
	/**
	 * Action interface
	 * @author mamutdelaunay
	 */
	public interface IAction 
	{
		function acceptsObject(sourceModel:GameObjectModel, targetModel:GameObjectModel):Boolean;
		function execute(sourceModel:GameObjectModel, targetModel:GameObjectModel):void;
	}
	
}