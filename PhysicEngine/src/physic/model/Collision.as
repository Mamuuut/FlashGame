package physic.model
{
	import physic.events.PhysicEvent;
	
    /**
     * Collision describe a between 2 objects.
     * @author mamutdelaunay
     */
	public class Collision
	{
		public var time:Number; // from 0 to 1
		public var axis:String; // x or y 
		public var objectA:ObjectModel;
		public var objectB:ObjectModel;
		
        /**
         * Constructor
         * @param	objectA The object on the axis_min side (left or top)
         * @param	objectB The object on the axis_max side (right or bottom)
         * @param	axis The axis of the contact
         * @param	time The time when the collision occurred
         */
		public function Collision(objectA:ObjectModel, objectB:ObjectModel, axis:String, time:Number)
		{
			this.objectA = objectA;
			this.objectB = objectB;
			this.axis = axis;
			this.time = time;
		}
		
        /**
         * @return all the objects having a contact involved in the collision
         */
		public function get objects():Array
		{
			var minContactObjects:Array = objectA.getContactObjects(axis, Rect.LEFT_TOP);
			var maxContactObjects:Array = objectB.getContactObjects(axis, Rect.RIGHT_BOTTOM);
			return minContactObjects.concat(maxContactObjects);
		}
		
        /**
         * Update object position, next position, previous velocity and velocity according to the collision result
         * Dispatch a PhysicEvent.COLLIDE event on both objects
         */
		public function collide():void
		{
			var nextVelocity:int = getNextVelocity();
			for each (var object:ObjectModel in objects)
			{
				object.updateTimePosition(time);
				object.velocity[axis] = nextVelocity;
				object.updateTimeNextPosition(time);
			}
			objectA.dispatchEvent(new PhysicEvent(PhysicEvent.COLLIDE, objectB));
			objectB.dispatchEvent(new PhysicEvent(PhysicEvent.COLLIDE, objectA));
		}
		
        /**
         * @return The objects next velocity (as we don't use object elasticity this velocity is the same for both of them)
         */
		protected function getNextVelocity():int
		{
			return Math.round(getPonderatedVelocity() / getMassSum());
		}
		
        /**
         * @return the mass sum for all objects involved in the collision
         */
		protected function getMassSum():Number
		{
			var massSum:Number = 0;
			for each (var object:ObjectModel in objects)
			{
				if (object.hasMaxMass())
				{
					return 1;
				}
				massSum += object.mass;
			}
			return massSum;
		}
		
        /**
         * @return the objects ponderated velocity according to their mass
         */
		protected function getPonderatedVelocity():Number
		{
			var ponderatedVelocity:Number = 0;
			for each (var object:ObjectModel in objects)
			{
				if (object.hasMaxMass())
				{
					return object.velocity[axis];
				}
				ponderatedVelocity += object.mass * object.velocity[axis];
			}
			return ponderatedVelocity;
		}
	}

}