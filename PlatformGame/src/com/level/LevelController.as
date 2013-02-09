package com.level
{
	import com.commands.CommandManager;
	import com.events.GameEvent;
	import com.helpers.AnalyticsHelper;
	import com.objects.GameObject;
	import com.objects.Player;
	import com.scroller.ILevelScroller;
	import com.view.LevelView;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import physic.controller.PhysicController;
	
	/**
	 * LevelController
	 * @author mamutdelaunay
	 */
	public class LevelController extends EventDispatcher
	{
		// Public properties
		public var nextLevelName:String;
		public var levelTitle:String
		public var playerDead:Boolean = true;
		public var physicController:PhysicController;
		
		/**
		 * Constructor
		 * @param	levelView
		 * @param	stage
		 */
		public function LevelController(levelView:LevelView, stage:Stage)
		{			
			_levelLoader = new LevelLoader(this)
			_commandManager = new CommandManager(stage);
			
			_levelView = levelView;
		}
		
		/* Setters, Getters */
		public function get gameObjects():Vector.<GameObject>
		{
			return _gameObjects;
		}
		
		public function get levelView():LevelView
		{
			return _levelView;
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function set player(player:Player):void
		{
			_player = player;
			playerDead = false;
		}
		
		public function get commandManager():CommandManager
		{
			return _commandManager;
		}
		
		public function set levelScroller(scroller:ILevelScroller):void
		{
			_levelScroller = scroller;
		}
		
		public function get levelScroller():ILevelScroller
		{
			return _levelScroller;
		}
		
		/**
		 * Start the level 
		 */
		public function start():void 
		{
            _levelView.addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Stop the level
		 */
		public function stop():void 
		{
			clearLevel();
			dispatchEvent(new GameEvent(GameEvent.GAME_MENU));
		}
		
		/**
		 * Update the level if loaded, ready an not paused
		 * @param	evt
		 */
		protected function update(evt:Event = null):void
		{
			if (!_pause && !checkPlayerDeath() && !checkLevelEnd())
			{
				_player.updateVelocityFromCommands();
				physicController.updatePhysic();
				updateObjectsView();
				_levelScroller.update(_player);
				
				if (_levelScroller.isPlayerOutOfBounds(player))
				{
					gameOver();
				}
				
				updateRemovedObject();
			}
		}
		
		/**
		 * Load a level
		 * @param	levelName
		 */
		public function load(levelName:String):void
		{
			AnalyticsHelper.trackEvent(AnalyticsHelper.ACTIONS.loadLevel, levelName);
            LevelLoader.addEnabledLevel(levelName);
            
			_levelName = levelName;
			_levelCompleted = false;
			
			_gameObjects = new Vector.<GameObject>();
			levelView.clearView();
			
			_levelLoader.loadFromXml(levelName, onLevelLoaded);
		}
		
		/**
		 * Add a game object to the level
		 * @param	gameObject
		 */
		public function addObject(gameObject:GameObject):void
		{
			_gameObjects.push(gameObject);
			physicController.addObject(gameObject.model);
			if (null != gameObject.view)
			{
				levelView.addObjectView(gameObject.view);
			}
		}
		
		/**
		 * Remove 
		 * @param	gameObject
		 */
		public function removeObject(gameObject:GameObject):void
		{
			if (null != gameObject.model)
			{
				physicController.removeObject(gameObject.model);
			}
			if (null != gameObject.view)
			{
				levelView.removeObjectView(gameObject.view);
			}
			gameObject.dispose();
			_gameObjects.splice(_gameObjects.indexOf(gameObject), 1);
		}
		
		/**
		 * Clear the level
		 */
		public function clearLevel():void
		{
			physicController.clear();
            _levelView.removeEventListener(Event.ENTER_FRAME, update);
			while (0 != _gameObjects.length)
			{
				var gameObject:GameObject = _gameObjects[0] as GameObject;
				removeObject(gameObject);
			}
		}
		
		/**
		 * The player is dead, the game is over
		 */
		public function gameOver():void
		{
			clearLevel();
			dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
		}
        
		/**
		 * Pause the game engine
		 */
        public function set pause(value:Boolean):void {
            _pause = value;
            if (_pause)
            {
                dispatchEvent(new GameEvent(GameEvent.GAME_PAUSE));
            }
            else
            {
                dispatchEvent(new GameEvent(GameEvent.GAME_PLAY));   
            }
        }
		
		/**
		 * Switch the pause state
		 */
        public function switchPause():void
        {
            pause = !_pause;
        }
		
		/**
		 * Load the next level
		 */
		public function loadNextLevel():void
		{
			if (null != nextLevelName)
			{
				load(nextLevelName);
			}
			else
			{
				dispatchEvent(new GameEvent(GameEvent.GAME_COMPLETE));
			}
		}
		
		/**
		 * Reload the current level
		 */
		public function reload():void
		{
			load(_levelName);
		}
		
		/* Game Events */
		
		/**
		 * LEVEL_COMPLETE event handler
		 * @param	event
		 */
		public function onLevelComplete(event:GameEvent):void
		{
			_levelCompleted = true;
		}
		
		/**
		 * loadFromXml callback
		 */
		protected function onLevelLoaded():void
		{
			dispatchEvent(new GameEvent(GameEvent.LEVEL_LOADED));
		}
		
		/**
		 * Update the object views
		 */
		protected function updateObjectsView():void
		{
			for each (var gameObject:GameObject in gameObjects)
			{
				if (null != gameObject.view)
				{
					gameObject.updatePosition();
					gameObject.updateView();
				}
			}
		}
		
		/**
		 * Remove objects with removeFlag set to true
		 */
		protected function updateRemovedObject():void
		{
			var objectsToRemove:Vector.<GameObject> = new Vector.<GameObject>();
			for each (var gameObject:GameObject in gameObjects)
			{
				if (gameObject.removeFlag)
				{
					objectsToRemove.push(gameObject);
				}
			}
			for each (var objectToRemove:GameObject in objectsToRemove)
			{
				removeObject(objectToRemove);
			}
		}
		
		/**
		 * Check if the level has been completed
		 * @return
		 */
		private function checkLevelEnd():Boolean
		{
			if (_levelCompleted)
			{
				clearLevel();
				dispatchEvent(new GameEvent(GameEvent.LEVEL_COMPLETE));
				return true;
			}
			return false;
		}
		
		/**
		 * Check if the player died
		 * @return
		 */
		private function checkPlayerDeath():Boolean
		{
			if (playerDead)
			{
				gameOver();
			}
			return playerDead;
		}
		
		private var _commandManager:CommandManager;
		
		private var _levelName:String;
		private var _levelLoader:LevelLoader;
		private var _levelScroller:ILevelScroller;
		
		private var _gameObjects:Vector.<GameObject>;
		private var _player:Player;
		private var _levelCompleted:Boolean = false;
        private var _pause:Boolean = false;
		
		private var _levelView:LevelView;
	}
}
