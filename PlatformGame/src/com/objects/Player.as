package com.objects
{
	import com.commands.CommandEvent;
	import com.commands.PlayerCommands;
	import com.events.GameEvent;
	import com.events.ObjectEvent;
	import com.helpers.RelativePositionHelper;
	import com.level.LevelController;
	import com.objects.actions.KillAction;
	import com.objects.GameObject;
	import com.objects.model.CollideBits;
	import com.objects.model.GameObjectModel;
	import com.objects.model.PlayerModel;
	import com.pinocchio.AnimationNames;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import physic.events.PhysicEvent;
	import physic.model.Vector2D;
	
	/**
	 * Player
     * @author mamutdelaunay
     */
	public class Player extends GameObject
	{
		public var isJumpImpulseOn:Boolean = false;
		public var jumpImpulseStartTime:Number;
	
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function Player(level:LevelController, xmlGameObject:Object)
		{
            xmlGameObject.mass = 1;
            xmlGameObject.preyBits = 1;
            xmlGameObject.collideBits = CollideBits.DECOR_PLAYER;
            
			super(level, xmlGameObject);
			
            _jumpTimer = new Timer(MAX_JUMP_IMPULSE_TIME);
			_playerCommands = new PlayerCommands(level.commandManager, this);
            model.addEventListener(GameEvent.LEVEL_COMPLETE, _level.onLevelComplete, false, 0, true);
			
            level.player = this;
		}
		
		/**
		 * Create a PlayerModel model
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @return PlayerModel
		 */
		override public function createObjectModel(x:int, y:int, width:int, height:int):GameObjectModel
		{
			var model:PlayerModel = new PlayerModel(x, y, width, height);
			return model;
		}
		
		/**
		 * return the model as a PlayerModel
		 */
		protected function get playerModel():PlayerModel
		{
			return model as PlayerModel;
		}
		
		/**
		 * Blow fire from the player
		 * @param	event
		 */
		public function fire(event:CommandEvent):void
		{	
			var fire:GameObject = new FireObject(_level);
			fire.model.position.x = RelativePositionHelper.getXPos(this, fire.view.width, 0);
			fire.model.position.y = RelativePositionHelper.getYPos(this, fire.view.height, -10);
			fire.addAction(new KillAction());
			fire.view.xFlip = view.xFlip;
			
			_level.addObject(fire);
		}
		
		/**
		 * Start the jump impulse
		 * @param	event
		 */
        public function startJumpImpulse(event:CommandEvent):void 
        {
            if (!isJumpImpulseOn && 0 < playerModel.nbJumpLeft)
            {
                jumpImpulseStartTime = new Date().time;
                _jumpTimer.reset();
                _jumpTimer.start();
                _jumpTimer.addEventListener(TimerEvent.TIMER, stopJumpImpulse, false, 0, true);
                isJumpImpulseOn = true;
            }
        }
		
        /**
         * Stop the jump impulse
         * @param	event
         */
        public function stopJumpImpulse(event:Event):void
        {
            if ( isJumpImpulseOn )
            {
                _jumpTimer.removeEventListener(TimerEvent.TIMER, stopJumpImpulse);
                _jumpTimer.stop();
                isJumpImpulseOn = false;
                playerModel.nbJumpLeft--;
            }
        }
		
		/**
		 * Add a jump impulse force during a maxing time when the jump command is active
		 */
		public function addJumpImpulse():void
		{
            model.addForce(new Vector2D(0, -JUMP_POWER));
            if (0 != model.contacts.x.rightBottom.length)
            {
                model.addForce(new Vector2D(-WALL_JUMP_POWER, -JUMP_POWER));
            }
            else if (0 != model.contacts.x.leftTop.length)
            {
                model.addForce(new Vector2D(WALL_JUMP_POWER, -JUMP_POWER));
            }
		}
		
		/**
		 * Update the player animations
		 */
		override public function updateView():void
		{
			super.updateView();
			if (model.isAlive)
			{
				if (0 == model.contacts.y.rightBottom.length)
				{
					playAnimation(AnimationNames.JUMP);
				}
				else if (0 == model.velocity.x)
				{
					playAnimation(AnimationNames.IDLE);
				}
				else if (Math.abs(model.velocity.x) < 10)
				{
					playAnimation(AnimationNames.WALK);
				}
				else
				{
					playAnimation(AnimationNames.RUN);
				}
			}
		}
		
		/**
		 * Update forces from right/left commands
		 */
		public function updateVelocityFromCommands():void
		{
			if (model.isAlive)
			{
				if (_playerCommands.isGoingLeft())
				{
					model.addForce(new Vector2D(-COMMAND_FORCE, 0));
				}
				if (_playerCommands.isGoingRight())
				{
					model.addForce(new Vector2D(COMMAND_FORCE, 0));
				}
                if (isJumpImpulseOn)
                {
                    addJumpImpulse();
                }
			}
		}
		
		/**
		 * ESCAPE command action
		 * @param	event
		 */
		public function onEscape(event:CommandEvent):void
		{
			_level.stop();
		}
		
		/**
		 * COLLIDE event handler
		 * @param	event
		 */
		override protected function onCollide(event:PhysicEvent):void
		{
			super.onCollide(event);
			playerModel.nbJumpLeft = MAX_NB_JUMPS;
		}
		
		/**
		 * PAUSE command action
		 * @param	event
		 */
		public function pause(event:CommandEvent):void
		{
            _level.switchPause();
		}
		
		/**
		 * Remove references
		 */
		override public function dispose():void
		{
			_level.playerDead = true;
			_playerCommands.removeCommands();
			_playerCommands = null;
			model.removeEventListener(GameEvent.LEVEL_COMPLETE, _level.onLevelComplete);
			super.dispose();
		}
		
		/**
		 * Player death
		 * @param	event
		 */
		override public function die(event:ObjectEvent = null):void
		{
            _level.pause = false;
			super.die(event);
			_playerCommands.removeCommands();
		}
		
		protected var _playerCommands:PlayerCommands;
		protected var _jumpTimer:Timer;
		
		private static const MAX_NB_JUMPS:int = 2;
		private static const JUMP_POWER:int = 8;
		private static const WALL_JUMP_POWER:int = 20;
		private static const MAX_JUMP_IMPULSE_TIME:int = 100;
		private static const COMMAND_FORCE:int = 4;
	}

}