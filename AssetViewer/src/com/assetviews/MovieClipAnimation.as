package com.assetviews 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * MovieClipAnimation
	 * @author mamutdelaunay
	 */
	public class MovieClipAnimation extends ObjectView implements IAnimation
	{
		/**
		 * Constructor
		 * @param	clip
		 */
		public function MovieClipAnimation(clip:MovieClip, animations:Array):void
		{
			_animation = animations;
			super(clip);
			movieClip.visible = false;
			movieClip.gotoAndStop(0);
			clip.addEventListener("loop", onLoop);
		}
		
		/**
		 * Play an animation
		 * @param	animation
		 * @param 	nbLoop
		 */
		public function playAnimation(animation:String, nbLoop:int = -1):void 
		{
			_nbLoop = nbLoop;
			movieClip.gotoAndPlay(animation);
			_movieClipWidth = movieClip.width;
			_movieClipHeight = movieClip.height;
			movieClip.visible = true;
		}
		
		/**
		 * Stop the current animation
		 */
		public function stopAnimation():void
		{
			movieClip.removeEventListener("loop", onLoop);
			movieClip.stop();
		}
		
		/**
		 * @param	animationName
		 * @return true if the object has an animation called animationName
		 */
		override public function hasAnimation(animationName:String):Boolean 
		{
			return -1 != _animation.indexOf(animationName);
		}
		
		/* Getters/Setters */
		public function get animationNames():Array 
		{
			return _animation;
		}
		
		override public function get width():int
		{
			return 0 != _width ? _width : movieClip.width;
		}
		
		override public function get height():int
		{
			return 0 != _height ? _height : movieClip.height;
		}
		
		/**
		 * @return the _displayObject as a MovieClip
		 */
		public function get movieClip():MovieClip
		{
			return _displayObject as MovieClip;
		}
		
		/**
		 * loop event listener
		 * @param	event
		 */
		protected function onLoop(event:Event):void
		{
			_nbLoop--;
			if (0 == _nbLoop)
			{
				movieClip.stop();
				dispatchEvent(new Event(LOOP_END));
			}
			else
			{
				movieClip.gotoAndPlay(movieClip.currentLabel);
			}
		}
		
		/**
		 * update the view according to the xFlip and yFlip properties
		 */
		override protected function updateView():void
		{
			var scaleX:Number = width / _movieClipWidth;
			var scaleY:Number = height / _movieClipHeight;
			_displayObject.scaleX = xFlip ? -scaleX : scaleX;
			_displayObject.x = xFlip ? x + width : x;
			_displayObject.scaleY = yFlip ? -scaleY : scaleY;
			_displayObject.y = yFlip ? y + height : y;
		}
		
		protected var _movieClipWidth:int;
		protected var _movieClipHeight:int;
		protected var _animation:Array;
		protected var _nbLoop:int = -1;
	}
}