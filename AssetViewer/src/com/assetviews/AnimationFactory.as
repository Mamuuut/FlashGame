package com.assetviews 
{
	/**
	 * AnimationFactory
	 * @author mamutdelaunay
	 */
	public class AnimationFactory 
	{
		/**
		 * @param	animationDef
		 * @return a new IAnimation from its definition
		 */
		public static function createAnimation(animationDef:Object):IAnimation
		{
			if (null != animationDef.movieClip)
			{
				return createMovieClipAnimation(animationDef);
			}
			else if (null != animationDef.spriteSheet)
			{
				return createBitmapAnimation(animationDef);
			}
			return null;
		}
		
		/**
		 * @param	animationDef
		 * @return a new MovieClipAnimaiton from its definition
		 */
		private static function createMovieClipAnimation(animationDef:Object):MovieClipAnimation
		{
			return new MovieClipAnimation(animationDef.movieClip, animationDef.animations);
		}
		
		/**
		 * @param	animationDef
		 * @return a new SpriteAnimaiton from its definition
		 */
		private static function createBitmapAnimation(animationDef:Object):BitmapAnimation
		{
			return new BitmapAnimation(animationDef.spriteSheet, animationDef.repeat);
		}
	}

}