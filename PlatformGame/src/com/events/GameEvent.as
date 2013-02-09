package com.events 
{
    import flash.events.Event;
	
	/**
	 * GameEvent
	 * @author mamutdelaunay
	 */
    public class GameEvent extends Event
    {
		// GameEvent types
        public static const START:String = "start";
        public static const GAME_OVER:String = "gameOver";
        public static const LEVEL_LOADED:String = "levelLoaded";
        public static const LEVEL_COMPLETE:String = "levelComplete";
        public static const GAME_COMPLETE:String = "gameComplete";
        public static const GAME_PAUSE:String = "gamePause";
        public static const GAME_PLAY:String = "gamePlay";
        public static const GAME_MENU:String = "gameMenu";
        
		public var level:String;
		
		/**
		 * Constructor
		 * @param	type
		 * @param	level
		 */
        public function GameEvent(type:String, level:String = null) 
		{
			super(type);
			this.level = level;
		}
        
    }

}