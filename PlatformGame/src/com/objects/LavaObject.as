package com.objects 
{
	/**
	 * LavaObject
     * @author mamutdelaunay
     */
	import com.assetviews.IAnimation;
	import com.level.LevelController;
	import com.objects.actions.KillAction;
    import com.objects.model.CollideBits;
    public class LavaObject extends GameObject
    {
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
        public function LavaObject(level:LevelController, xmlGameObject:Object)
		{
			xmlGameObject.predatorBits = 1;
			xmlGameObject.animation = "lava";
			super(level, xmlGameObject);    
			addAction(new KillAction());
        }
    }

}