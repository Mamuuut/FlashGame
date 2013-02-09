package com.objects 
{
	/**
	 * GroundObject
     * @author mamutdelaunay
     */
	import com.assetviews.AssetManager;
	import com.level.LevelController;
    import com.objects.model.CollideBits;
    public class GroundObject extends GameObject
    {
        /**
         * Constructor
         * @param	level
         * @param	xmlGameObject
         */
        public function GroundObject(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.collideBits = CollideBits.DECOR_ENEMY + CollideBits.DECOR_PLAYER;
            xmlGameObject.sprite = "ground_edge";
            
			super(level, xmlGameObject);    
        }
        
    }

}