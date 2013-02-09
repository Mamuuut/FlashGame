package physic.model 
{
	/**
	 * Rect
	 * @author mamutdelaunay
	 */
	public class Rect 
	{
		public static const LEFT_TOP:String = "leftTop"; // Left or Top
		public static const RIGHT_BOTTOM:String = "rightBottom"; // Right or Bottom
		
		public var position:Vector2D;
		public var size:Vector2D;
		
		/**
		 * Constructor
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 */
		public function Rect(x:Number, y:Number, width:Number, height:Number) 
		{
			position = new Vector2D(x, y);
			size = new Vector2D(width, height);
		}
		
		/**
		 * @param	axis
		 * @return the left top Vector2D rectangle corner
		 */
		public function get leftTop():Vector2D
		{
			return position;
		}

		/**
		 * @param	axis
		 * @return the right bottom Vector2D rectangle corner
		 */
		public function get rightBottom():Vector2D
		{
			return position.add(size);
		}
		
		public function intersects(rect:Rect):Boolean
		{
			return !(rect.leftTop[Vector2D.X_AXIS] >= rightBottom[Vector2D.X_AXIS] || 
				rect.rightBottom[Vector2D.X_AXIS] <= leftTop[Vector2D.X_AXIS] || 
				rect.leftTop[Vector2D.Y_AXIS] >= rightBottom[Vector2D.Y_AXIS] ||
				rect.rightBottom[Vector2D.Y_AXIS] <= leftTop[Vector2D.Y_AXIS]);
		}
	}
}