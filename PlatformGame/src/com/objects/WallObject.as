package com.objects 
{
	import com.level.LevelController;
	import com.objects.GameObject;
	import com.objects.model.CollideBits;
	
	/**
	 * WallObject
	 * @author mamutdelaunay
	 */
    public class WallObject extends GameObject
    {
     
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function WallObject(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.collideBits = CollideBits.DECOR_ENEMY + CollideBits.DECOR_PLAYER;
            xmlGameObject.sprite = "wall";
            
			super(level, xmlGameObject);            
        }
        
    }

}