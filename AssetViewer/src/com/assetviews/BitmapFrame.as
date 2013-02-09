package com.assetviews 
{
	/**
	 * BitmapFrame
	 * @author mamutdelaunay
	 */
	public class BitmapFrame 
	{
		public var period:int;
		public var x:int;
		public var width:int;
		
		/**
		 * Constructor
		 * @param	x
		 * @param	width
		 * @param	period
		 */
		public function BitmapFrame(x:int, width: int, period:int)
		{
			this.x = x;
			this.width = width;
			this.period = period;
		}
	}

}