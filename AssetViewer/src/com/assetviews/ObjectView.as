package com.assetviews
{
	/**
	 * ObjectView
     * @author Mamut
     */
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
    
	public class ObjectView extends EventDispatcher implements IObjectView
	{
		public static const LOOP_END:String = "loop_end";
		
		/**
		 * Constructor
		 * @param	displayObject
		 */
		public function ObjectView(displayObject:DisplayObject):void 
		{
			_displayObject = displayObject;
		}
		
		/**
		 * @param	animationName
		 * @return true if the object has an animation called animationName
		 */
		public function hasAnimation(animationName:String):Boolean 
		{
			return false;
		}
		
		/* Getters/Setters */
		public function get x():int 
		{
			return _x;
		}
		
		public function set x(x:int):void 
		{
			if (_x != x)
			{
				_x = x;
				updateView();
			}
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function set y(y:int):void 
		{
			if (_y != y)
			{
				_y = y;
				updateView();	
			}
		}
		public function get width():int 
		{
			return _width;
		}
		
		public function set width(width:int):void 
		{
			if (_width != width)
			{
				_width = width;
				updateView();
			}
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function set height(height:int):void 
		{
			if (_height != height)
			{
				_height = height;
				updateView();
			}
		}
		
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		public function set xFlip(xFlip:Boolean):void
		{
			if (_xFlip != xFlip)
			{
				_xFlip = xFlip;
				updateView();
			}
		}
		
		public function get xFlip():Boolean 
		{
			return _xFlip;
		}
		
		public function set yFlip(yFlip:Boolean):void
		{
			if (_yFlip != yFlip)
			{
				_yFlip = yFlip;
				updateView();
			}
		}
		
		public function get yFlip():Boolean 
		{
			return _yFlip;
		}
		
		/* Update the view according to the xFlip and yFlip */
		protected function updateView():void
		{
			_displayObject.scaleX = xFlip ? -1 : 1;
			_displayObject.x = xFlip ? x + width : x;
			_displayObject.scaleY = yFlip ? -1 : 1;
			_displayObject.y = yFlip ? y + height : y;
		}
		
		protected var _x:int = 0;
		protected var _y:int = 0;
		protected var _width:int = 0;
		protected var _height:int = 0;
		protected var _xFlip:Boolean = false;
		protected var _yFlip:Boolean = false;
		
		protected var _displayObject:DisplayObject;
		
		private static const REVERT_ANGLE:int = 180;
	}

}