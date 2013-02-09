package physictest.events 
{
	import flash.events.Event;
	import physic.model.Vector2D;
	
	/**
	 * PhysicTest specific events
	 * @author mamutdelaunay
	 */
	public class PhysicSettingsEvent extends Event
	{
		/**
		 * Click event for the "Apply" button in the PhysicSettings view
		 */
        public static const APPLY_GRAVITY:String = "applyGravity";
		/**
		 * Gravity change event
		 */
        public static const GRAVITY_CHANGE:String = "gravityChange";
        
		public var gravity:Vector2D;
		
        public function PhysicSettingsEvent(type:String, gravity:Vector2D) 
		{
			super(type);
			this.gravity = gravity;
		}
	}
}