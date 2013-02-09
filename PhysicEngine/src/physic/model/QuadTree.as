package physic.model 
{
	import physic.helpers.CollisionHelper;
	
	/**
	 * QuadTree algorithm to optimize collision compute for large amount of objects
	 * @author mamutdelaunay
	 */
	public class QuadTree 
	{	
		public static var MAX_OBJECTS_PER_QUAD:int = 10;
		
		/**
		 * Constructor
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 */
		public function QuadTree(x:Number, y:Number, width:Number, height:Number) 
		{
			_rect = new Rect(x, y, width, height);
			_objects = new Array();
			_childs = new Array();
		}
		
		/* Getters */
		public function get nbObjects():int
		{
			return _objects.length;
		}
		
		public function get rect():Rect
		{
			return _rect;
		}
		
		public function get quadTrees():Array
		{
			if (_isLeaf)
			{
				return [this];
			} else {
				var quadTreesArray:Array = new Array();
				for each(var child:QuadTree in _childs) 
				{
					quadTreesArray = quadTreesArray.concat(child.quadTrees);
				}
				return quadTreesArray;
			}
		}
		
		/**
		 * subdivide quad with more than MAX_OBJECTS_PER_QUAD objects
		 */
		public function subdivide():void
		{
			var halfWidth:Number = Math.floor(_rect.size.x / 2.0);
			var halfHeight:Number = Math.floor(_rect.size.y / 2.0);
			this._childs.push(new QuadTree(_rect.position.x, _rect.position.y, halfWidth, halfHeight));
			this._childs.push(new QuadTree(_rect.position.x + halfWidth, _rect.position.y, _rect.size.x - halfWidth, _rect.size.y - halfHeight));
			this._childs.push(new QuadTree(_rect.position.x, _rect.position.y + halfHeight, halfWidth, halfHeight));
			this._childs.push(new QuadTree(_rect.position.x + halfWidth, _rect.position.y + halfHeight, _rect.size.x - halfWidth, _rect.size.y - halfHeight));

			for each(var object:ObjectModel in _objects) 
			{
				for each(var child:QuadTree in _childs) 
				{
					if (child._rect.intersects(object))
					{
						child.insert(object);
					}
				}
			}

			_objects = new Array();
			_isLeaf = false;
		}
		
		/**
		 * insert an object in a Quad
		 */
		public function insert (object:ObjectModel):void
		{
			_isUpToDate = false;
			
			if( true === _isLeaf )
			{
				_objects.push(object);
				object.parentQuads.push(this);
				if(_objects.length > QuadTree.MAX_OBJECTS_PER_QUAD)
				{
					subdivide();
				}
			}
			else
			{
				for each(var child:QuadTree in _childs) 
				{
					if (child._rect.intersects(object) || child._rect.intersects(object.nextRect))
					{
						child.insert(object);
					}
				}
			}
		}
		
		/**
		 * remove an object from the its parentQuads
		 * @param	object
		 */
		public function remove(object:ObjectModel):void
		{
			_isUpToDate = false;
			
			for each(var parentQuad:QuadTree in object.parentQuads)
			{
				var index:int = parentQuad._objects.indexOf(object);
				parentQuad._objects.splice(index, 1);
			}
			object.parentQuads = new Array();
		}
		
		/**
		 * Clear objects and childs Array
		 */
		public function clear():void 
		{
			for each(var child:QuadTree in _childs)
			{
				child.clear();
				child = null;
			}
			_isLeaf = true;
			_isUpToDate = false;
			_objects = new Array();
			_childs = new Array();
		}
		
		/**
		 * update object parentQuads
		 * @param	object
		 */
		public function update(object:ObjectModel):void
		{
			remove(object);
			insert(object);
		}
		
		/**
		 * @return the QuadTree first collision
		 */
		public function getMinTimeCollision():Collision
		{
			if(_isUpToDate)
			{
				return _minTimeCollision;
			}
			_minTimeCollision = null;
			if(true === _isLeaf)
			{
				_minTimeCollision = CollisionHelper.getMinTimeCollisionFromObjects(_objects);
				return _minTimeCollision;
			}
			else
			{
				for each(var child:QuadTree in _childs)
				{
					_minTimeCollision = CollisionHelper.getMinTimeCollision(_minTimeCollision, child.getMinTimeCollision());
				}
			}
			_isUpToDate = true;
			return _minTimeCollision;
		}
		
		protected var _rect:Rect;
		protected var _childs:Array;
		protected var _objects:Array;
		protected var _isLeaf:Boolean = true;
		protected var _minTimeCollision:Collision;
		protected var _isUpToDate:Boolean = false;
	}
}