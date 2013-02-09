package physictest.events 
{
	import flash.events.Event;
	import physictest.level.controller.LevelObject;
	
	/**
	 * LevelController event
	 * @author mamutdelaunay
	 */
	public class LevelEvent extends Event 
	{
		/**
		 * LevelController next frame event
		 */
        public static const NEXT_FRAME:String = "nextFrame";		
		
        public function LevelEvent(type:String) 
		{
			super(type);
		}
	}
}