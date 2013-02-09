package com.assetviews 
{
	import flash.events.Event;
	
	/**
	 * BitmapAnimation
	 * @author mamutdelaunay
	 */
	public class BitmapAnimation extends BitmapView implements IAnimation
	{		
		/**
		 * Constructor
		 * @param	clip
		 */
		public function BitmapAnimation(spriteSheet:SpriteSheet, repeat:Boolean = false):void
		{
			_spriteSheet = spriteSheet;
			super(null, repeat);
		}
		
		/* Getters/Setters */
		public function get animationNames():Array 
		{
			return _spriteSheet.animationNames;
		}
		
		/**
		 * @param	animationName
		 * @return true if the object has an animation called animationName
		 */
		override public function hasAnimation(animationName:String):Boolean 
		{
			return -1 != _spriteSheet.animationNames.indexOf(animationName);
		}
		
		/**
		 * Play an animation
		 * @param	animation
		 * @param 	nbLoop
		 */
		public function playAnimation(animation:String, nbLoop:int = -1):void 
		{
			if (-1 != nbLoop || _animation != animation)
			{
				stopAnimation();
				sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				_animation = animation;
				_nbLoop = nbLoop;
				_animationIndex = 0;
				_frameIndex = 1;
				updateAnimation();
			}
		}
		
		/**
		 * Stop the current animation
		 */
		public function stopAnimation():void
		{
			sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (null != _bitmapData)
			{
				_bitmapData.dispose();
				_bitmapData = null;
			}
			_animation = null;
		}
		
		/**
		 * enterFrame event handler
		 */
		protected function onEnterFrame(event:Event):void
		{
			if (null != _animation && 0 != _nbLoop)
			{
				if (_frameIndex == _currentFrame.period)
				{
					_animationIndex++;
					var needUpdate:Boolean = true;
					if (_animationIndex == _spriteSheet.getNbFrames(_animation))
					{
						needUpdate = loop();
					}
					if (needUpdate)
					{
						updateAnimation();
						_frameIndex = 1;	
					}
				}
				else
				{
					_frameIndex++;
				}
			}
		}
		
		/**
		 * loop animation if needed
		 */
		protected function loop():Boolean 
		{
			_nbLoop--;
			if (0 == _nbLoop)
			{
				dispatchEvent(new Event(LOOP_END));
				return false;
			}
			else
			{
				_animationIndex = 0;
				return true;
			}
		}
		
		/**
		 * Update animation
		 */
		protected function updateAnimation():void
		{
			_bitmapData = _spriteSheet.getBitmapData(_animation, _animationIndex);
			_currentFrame = _spriteSheet.getFrame(_animation, _animationIndex);
			draw();
		}
		
		protected var _nbLoop:int = -1;
		protected var _currentFrame:BitmapFrame;
		protected var _animation:String;
		protected var _animationIndex:int;
		protected var _frameIndex:int;
		protected var _spriteSheet:SpriteSheet;
	}

}