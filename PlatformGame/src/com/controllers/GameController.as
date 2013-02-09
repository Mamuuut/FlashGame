package com.controllers
{
	import com.events.GameEvent;
	import com.level.LevelController;
	import com.view.GameView;
	import flash.display.Stage;
	
	/**
	 * GameController
	 * @author mamutdelaunay
	 */
	public class GameController
	{
		/**
		 * Constructor
		 * @param	gameView
		 * @param	stage
		 */
		public function GameController(gameView:GameView, stage:Stage):void
		{
            _view = gameView;
            _level = new LevelController(gameView.levelView, stage);
			
			// Display the Intro screen
            _view.messageScreen.setBitmapScreen(pinonochioBmp, START_DURATION_MS, showMenuScreen);
            
			// Set the event listeners
            _view.menuScreen.addEventListener(GameEvent.START, onLoadLevel);
            
            _level.addEventListener(GameEvent.GAME_COMPLETE, gameEnd);
            _level.addEventListener(GameEvent.GAME_OVER, gameOver);
			_level.addEventListener(GameEvent.GAME_MENU, gameMenu);
            _level.addEventListener(GameEvent.GAME_PAUSE, gamePause);
            _level.addEventListener(GameEvent.GAME_PLAY, gamePlay);
            _level.addEventListener(GameEvent.LEVEL_LOADED, levelLoaded);
            _level.addEventListener(GameEvent.LEVEL_COMPLETE, levelCompleted);
		}

		// Protected methods
		
		/**
		 * GameEvent.START listener
		 * Load the event level or FIRST_LEVEL if level is null
		 * @param	event
		 */
		protected function onLoadLevel(event:GameEvent):void {
			if ( null != event.level )
			{
				loadLevel(event.level);
			}
			else
			{
				loadLevel(FIRST_LEVEL);
			}
		}
		
		/**
		 * Load a level
		 * @param	levelName
		 */
        protected function loadLevel(levelName:String):void {
            _level.load(levelName);
        }
        
		/**
		 * GameEvent.LEVEL_LOADED listener
		 * Display the level message screen before starting the level
		 * @param	event
		 */
        protected function levelLoaded(event:GameEvent):void {
			_view.menuScreen.visible = false;
            _view.messageScreen.setMessageScreen(_level.levelTitle, MSG_DURATION_MS, _level.start);
        }
        
		/**
		 * GameEvent.GAME_COMPLETE listener
		 * Display the game end message screen before displaying the game menu
		 * @param	event
		 */
        protected function gameEnd(event:GameEvent):void {
            _view.messageScreen.setMessageScreen(GAME_END_MSG, END_DURATION_MS, showMenuScreen);
        }
        
		/**
		 * Display the game menu
		 */
        protected function showMenuScreen():void 
		{
            _view.menuScreen.show();
        }
                
		/**
		 * GameEvent.GAME_OVER listener
		 * Reload the current level after displaying the game over message screen
		 * @param	event
		 */
        protected function gameOver(event:GameEvent):void 
		{
            _view.messageScreen.setMessageScreen(GAME_OVER_MSG, MSG_DURATION_MS, _level.reload);
        }
        
		/**
		 * GameEvent.GAME_PAUSE listener
		 * Display the pause screen
		 * @param	event
		 */
        protected function gamePause(event:GameEvent):void 
		{
            _view.pauseScreen.visible = true;
        }
        
		/**
		 * GameEvent.GAME_MENU listener
		 * Display the game menu
		 * @param	event
		 */
        protected function gameMenu(event:GameEvent):void 
		{
            _view.pauseScreen.visible = false;
			showMenuScreen();
        }
        
		/**
		 * GameEvent.GAME_PLAY listener
		 * Hide the pause screen
		 * @param	event
		 */
        protected function gamePlay(event:GameEvent):void 
		{
            _view.pauseScreen.visible = false;
        }
        
		/**
		 * GameEvent.LEVEL_COMPLETE listener
		 * Load the next level
		 * @param	event
		 */
        protected function levelCompleted(event:GameEvent):void 
		{
            _level.loadNextLevel();
        }
        
		// Protected members
        protected var _level:LevelController;
        protected var _view:GameView;
        
        // Protected const
        protected const FIRST_LEVEL:String = "Level_01";
        protected const START_DURATION_MS:int = 3000;
        protected const MSG_DURATION_MS:int = 1000;
        protected const END_DURATION_MS:int = 3000;
        protected const GAME_END_MSG:String = "The End ...";
        protected const GAME_OVER_MSG:String = "Game Over";
        
		// Intro image
		[Embed(source="../assets/pinnochio.gif")]
		[Bindable]
		protected var pinonochioBmp:Class;
	
	}

}