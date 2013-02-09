package com.objects 
{
	/**
	 * ElevatorObject
     * @author mamutdelaunay
     */
	import com.level.LevelController;
    import com.objects.model.CollideBits;
    public class ElevatorObject extends LinearMoveObject
    {
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function ElevatorObject(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.yAnimSpeed = 8;
            xmlGameObject.collideBits = CollideBits.DECOR_ENEMY + CollideBits.DECOR_PLAYER;
			xmlGameObject.sprite = "elevator"
            
			super(level, xmlGameObject);
        }
    }

}