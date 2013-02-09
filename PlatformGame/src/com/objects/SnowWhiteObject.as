package com.objects 
{
	import com.level.LevelController;
	import com.objects.actions.LevelCompleteAction;
	
	/**
	 * SnowWhiteObject is the last level end
	 * @author mamutdelaunay
	 */
    public class SnowWhiteObject extends GameObject
    {   
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function SnowWhiteObject(level:LevelController, xmlGameObject:Object)
		{
			xmlGameObject.animation = "snow_white";
			super(level, xmlGameObject);
			
			addAction(new LevelCompleteAction());
		}
    }
}