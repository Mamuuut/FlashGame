package physic.model 
{
	import flash.geom.Point;
    /**
    * The Vector2D describe a 2 dimensions vector with x and y coordinates.
    * @author mamutdelaunay
    */
	public class Vector2D
	{
		public static const X_AXIS:String = "x";
		public static const Y_AXIS:String = "y";
		
		public var x:Number = 0;
		public var y:Number = 0;
		
		/**
		 * @param axis
		 * @return the orthogonal axis
		 */
		public static function getOrthogonalAxis(axis:String):String 
		{
			return axis == X_AXIS ? Y_AXIS : X_AXIS;
		}
		
        /**
         * Constructor
         * @param x Horizontal coordinate of the vector.
         * @param y Vertical coordinate of the vector.
         */
		public function Vector2D(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function add(v:Vector2D):Vector2D
		{
			return new Vector2D(x + v.x, y + v.y);
		}
		
        /**
         * This method set the x and y parameters from a string.
         * The string must be "[x];[y]" with [x] and [y] as int values.
         * This method is usefull to initialize Vector2D object from an XML file.
         * @param	string
         */
		public function fromString(string:String):void
		{
			if (null != string)
			{
				var vector:Array = string.split(';');
				if (2 == vector.length)
				{
					x = parseFloat(vector[0]);
					y = parseFloat(vector[1]);
				}
			}
		}
	}

}