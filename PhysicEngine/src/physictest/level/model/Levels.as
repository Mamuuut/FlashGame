package physictest.level.model 
{
	import physic.model.Vector2D;
	
	/**
	 * LevelDefinition
	 * Object properties Array :
		 * width
		 * height
		 * position x
		 * position y
		 * velocity x
		 * velocity y
		 * color
		 * mass
		 * collideBits
		 * kineticFriction
	 * @author mamutdelaunay
	 */
	public class Levels 
	{
		/**
		 * Object collision test.
		 * Collision with mutliple objects on 2 differents horizontale lines.
		 * The gravity is null;
		 */
		public static const COLLISION_TEST:Object = 
		{
			gravity: new Vector2D(0, 0),
			objects: [
				[20, 20,  20, 20, 4, 0, 0xFF0000],
				[20, 20,  40, 41, 6, 0, 0xFFFF00],
				[20, 20, 220, 30, 0, 0, 0x00FF00],
				[20, 20, 320, 30, -12, 0, 0x00FFFF],
				
				[20, 20,  20, 80, 0, 0, 0xFF0000, int.MAX_VALUE],
				[20, 20, 120, 80, 4, 0, 0xFFFF00, 2],
				[20, 20, 220, 80, 0, 0, 0x00FF00],
				[20, 20, 320, 80, -4, 0, 0x00FFFF],
				[20, 20, 420, 80, -20, 0, 0x0000FF, 2]
			]
		};
		
		/**
		 * Gravity test.
		 * 3 objects falling on the floor.
		 */
		public static const GRAVITY_TEST:Object = 
		{
			gravity: new Vector2D(0, 3),
			objects: [
				[596, 20,   0, 400, 0,   0, 0xFFFFFF, int.MAX_VALUE],
				[ 20, 20, 100, 200, 0,   0, 0xFF0000],
				[100, 20, 100, 150, 0, -50, 0xFFFF00],
				[ 20, 20, 180,   0, 0,   0, 0x00FF00]
			]
		};
		
		/**
		 * 3 frictions test.
		 * - The first object has a null kinetic friction coefficient and is only subject to air friction.
		 * - The second object has a kinetic friction coefficient equal to 0.1.
		 * - The third object has the same kinetic friction coefficient 
		 * but is thrown in the air before colliding with the ground.
		 */
		public static const FRICTION_TEST:Object = 
		{
			gravity: new Vector2D(0, 3),
			objects: [
				[596, 20, 0, 100,  0, 0, 0xFFFFFF, int.MAX_VALUE],
				[ 20, 20, 0,  80, 20, 0, 0xFF0000],
				[596, 20, 0, 250,  0, 0, 0xFFFFFF, int.MAX_VALUE],
				[ 20, 20, 0, 230, 20, 0, 0xFFFF00, 1, 1, 0.1],
				[596, 20, 0, 400,  0, 0, 0xFFFFFF, int.MAX_VALUE],
				[ 20, 20, 0, 300, 20, 0, 0x00FF00, 1, 1, 0.1]
			]
		};
		
		/**
		 * Ground for objects randomly falling from the sky
		 */
		public static const RANDOM_SHOWER_TEST:Object = 
		{
			gravity: new Vector2D(0, 3),
			objects: [
				[10, 598,   0, 0,  0, 0, 0xFFFFFF, int.MAX_VALUE],
				[10, 598, 588, 0,  0, 0, 0xFFFFFF, int.MAX_VALUE],
			]
		};
	}

}