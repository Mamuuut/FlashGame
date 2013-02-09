package physictest.level.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import physic.controller.PhysicController;
	import physic.model.ObjectModel;
	import physic.model.QuadTree;
	import physic.model.Vector2D;
	import physictest.events.LevelEvent;
	import physictest.events.ObjectSettingsEvent;
	import physictest.events.PhysicSettingsEvent;
	import physictest.level.factory.LevelObjectFactory;
	import physictest.level.view.ObjectView;
	import physictest.view.LevelView;
	import physictest.view.QuadView;
	
	/**
	 * LevelController
	 * @author mamutdelaunay
	 */
	public class LevelContoller extends EventDispatcher
	{
		[Bindable]
		public var pause:Boolean = true;
		
		/**
		 * Constructor
		 * @param	levelView
		 */
		public function LevelContoller(levelView:LevelView)
		{	
			_view = levelView;
			_view.addEventListener(Event.ENTER_FRAME, updateLevel);
			_levelObjects = new Array();
			
			_levelObjectFactory = new LevelObjectFactory();
			_physicController = new PhysicController(_view.width, _view.height);
		}
		
		public function set drawQuadTreeEnabled(enabled:Boolean):void
		{
			if (enabled)
			{
				drawQuadTree();
			} else {
				_view.quadTreeView.removeAllElements();
			}
			_drawQuadTreeEnabled = enabled;
		}
		
		/**
		 * Reset the level
		 */
		public function clearLevel():void
		{
			pause = true;
			
			_physicController.clear();
			while (0 != _levelObjects.length)
			{
				removeObject(_levelObjects[0]);
			}
			
			_view.quadTreeView.removeAllElements();
		}
		
		/**
		 * Load a level from an Object definition
		 * @param	levelDefinition
		 */
		public function loadLevel(levelDefinition:Object):void 
		{
			clearLevel();
			_currentLevelDefinition = levelDefinition;
			gravity = levelDefinition.gravity;
			for each(var levelObjectProperties:Array in levelDefinition.objects)
			{
				addObject(_levelObjectFactory.createLevelObject(levelObjectProperties));
			}	
			drawQuadTree();
		}
		
		/**
		 * add a LevelObject to the Level
		 * @param	levelObject
		 */
		public function addObject(levelObject:LevelObject):void
		{
			_view.objectContainerView.addElement(levelObject.view);
			_physicController.addObject(levelObject.model);
			
			_levelObjects.push(levelObject);
			levelObject.updateView();
			levelObject.addEventListener(ObjectSettingsEvent.OBJECT_CLICK, objectClickHandler);
		}
		
		/**
		 * remove a LevelObject
		 * @param	levelObject
		 */
		public function removeObject(levelObject:LevelObject):void
		{
			_view.objectContainerView.removeElement(levelObject.view);
			
			_physicController.removeObject(levelObject.model);
			
			var index:int = _levelObjects.indexOf(levelObject);
			_levelObjects.splice(index, 1);
			levelObject.removeEventListener(ObjectSettingsEvent.OBJECT_CLICK, objectClickHandler);
			levelObject.dispose();
		}
		
		/**
		 * Compute the next frame physic and update the view.
		 */
		public function nextFrame():void
		{
			_physicController.updatePhysic();
			
			var objectsToRemove:Array = new Array();
			for each (var levelObject:LevelObject in _levelObjects)
			{
				levelObject.updateView();
				if (0 == levelObject.life)
				{
					objectsToRemove.push(levelObject);
				}
			}
			for each (var objectToRemove:LevelObject in objectsToRemove)
			{
				removeObject(objectToRemove);
			}
			drawQuadTree();
			dispatchEvent(new LevelEvent(LevelEvent.NEXT_FRAME));
		}
		
		/**
		 * Draw the QuadTree rects
		 */
		public function drawQuadTree():void
		{
			if (_drawQuadTreeEnabled)
			{
				_view.quadTreeView.removeAllElements();
				for each(var quadTree:QuadTree in _physicController.quadTrees)
				{
					var quadView:QuadView = new QuadView();
					quadView.width = quadTree.rect.size.x;
					quadView.height = quadTree.rect.size.y;
					quadView.x = quadTree.rect.position.x - 1;
					quadView.y = quadTree.rect.position.y - 1;
					quadView.nbObjects = quadTree.nbObjects;
					_view.quadTreeView.addElement(quadView);
				}
			}
		}
		
		/**
		 * Reload the current level
		 */
		public function reloadLevel():void 
		{
			loadLevel( _currentLevelDefinition );
		}
		
		/**
		 * Set PhysicController gravity.
		 * Dispatch a PhysicSettingsEvent with the new gravity
		 */
		public function set gravity(gravity:Vector2D):void 
		{
			if (null != gravity && PhysicController.GRAVITY != gravity)
			{
				PhysicController.GRAVITY = gravity;
				dispatchEvent(new PhysicSettingsEvent(PhysicSettingsEvent.GRAVITY_CHANGE, gravity));
			}
		}
		
		/**
		 * Add random falling object
		 */
		public function addRandomFallingObject():void
		{
			var x:int = getRandomNumber(100, 500);
			var y:int = 0;
			var width:int = getRandomNumber(1, 20);
			var height:int = getRandomNumber(1, 20);
			var model:ObjectModel = new ObjectModel(x, y, width, height);
			model.velocity = new Vector2D(getRandomNumber(-5, 5), getRandomNumber(-5, 5));
			model.collideBits = 1;
			
			var objectView:ObjectView = new ObjectView();
			objectView.color = getRandomColor();
			
			var levelObject:LevelObject = new LevelObject(objectView, model);
			levelObject.life = 100;
			addObject(levelObject);
		}
		
		/**
		 * Handle the ObjectSettingsEvent.OBJECT_CLICK from an ObjectLevel and dispatch it
		 * @param	event
		 */
		protected function objectClickHandler(event:ObjectSettingsEvent):void 
		{
			var objectEvent:ObjectSettingsEvent = new ObjectSettingsEvent(ObjectSettingsEvent.OBJECT_CLICK, event.levelObject);
			dispatchEvent(objectEvent);
		}
		
		/**
		 * Compute the level next frame if pause is not true. Called on each ENTER_FRAME event.
		 * @param	event
		 */
		protected function updateLevel(event:Event):void
		{
			if (!pause)
			{
				nextFrame();
			}
		}
		
		/**
		 * @param	min
		 * @param	max
		 * @return a random number from min to max
		 */
		protected function getRandomNumber(min:Number, max:Number):Number
		{
			return Math.round(min + (max - min) * Math.random());
		}
		
		/**
		 * @return a random color from the COLOR Array
		 */
		protected function getRandomColor():Number
		{
			return COLORS[Math.floor(getRandomNumber(0, COLORS.length))];
		}
		
		/**
		 * Random object colors
		 */
		private static const COLORS:Array = 
		[
			0xFF0000,
			0xFF8800,
			0xFFFF00,
			0x88FF00,
			0x00FF00,
			0x00FF88,
			0x00FFFF,
			0x0088FF,
			0x0000FF,
			0x8800FF,
			0xFF00FF,
			0xFF0088,
		];
		
		protected var _currentLevelDefinition:Object;
		protected var _levelObjectFactory:LevelObjectFactory;
		protected var _levelObjects:Array;
		protected var _view:LevelView;
		protected var _physicController:PhysicController;
		protected var _drawQuadTreeEnabled:Boolean = false;
	}
}