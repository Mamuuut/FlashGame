package com.objects 
{
	import com.level.LevelController;
	
	/**
	 * PinocchioObject
     * @author mamutdelaunay
     */
    public class PinocchioObject extends Player
    {   
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function PinocchioObject(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.animation = "pinocchio";
			super(level, xmlGameObject);            
        }
        
    }

}