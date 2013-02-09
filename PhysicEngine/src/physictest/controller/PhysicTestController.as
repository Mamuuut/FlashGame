package physictest.controller 
{
	import physic.model.QuadTree;
	import physictest.events.LevelEvent;
	import physictest.events.ObjectSettingsEvent;
	import physictest.events.PhysicSettingsEvent;
	import physictest.level.controller.LevelContoller;
	import physictest.level.model.Levels;
	import physictest.view.LevelView;
	import physictest.view.ObjectSettings;
	import physictest.view.PhysicSettings;
	
	/**
	 * PhysicTestController
	 * @author mamutdelaunay
	 */
	public class PhysicTestController 
	{		
		
		[Bindable]
		public var levelController:LevelContoller;
		
		/**
		 * Constructor
		 * @param	levelView
		 * @param	physicSettings view
		 * @param	objectSettings view
		 */
		public function PhysicTestController(levelView:LevelView, physicSettings:PhysicSettings, objectSettings:ObjectSettings) 
		{
			QuadTree.MAX_OBJECTS_PER_QUAD = 5;
			
			_objectSettings = objectSettings;
			_objectSettings.initializeFromLevelView(levelView);
			
			_physicSettings = physicSettings;
			_physicSettings.addEventListener(PhysicSettingsEvent.APPLY_GRAVITY, onApplyPhysic);
			
			levelController = new LevelContoller(levelView);
			levelController.addEventListener(ObjectSettingsEvent.OBJECT_CLICK, onObjectClick);
			levelController.addEventListener(PhysicSettingsEvent.GRAVITY_CHANGE, onGravityChange);
			levelController.addEventListener(LevelEvent.NEXT_FRAME, onNextFrame);
			
			loadGravityLevel();
		}
		
		/* Level controls */
		public function play():void
		{
			levelController.pause = false;
		}
		
		public function pause():void
		{
			levelController.pause = true;
		}
		
		public function nextFrame():void
		{
			levelController.nextFrame();
		}
		
		public function stop():void
		{
			_objectSettings.clearObject();
			levelController.reloadLevel();
		}
		
		/* Levels loading */
		public function loadCollisionLevel():void
		{
			levelController.loadLevel(Levels.COLLISION_TEST);
			_randomShowerActive = false;
		}
		
		public function loadGravityLevel():void
		{
			levelController.loadLevel(Levels.GRAVITY_TEST);
			_randomShowerActive = false;
		}
		
		public function loadFrictionLevel():void
		{
			levelController.loadLevel(Levels.FRICTION_TEST);
			_randomShowerActive = false;
		}
		
		public function loadRandomShowerLevel():void
		{
			levelController.loadLevel(Levels.RANDOM_SHOWER_TEST);
			_randomShowerActive = true;
		}
		
		public function setDrawQuadTreeEnabled(enabled:Boolean):void 
		{
			levelController.drawQuadTreeEnabled = enabled;
		}
		
		/* Event Handlers */
		protected function onObjectClick(event:ObjectSettingsEvent):void 
		{
			_objectSettings.updateFromObject(event.levelObject);
		}
			
		protected function onApplyPhysic(event:PhysicSettingsEvent):void 
		{
			levelController.gravity = event.gravity;
		}
			
		protected function onGravityChange(event:PhysicSettingsEvent):void 
		{
			_physicSettings.gravity = event.gravity;
		}
		
		protected function onNextFrame(event:LevelEvent):void 
		{
			if (_randomShowerActive)
			{
				if (MAX_ELAPSED_FRAMES == _elapsedFrames)
				{
					levelController.addRandomFallingObject();
					_elapsedFrames = 0;
				}
				_elapsedFrames++;
			}
		}
		
		private static const MAX_ELAPSED_FRAMES:int = 1;
		
		/**
		 * PhysicTest setting views
		 */
		protected var _objectSettings:ObjectSettings;
		protected var _physicSettings:PhysicSettings;
		protected var _elapsedFrames:int = 0;
		protected var _randomShowerActive:Boolean = false;
	}

}