package physic.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import physic.controller.PhysicController;
	import physic.events.PhysicEvent;
	
    /**
     * ObjectModel describe a physic object model.
     * @author mamutdelaunay
     */
	public class ObjectModel extends Rect implements IEventDispatcher
	{   
        /**
         * the object current velocity (x and y)
         */
		[Bindable]
        public var velocity:Vector2D;
        public var mass:Number;
		public var nextPosition:Vector2D;
        public var contacts:Contacts;
        public var airResistanceCoefficient:Number = 0.05;
		public var defaultKineticFrictionCoefficient:Number = 0;
        		
        /**
         * Constructor
         */
		public function ObjectModel(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height);
			nextPosition = new Vector2D(x, y);
			
			_parentQuads = new Array();
			_eventDispatcher = new EventDispatcher(this);
			
			velocity = new Vector2D();
			mass = 1;
			contacts = new Contacts();
			
			resetForces();
		}
		
		/**
		 * Remove references
		 */
		public function dispose():void 
		{
			_parentQuads = null;
			_eventDispatcher = null;
		}
		
		/**
		 * @return the parent QuadTree Array
		 */
		public function get parentQuads():Array
		{
			return _parentQuads;
		}
		
		public function set parentQuads(parentQuads:Array):void
		{
			_parentQuads = parentQuads;
		}
		
		public function get nextRect():Rect 
		{
			return new Rect(nextPosition.x, nextPosition.y, size.x, size.y);
		}
		
		/**
		 * Update the current position with the precalculated next position
		 */
		public function updatePosition():void
		{
			position.x = nextPosition.x;
			position.y = nextPosition.y;
		}
		
		/**
		 * Check if this object is overriding with another object
         * If true, dispatch an PhysicEvent.OVERRIDE event
		 */
		public function checkObjectIntersections(objects:Array):void
		{
			for each (var object:ObjectModel in objects)
			{
				if (this != object && intersects(object))
				{
					dispatchEvent(new PhysicEvent(PhysicEvent.INTERSECT, object));
				}
			}
		}
		
		/**
		 * @return the collide bits (to know if 2 differents objects can collide)
		 */
		public function get collideBits():int
		{
			return _collideBits;
		}
		
		public function set collideBits(collideBits:int):void
		{
			_collideBits = collideBits;
		}
		
        /**
         * check if this object can collide with another object according to their collideBits
         * @param	object
         * @return  true if the 2 objects can collide
         */
		public function collidesWith(object:ObjectModel):Boolean
		{
			var result:int = (collideBits & object.collideBits);
			return 0 != result;
		}
		
		/**
		 * Reset the object contacts
		 */
		public function clearContacts():void
		{
			contacts.clear();
		}
		
        /**
         * Return an array of objects having a contact with this one on a specific axis and position
         * @param	axis x or y
         * @param	position axis_min or axis_max
         * @return  an Array of objects
         */
		public function getContactObjects(axis:String, position:String):Array
		{
			var objects:Array = new Array();
			objects.push(this);
			if (0 != contacts.getObjects(axis, position).length)
			{
				for each (var object:ObjectModel in contacts.getObjects(axis, position))
				{
					objects = objects.concat(object.getContactObjects(axis, position));
				}
			}
			return objects;
		}
		
		/**
		 * Compute the position at an intermediate time between 2 frames
		 * @param	frameTime time ratio between 2 frames (0 to 1 value). 0 is the position at the begining of the frame and 1 is the position at the begining of the next frame
		 * @return  a position
		 */
		public function getTimePosition(frameTime:Number):Vector2D
		{
			return new Vector2D(Math.round(position.x + frameTime * velocity.x), Math.round(position.y + frameTime * velocity.y));
		}
		
        /**
         * Update the object position at an intermediate time between 2 frames
         * @param	frameTime
         */
		public function updateTimePosition(frameTime:Number):void
		{
			clampVelocity();
			position = getTimePosition(frameTime);
		}
		
        /**
         * Update the object next position at an intermediate time between 2 frames
         * @param	frameTime
         */
		public function updateTimeNextPosition(frameTime:Number):void
		{
			clampVelocity();
			nextPosition = getTimePosition(1 - frameTime);
		}
		
        /**
         * clamp the object velocity between -MAX_VELOCITY and +MAX_VELOCITY
         */
		protected function clampVelocity():void
		{
			velocity.x = Math.max(-PhysicController.MAX_VELOCITY.x, Math.min(PhysicController.MAX_VELOCITY.x, velocity.x));
			velocity.y = Math.max(-PhysicController.MAX_VELOCITY.y, Math.min(PhysicController.MAX_VELOCITY.y, velocity.y));
		}
        
		/**
         * Add a contact to the object
         */
		public function addContact(object:ObjectModel, axis:String, position:String, force:Number):void
		{
			contacts.addContact(object, axis, position);
			var orthogonalAxis:String = Vector2D.getOrthogonalAxis(axis);
			var kineticFriction:Number = force * getKineticFrictionCoefficient(object);
			if (velocity[orthogonalAxis] > 0)
			{
				_kineticFrictionForce[orthogonalAxis] -= kineticFriction;
			} else if (velocity[orthogonalAxis] < 0)
			{
				_kineticFrictionForce[orthogonalAxis] += kineticFriction;
			}
			var staticFriction:Number = Math.abs(force * getStaticFrictionCoefficient(object));
			_staticFrictionMax[orthogonalAxis] = Math.max( _staticFrictionMax[orthogonalAxis], staticFriction );
		}
		
        /**
         * Check if the object has an infinite mass (so that forces do not interact with the object movement)
         */
		public function hasMaxMass():Boolean
		{
			return int.MAX_VALUE == mass;
		}
		
		/* Forces */
		
		/**
		 * Reset the forces applied to the object
		 */
		public function resetForces():void
		{
			_forces = new Array();
			_kineticFrictionForce = new Vector2D();
			_staticFrictionMax = new Vector2D();
			addForce(PhysicController.GRAVITY);
		}
		
        /**
         * Add a force to the object
         * @param	force
         */
		public function addForce(force:Vector2D):void
		{
			_forces.push(force);
		}
		
        /**
         * update the object velocity according to the forces applied to it and frictions.
         */
		public function updateForces():void
		{
			updateAxisForces(Vector2D.X_AXIS);
			updateAxisForces(Vector2D.Y_AXIS);
		}
		
        /**
         * update the object velocity according to the forces applied to it and frictions.
         * @param	axis
         */
		protected function updateAxisForces(axis:String):void
		{
			if (!hasMaxMass())
			{
				velocity[axis] += _kineticFrictionForce[axis];
				for each (var force:Vector2D in _forces)
				{
					velocity[axis] += force[axis];
				}
				velocity[axis] -= getAirFrictionForce(axis);
				if (Math.abs(velocity[axis]) < _staticFrictionMax[axis])
				{
					velocity[axis] = 0;
				}
			}
		}
		
		protected function getAirFrictionForce(axis:String):Number
		{
			return velocity[axis] * airResistanceCoefficient;
		}
		
		/* IEventDispatcher implementation */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event:Event): Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
		
		/* kinetic coefficients */
		
        /**
         * @param	axis
         * @return  the kinetic friction coefficient between 2 objects
         */
		protected function getKineticFrictionCoefficient(object:ObjectModel):Number
		{
			return defaultKineticFrictionCoefficient;
		}
		
        /**
         * @param	axis
         * @return  the static friction coefficient between 2 objects
         */
		protected function getStaticFrictionCoefficient(object:ObjectModel):Number
		{
			return 0.2;
		}
		
		/* protected members */
		protected var _eventDispatcher:EventDispatcher;
		protected var _parentQuads:Array;
		protected var _staticFrictionMax:Vector2D;
		protected var _kineticFrictionForce:Vector2D;
		protected var _forces:Array;
		protected var _collideBits:int = 0;
	}
}