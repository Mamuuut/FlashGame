package physic.controller
{
	import physic.model.Collision;
	import physic.model.ObjectModel;
	import physic.model.QuadTree;
	import physic.model.Vector2D;
	
    /**
     * The PhysicController compute the physic properties of a set of object according to the physic laws.
     * @author mamutdelaunay
     */
	public class PhysicController
	{
		public static var GRAVITY:Vector2D = new Vector2D(0, 3);
		public static var MAX_VELOCITY:Vector2D = new Vector2D(40, 40);
		
        /**
         * Constructor
         * @param	gravity The gravity used for the physic engine.
         */
		public function PhysicController(width:Number, height:Number, gravity:Vector2D = null)
		{
			_objects = new Array();
			_quadTree = new QuadTree(0, 0, width, height);
			
			GRAVITY = null != gravity ? gravity : GRAVITY;
		}
		
		/* Getters */
		public function get quadTrees():Array
		{
			return _quadTree.quadTrees;
		}
		
        /**
         * Add an object in the physic engine.
         * @param	object
         */
		public function addObject(object:ObjectModel):void
		{
			_objects.push(object);
			_quadTree.insert(object);
		}
		
        /**
         * Remove an object from the physic engine.
         * @param	object
         */
		public function removeObject(object:ObjectModel):void
		{
            var index:int = _objects.indexOf(object);
			_objects.splice(index, 1);
			_quadTree.remove(object);
		}
		
        /**
         * Remove all objects in the physic engine
         */
		public function clear():void
		{
			_quadTree.clear();
			_objects = new Array();
		}
		
        /**
         * Update the objects physic properties.
         */
		public function updatePhysic():void
		{
			_nbCompute = 0;
			for each (var object:ObjectModel in _objects)
            {
				object.updateForces();
				object.resetForces();
                object.updateTimeNextPosition(0);
				_quadTree.update( object );
            }
               
			clearContacts();         
            updateCollisions();
            
            for each (object in _objects)
			{
				object.updatePosition();
				object.checkObjectIntersections(_objects);
			}
		}
		
        /**
         * Compute the first collision between objects.
         * The method is recursively called until no more collision is found.
         */
		protected function updateCollisions():void
		{
			var minTimeCollision:Collision = _quadTree.getMinTimeCollision();
			if(null != minTimeCollision)
			{
				_nbCompute++;
				minTimeCollision.collide();
				
				for each(var object:ObjectModel in minTimeCollision.objects) {
					_quadTree.update(object);
				}
				updateCollisions();
			}
		}
		
        /**
         * Clear all the object contacts
         */
		protected function clearContacts():void 
		{
			for each (var object:ObjectModel in _objects)
            {
				object.clearContacts();
            }
		}
		
        /**
         * Check if the new collision found occurred before the current one
         * @param	collision
         */
		protected function checkMinTimeCollision(collision:Collision):void
		{
			if (null != collision && collision.time >= 0 && collision.time <= 1 && (null == _minTimeCollision || collision.time < _minTimeCollision.time))
			{
                _minTimeCollision = collision;
			}
		}
		
		protected var _quadTree:QuadTree;
		protected var _nbCompute:Number = 0;
        protected var _minTimeCollision:Collision;
		protected var _objects:Array;
	}

}