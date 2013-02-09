package com.events 
{
    import flash.events.Event;
	import com.objects.GameObject;
	
	/**
	 * ObjectEvent
	 * @author mamutdelaunay
	 */
    public class ObjectEvent extends Event
    {
		// ObjectEvent types
        public static const DESTROYED:String = "destroyed";
        public static const DYING:String = "dying";
		
		/**
		 * Constructor
		 * @param	type
		 */
        public function ObjectEvent(type:String) 
		{
			super(type);
		}
        
    }

}