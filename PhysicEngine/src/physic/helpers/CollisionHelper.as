package physic.helpers
{
	import physic.model.Collision;
	import physic.model.ObjectModel;
	import physic.model.Rect;
	import physic.model.Vector2D;
	
    /**
     * CollisionHelper
     * @author mamutdelaunay
     */
	public class CollisionHelper
	{	
		/**
		 * Update the objects Contacts
		 * @param	objectA
		 * @param	objectB
		 */
		public static function checkContacts(objectA:ObjectModel, objectB:ObjectModel):void
		{
			if (objectA.hasMaxMass() && objectB.hasMaxMass())
			{
				return
			}
		
			if( (objectB.position.x > ( objectA.position.x + objectA.size.x ) || 
			   ( objectB.position.x + objectB.size.x ) < objectA.position.x || 
			   objectB.position.y > ( objectA.position.y + objectA.size.y ) ||
			   ( objectB.position.y + objectB.size.y ) < objectA.position.y ) )
			{
			   return;   
		    }
			
			var xProj:Number = getAxisProj(Vector2D.X_AXIS, objectA, objectB);
			var yProj:Number = getAxisProj(Vector2D.Y_AXIS, objectA, objectB);
			
			if (0 <= xProj && 0 <= yProj)
			{
				if (xProj < yProj)
				{
					checkAxisContact(Vector2D.X_AXIS, objectA, objectB);
				}
				else
				{
					checkAxisContact(Vector2D.Y_AXIS, objectA, objectB);
				}
			}
		}
		
		/**
		 * @param	objectA
		 * @param	objectB
		 * @return the Collision between 2 objects or null if there are not colliding.
		 */
		public static function getCollision(objectA:ObjectModel, objectB:ObjectModel):Collision
		{
			if (objectA.hasMaxMass() && objectB.hasMaxMass())
			{
				return null;
			}
			
            // Compute the time ratio between the current and the next frame when the collision may occurre on the x axis.
			var leftObject:ObjectModel = getLeftTopObject(Vector2D.X_AXIS, objectA, objectB);
			var rightObject:ObjectModel = getRightBottomObject(Vector2D.X_AXIS, objectA, objectB);
			var xCollisionTime:Number = getCollisionTime(Vector2D.X_AXIS, leftObject, rightObject);
			
            // Compute the time ratio between the current and the next frame when the collision may occurre on the y axis.
			var topObject:ObjectModel = getLeftTopObject(Vector2D.Y_AXIS, objectA, objectB);
			var bottomObject:ObjectModel = getRightBottomObject(Vector2D.Y_AXIS, objectA, objectB);
			var yCollisionTime:Number = getCollisionTime(Vector2D.Y_AXIS, topObject, bottomObject);
			
            // The collision occurred on both axis. We need to determinate on which axis it occurred first.
			if (0 <= xCollisionTime && 1 >= xCollisionTime && 0 <= yCollisionTime && 1 >= yCollisionTime)
			{
				if (xCollisionTime <= yCollisionTime)
				{
					return new Collision(leftObject, rightObject, Vector2D.X_AXIS, xCollisionTime);
				}
				else
				{
					return new Collision(topObject, bottomObject, Vector2D.Y_AXIS, yCollisionTime);
				}
			}
            // A collision occurred on the x axis.
			else if (0 <= xCollisionTime && 1 >= xCollisionTime)
			{
				var topObjectBottom:Number = topObject.getTimePosition(xCollisionTime).y + topObject.size.y;
				var bottomObjectTop:Number = bottomObject.getTimePosition(xCollisionTime).y;
				if (topObjectBottom >= bottomObjectTop && leftObject.velocity.x > rightObject.velocity.x)
				{
					return new Collision(leftObject, rightObject, Vector2D.X_AXIS, xCollisionTime);
				}
			}
            // A collision occurred on the y axis.
			else if (0 <= yCollisionTime && 1 >= yCollisionTime)
			{
				var leftObjectRight:Number = leftObject.getTimePosition(yCollisionTime).x + leftObject.size.x;
				var rightObjectleft:Number = rightObject.getTimePosition(yCollisionTime).x;
				if (leftObjectRight >= rightObjectleft && topObject.velocity.y > bottomObject.velocity.y)
				{
					return new Collision(topObject, bottomObject, Vector2D.Y_AXIS, yCollisionTime);
				}
			}
			return null;
		}
		
        /**
         * @param	axis
         * @param	objectA The object on the axis_min side (left or top).
         * @param	objectB The object on the axis_max side (right or bottom).
         * @return  time ratio between the current and the next frame when the collision may occurre (if not between 0 to 1, there is no collision during the current frame).
         */
		public static function getCollisionTime(axis:String, objectA:ObjectModel, objectB:ObjectModel):Number
		{
			return (objectA.position[axis] + objectA.size[axis] - objectB.position[axis]) / (objectB.velocity[axis] - objectA.velocity[axis]);
		}
	
		/**
		 * @param	objects
		 * @return first collision in a group of objects
		 */
		public static function getMinTimeCollisionFromObjects(objects:Array):Collision
		{
			var minTimeCollision:Collision;
			for (var i:int = 0; i < objects.length; i++)
			{
				for (var j:int = i + 1; j < objects.length; j++)
				{
					if(objects[i].collidesWith(objects[j]))
					{
						CollisionHelper.checkContacts(objects[i], objects[j]);
						minTimeCollision = CollisionHelper.getMinTimeCollision(minTimeCollision, CollisionHelper.getCollision(objects[i], objects[j]));
					}
				}
			}
			return minTimeCollision;
		}
	
		/**
		 * @param	collisionA
		 * @param	collisionB
		 * @return the first valid collision
		 */
		public static function getMinTimeCollision(collisionA:Collision, collisionB:Collision):Collision
		{
			var isCollisionAValid:Boolean = CollisionHelper.isValidCollision(collisionA);
			var isCollisionBValid:Boolean = CollisionHelper.isValidCollision(collisionB);  
			if (!isCollisionAValid && isCollisionBValid)
			{
				return collisionB;
			}
			if(isCollisionAValid && !isCollisionBValid)
			{
				return collisionA;
			}
			if(isCollisionAValid && isCollisionBValid)
			{
				return collisionA.time < collisionB.time ? collisionA : collisionB;
			}
			return null;
		}
	
		/**
		 * @param	collision
		 * @return true if a collision is valid
		 */
		protected static function isValidCollision(collision:Collision):Boolean
		{
			return null != collision && collision.time >= 0 && collision.time <= 1;
		}
		
		/**
		 * Add the contacts for the objects if needed
		 * @param	axis
		 * @param	objectA
		 * @param	objectB
		 */
		protected static function checkAxisContact(axis:String, objectA:ObjectModel, objectB:ObjectModel):void
		{
			var leftTopObject:ObjectModel = getLeftTopObject(axis, objectA, objectB);
			var rightBottomObject:ObjectModel = getRightBottomObject(axis, objectA, objectB);
			
			var force:Number = leftTopObject.velocity[axis] - rightBottomObject.velocity[axis];
			if (force >= 0)
			{
				leftTopObject.addContact(rightBottomObject, axis, Rect.RIGHT_BOTTOM, force);
				rightBottomObject.addContact(leftTopObject, axis, Rect.LEFT_TOP, force);
			}
		}
		
		/**
		 * @param	axis
		 * @param	objectA
		 * @param	objectB
		 * @return  object intersection between the 2 object projections on the axis.
		 */
		protected static function getAxisProj(axis:String, objectA:ObjectModel, objectB:ObjectModel):Number
		{
			var leftTop:Number = Math.max(objectA.leftTop[axis], objectB.leftTop[axis]);
			var rightBottom:Number = Math.min(objectA.rightBottom[axis], objectB.rightBottom[axis]);
			return rightBottom - leftTop;
		}
		
		/**
		 * @param	axis
		 * @param	objectA
		 * @param	objectB
		 * @return the object on axis_min side for the specified axis.
		 */
		protected static function getLeftTopObject(axis:String, objectA:ObjectModel, objectB:ObjectModel):ObjectModel
		{
			if (objectA.rightBottom[axis] <= objectB.leftTop[axis])
			{
				return objectA;
			}
			return objectB;
		}
		
        /**
         * @param	axis
         * @param	objectA
         * @param	objectB
         * @return the object on axis_max side for the specified axis.
         */
		protected static function getRightBottomObject(axis:String, objectA:ObjectModel, objectB:ObjectModel):ObjectModel
		{
			if (objectA.rightBottom[axis] <= objectB.leftTop[axis])
			{
				return objectB;
			}
			return objectA;
		}
	}
}