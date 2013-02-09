package com.objects 
{
	import com.assetviews.IAnimation;
	import com.assetviews.ObjectView;
	import com.level.LevelController;
	import com.objects.model.PredatorBits;
	import com.pinocchio.AnimationNames;
	import flash.events.Event;
	
	/**
	 * FireOjbect
	 * @author mamutdelaunay
	 */
	public class FireObject extends GameObject
	{
		/**
		 * Constructor
		 * @param	level
		 */
		public function FireObject(level:LevelController)
		{
			var xmlGameObject:Object = new Object();
			xmlGameObject.predatorBits = PredatorBits.PLAYER_ENEMY;
			xmlGameObject.animation = "fire";
			super(level, xmlGameObject);
			view.addEventListener(ObjectView.LOOP_END, onAnimationEnd, false, 0, true);
			playAnimation(AnimationNames.IDLE, 1);
		}
		
		/**
		 * Animation LOOP_END event handler
		 * @param	event
		 */
		protected function onAnimationEnd(event:Event):void
		{
			(view as IAnimation).removeEventListener(ObjectView.LOOP_END, onAnimationEnd);
			die();
		}
		
		/**
		 * Remove the LOOP_END event listener
		 * @param	event
		 */
		override protected function onRemoved(event:* = null):void
		{
			view.removeEventListener(ObjectView.LOOP_END, die);
			super.onRemoved(event);
		}
	}

}