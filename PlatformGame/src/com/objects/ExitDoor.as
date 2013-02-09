package com.objects 
{
	import com.level.LevelController;
	import com.objects.actions.LevelCompleteAction;
    
	/**
	 * ExitDoor
	 * @author mamutdelaunay
	 */
    public class ExitDoor extends GameObject
    {
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function ExitDoor(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.sprite = "level_end";
			super(level, xmlGameObject);
			
			addAction(new LevelCompleteAction());
		}
    }

}