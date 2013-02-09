package com.assetviews
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * SpriteSheet
	 * @author mamutdelaunay
	 */
	public class SpriteSheet
	{
		/**
		 * Constructor
		 * @param	bitmap
		 */
		public function SpriteSheet(bitmap:Bitmap, animations:Array)
		{
			_bitmap = bitmap;
			_animations = new Dictionary();
			initializeAnimations(animations);
		}
		
		/* Getters/Setters */
		public function getNbFrames(animation:String):int 
		{
			return _animations[animation].length;
		}
		
		/**
		 * @param	index
		 * @return
		 */
		public function getBitmapData(animation:String, index:int):BitmapData
		{
			var frame:BitmapFrame = _animations[animation][index];
			
			var height:int = _bitmap.height;
			var charrect:Rectangle = new Rectangle(frame.x, 0, frame.width, height);
			var basepoint:Point = new Point(0, 0);
			
			var bitmapData:BitmapData = new BitmapData(frame.width, height);
			bitmapData.copyPixels(_bitmap.bitmapData, charrect, basepoint);
			
			return bitmapData;
		}
		
		public function get animationNames():Array 
		{
			return _animationNames;
		}
		
		/**
		 * @param	animation
		 * @param	index
		 * @return the animation frame period
		 */
		public function getFrame(animation:String, index:int):BitmapFrame
		{
			return _animations[animation][index];
		}
		
		/**
		 * @param	animations
		 */
		protected function initializeAnimations(animations:Array):void 
		{
			var x:int = 0;
			_animationNames = new Array();
			
			for each(var animation:Object in animations)
			{
				var frames:Array = new Array();
				for (var i:int = 0; i < animation.nbFrames; i++)
				{
					var width:int = animation.widths[i % animation.widths.length];
					var period:int = animation.periods[i % animation.periods.length];
					frames.push(new BitmapFrame(x, width, period));
					
					x += width;
				}
				_animations[animation.name] = frames;
				_animationNames.push(animation.name);
			}
		}
		
		protected var _bitmap:Bitmap;
		protected var _animations:Dictionary;
		protected var _animationNames:Array;
	}

}