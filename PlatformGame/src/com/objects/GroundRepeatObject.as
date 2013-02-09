package com.objects 
{
	import com.level.LevelController;
	/**
     * GroundRepeatObject
     * @author mamutdelaunay
     */
    public class GroundRepeatObject extends GameObject 
    {
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function GroundRepeatObject(level:LevelController, xmlGameObject:Object)
		{
			xmlGameObject.sprite = "ground_repeat";
			super(level, xmlGameObject);  
        }
    }

}