package com.objects
{
	import com.events.ObjectEvent;
	import com.level.LevelController;
	import com.objects.actions.KillAction;
	import com.objects.model.CollideBits;
	import com.objects.model.DwarfModel;
	import com.objects.model.GameObjectModel;
	import com.objects.model.PredatorBits;
	import com.pinocchio.AnimationNames;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * DwarfObject
     * @author mamutdelaunay
     */
	public class DwarfObject extends GameObject
	{
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function DwarfObject(level:LevelController, xmlGameObject:Object)
		{
			xmlGameObject.mass = 1;
			xmlGameObject.animation = "dwarf";
			xmlGameObject.predatorBits = PredatorBits.ENEMY_PLAYER;
			xmlGameObject.preyBits = PredatorBits.PLAYER_ENEMY;
			xmlGameObject.collideBits = CollideBits.DECOR_ENEMY;
			xmlGameObject.velocity = "6;0";
			xmlGameObject.burningVelocity = "12;0";
			
			super(level, xmlGameObject);
			
			addAction(new KillAction());
			
			_timer = new Timer(RELOAD_TIME);
			_timer.addEventListener(TimerEvent.TIMER, onThrow, false, 0, true);
			_timer.start();
		}
		
		/**
		 * Clean the _timer references
		 */
		override public function dispose():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onThrow);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onBurningEnd);
			_timer = null;
			
			super.dispose();
		}
		
		/**
		 * Create the DwarfModel
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @return a GameObjectModel
		 */
		override public function createObjectModel(x:int, y:int, width:int, height:int):GameObjectModel
		{
			var model:DwarfModel = new DwarfModel(x, y, width, height);
			return model;
		}
		
		/**
		 * When the Dwarf start burning, he runs before dying for real
		 * @param	event
		 */
		override public function die(event:ObjectEvent = null):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onThrow);
			_timer = new Timer(BURNING_TIME, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onBurningEnd, false, 0, true);
			_timer.start();
			
			model.velocity.x = view.xFlip ? -dwarfModel.burningVelocity.x : dwarfModel.burningVelocity.x;
			model.preyBits = 0;
			playAnimation(AnimationNames.BURN);
		}
		
		/**
		 * The Dwarf dies after burning
		 * @param	event
		 */
		protected function onBurningEnd(event:TimerEvent):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onThrow);
			super.die();
		}
		
		/**
		 * Return the model as a DwarfModel
		 */
		protected function get dwarfModel():DwarfModel
		{
			return model as DwarfModel;
		}
				
		/**
		 * Throw a PickAxeObject
		 * @param	event
		 */
		protected function onThrow(event:TimerEvent):void
		{
			if (model && model.isAlive)
			{
				_level.addObject(new PickAxeObject(this, _level));
			}
		}
		
		protected var _timer:Timer;
		
		private static const RELOAD_TIME:int = 800;
		private static const BURNING_TIME:int = 2000;
	}

}