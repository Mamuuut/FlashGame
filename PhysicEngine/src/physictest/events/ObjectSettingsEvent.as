package physictest.events 
{
	import flash.events.Event;
	import physictest.level.controller.LevelObject;
	
	/**
	 * ObjectsSetting event
	 * @author mamutdelaunay
	 */
	public class ObjectSettingsEvent extends Event 
	{
		/**
		 * ObjectView view click event
		 */
        public static const OBJECT_CLICK:String = "objectClick";
        
		public var levelObject:LevelObject;
		
		
        public function ObjectSettingsEvent(type:String, levelObject:LevelObject) 
		{
			super(type);
			this.levelObject = levelObject;
		}
	}
}