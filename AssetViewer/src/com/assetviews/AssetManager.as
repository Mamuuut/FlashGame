package com.assetviews 
{
	import flash.display.Bitmap;
	/**
	 * AssetManager is a Singleton
	 * @author mamutdelaunay
	 */
	public final class AssetManager 
	{
		private static var _instance:AssetManager = new AssetManager();
		
        public function AssetManager()
        {
            if (_instance != null)
            {
                throw new Error("AssetManager can only be accessed through AssetManager.instance");
            }
        }
		
        public static function get instance():AssetManager
        {
            return _instance;
        }
		
		/**
		 * Initialize the AssetManager
		 * @param	animations
		 * @param	sprites
		 */
		public function initialize(animations:Object, sprites:Object):void
		
		{
			_animations = animations;
			_sprites = sprites;
		}
		
		/**
		 * @param	name
		 * @return An animation from its name
		 */
		public function getAnimation(name:String):IAnimation
		{
			return AnimationFactory.createAnimation(_animations[name]);
		}
		
		/**
		 * @param	name
		 * @return A sprite from its name
		 */
		public function getSprite(name:String):BitmapView
		{
			var bitmap:Bitmap = _sprites[name].source as Bitmap;
			var repeat:Boolean = _sprites[name].repeat as Boolean;
			return new BitmapView(bitmap.bitmapData, repeat);
		}
		
		private static var _animations:Object;
		private static var _sprites:Object;
	}

}