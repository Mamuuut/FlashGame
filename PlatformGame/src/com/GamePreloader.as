package com
{
	import com.assetviews.AssetManager;
	import com.assetviews.IAnimation;
	import com.pinocchio.AnimationNames;
	import com.pinocchio.AssetsDef;
	import com.pinocchio.GameLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import mx.events.FlexEvent;
	import mx.preloaders.IPreloaderDisplay;
	
	/**
	 * GamePreloader
	 */
	public class GamePreloader extends Sprite implements IPreloaderDisplay
	{
		public function GamePreloader()
		{
			super();
		}
		
		public function set preloader(preloader:Sprite):void
		{
			_preloader = preloader;
			_preloader.addEventListener(FlexEvent.INIT_COMPLETE, handleInitComplete);
			_preloader.addEventListener(ProgressEvent.PROGRESS, handleProgress);
		}
		
		public function initialize():void
		{			
			AssetManager.instance.initialize(AssetsDef.ANIMATIONS, AssetsDef.SPRITES);
			
			// Get "game_loader" animation instance and play walk animation
			_gameLoaderAnimation = AssetManager.instance.getAnimation("game_loader");
			_gameLoaderAnimation.playAnimation(AnimationNames.WALK);
			addChild(_gameLoaderAnimation.displayObject);
			
			// Center loading animation
			_gameLoaderAnimation.x = stage.stageWidth / 2 - _gameLoaderAnimation.width / 2;
			_gameLoaderAnimation.y = stage.stageHeight / 2 - _gameLoaderAnimation.height / 2;
		}
				
		/**
		 * PROGRESS event handler
		 * @param	event
		 */
		protected function handleProgress(event:ProgressEvent):void
		{
			var progressRatio:Number = Math.round(event.bytesLoaded / event.bytesTotal * 100);
			var gameLoader:GameLoader = _gameLoaderAnimation.displayObject as GameLoader;
			gameLoader.updateText(progressRatio + " %");
		}
		
		/**
		 * INIT_COMPLETE event handler
		 * @param	event
		 */
		protected function handleInitComplete(event:Event):void
		{
			_preloader.removeEventListener(FlexEvent.INIT_COMPLETE, handleInitComplete);
			_preloader.removeEventListener(ProgressEvent.PROGRESS, handleProgress);
			_gameLoaderAnimation.stopAnimation();
			removeChild(_gameLoaderAnimation.displayObject);
			_gameLoaderAnimation = null;
			visible = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get backgroundColor():uint
		{
			return 0;
		}
		
		public function set backgroundColor(value:uint):void
		{
		}
		
		public function get backgroundAlpha():Number
		{
			return 0;
		}
		
		public function set backgroundAlpha(value:Number):void
		{
		}
		
		public function get backgroundImage():Object
		{
			return null;
		}
		
		public function set backgroundImage(value:Object):void
		{
		}
		
		public function get backgroundSize():String
		{
			return "";
		}
		
		public function set backgroundSize(value:String):void
		{
		}
		
		public function get stageWidth():Number
		{
			return 0;
		}
		
		public function set stageWidth(value:Number):void
		{
		}
		
		public function get stageHeight():Number
		{
			return 0;
		}
		
		public function set stageHeight(value:Number):void
		{
		}
	
		protected var _gameLoaderAnimation:IAnimation;
		protected var _preloader:Sprite;
	}

}