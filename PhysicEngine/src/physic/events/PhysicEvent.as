package physic.events 
{
	import flash.events.Event;
	import physic.model.ObjectModel;
	
    /**
     * PhysicEvent describes the events used in the physic engine
     * @author mamutdelaunay
     */
	public class PhysicEvent extends Event
	{
        public static const COLLIDE:String = "collide";
        public static const INTERSECT:String = "intersect";
		
		public var object:ObjectModel;
		
        public function PhysicEvent(type:String, object:ObjectModel) 
		{
			super(type);
			this.object = object;
		}
	}

}