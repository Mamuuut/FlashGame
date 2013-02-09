package com.commands
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
    import com.objects.Player;
	
	/**
	 * PlayerCommands
	 * @author mamutdelaunay
	 */
	public class PlayerCommands
	{
		/**
		 * Constructor
		 * @param	commandManager
		 * @param	player
		 */
		public function PlayerCommands(commandManager:CommandManager, player:Player)
		{
			_player = player;
			_commandManager = commandManager;
			
			_commands = new Vector.<Command>();
			
			// Add the player commands
			_commands.push(new Command(commandManager, Keyboard.SPACE, CommandEvent.KEY_RELEASED, player.fire));
			_commands.push(new Command(commandManager, Keyboard.UP, CommandEvent.KEY_PRESSED, player.startJumpImpulse));
			_commands.push(new Command(commandManager, Keyboard.UP, CommandEvent.KEY_RELEASED, player.stopJumpImpulse));
            _commands.push(new Command(commandManager, Keyboard.ESCAPE, CommandEvent.KEY_PRESSED, player.onEscape));
            _commands.push(new Command(commandManager, CommandManager.KEY_P, CommandEvent.KEY_PRESSED, player.pause))
		}
		
		// Public methods
		
		/**
		 * Remove the player commands
		 */
		public function removeCommands():void {
			for each(var command:Command in _commands) {
				command.remove();
				command = null;
			}
		}
		
		/**
		 * @return true if the LEFT key is pressed but not the RIGHT one
		 */
		public function isGoingLeft():Boolean {
			return _commandManager.isKeyDown(Keyboard.LEFT) && !_commandManager.isKeyDown(Keyboard.RIGHT);
		}
		
		
		/**
		 * @return true if the RIGHT key is pressed but not the LEFT one
		 */
		public function isGoingRight():Boolean {
			return _commandManager.isKeyDown(Keyboard.RIGHT) && !_commandManager.isKeyDown(Keyboard.LEFT);
		}
		
		// Private members
		private var _player:Player;
		private var _commands:Vector.<Command>;
		private var _commandManager:CommandManager;
	
	}

}