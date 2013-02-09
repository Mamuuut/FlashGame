package com.assetviews
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * BitmapView
	 * @author mamutdelaunay
	 */
	public class BitmapView extends ObjectView
	{
		/**
		 * Constructor
		 * @param	bitmapData
		 * @param	fillMode
		 */
		public function BitmapView(bitmapData:BitmapData, repeat:Boolean = false):void
		{
			_repeat = repeat;
			var sprite:Sprite = new Sprite();
			super(sprite);
			_bitmapData = bitmapData;
			draw();
		}
		
		/* Setters/Getters */
		override public function get width():int
		{
			return _repeat && 0 != _width ? _width : _bitmapData.width;
		}
		
		override public function get height():int
		{
			return _repeat && 0 != _height ? _height : _bitmapData.height;
		}
		
		override public function set width(width:int):void 
		{
			super.width = width;
			draw();
		}
		
		override public function set height(height:int):void 
		{
			super.height = height;
			draw();
		}
		
		/**
		 * @return the _displayObject as a Sprite
		 */
		public function get sprite():Sprite
		{
			return _displayObject as Sprite;
		}
		
		/**
		 * Draw the bitmapData in the sprite graphics
		 */
		protected function draw():void
		{
			if (null != _bitmapData)
			{
				sprite.graphics.clear();
				sprite.graphics.beginBitmapFill(_bitmapData, null, _repeat);
				sprite.graphics.drawRect(0, 0, width, height);
				sprite.graphics.endFill();
			}
		}
		
		protected var _bitmapData:BitmapData;
		protected var _repeat:Boolean = false;
	}

}