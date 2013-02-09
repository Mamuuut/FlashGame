package com.level
{
	
	import com.objects.factories.GameObjectFactory;
	import com.objects.GameObject;
	import com.scroller.ScrollerFactory;
	import flash.net.SharedObject;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import physic.controller.PhysicController;
	
	/**
	 * LevelLoader
	 * @author mamutdelaunay
	 */
	public class LevelLoader
	{
		// Public static
		public static var LEVEL_DEF:Vector.<LevelModel>;
		
		/**
		 * Constructor
		 * @param	levelController
		 */
		public function LevelLoader(levelController:LevelController)
		{
			
			_levelController = levelController;
			
			_gameObjectFactory = new GameObjectFactory();
			
			_dataService.addEventListener(ResultEvent.RESULT, onLoaded);
			_dataService.addEventListener(FaultEvent.FAULT, onFailed);
		}
		
		/**
		 * @param	levelName
		 * @return true if a level is enabled in the local SharedObject
		 */
		public static function isEnable(levelName:String):Boolean
		{
			var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_CODE);
			return null != so.data.enabledLevels ? -1 != (so.data.enabledLevels as Array).indexOf(levelName) : false;
		}
		
		/**
		 * Enable a levelModel
		 * @param	levelName
		 */
		public static function setLevelModelEnable(levelName:String):void
		{
			for each (var levelModel:LevelModel in LevelLoader.getLevels())
			{
				if (levelName == levelModel.name)
				{
					levelModel.enable = true;
				}
			}
		}
		
		/**
		 * @return the levels models
		 */
		public static function getLevels():Vector.<LevelModel>
		{
			if (null == LEVEL_DEF)
			{
				LEVEL_DEF = new Vector.<LevelModel>();
				LEVEL_DEF.push(new LevelModel("01", "Level_01", true));
				LEVEL_DEF.push(new LevelModel("02", "Level_02"));
				LEVEL_DEF.push(new LevelModel("03", "Level_03"));
				LEVEL_DEF.push(new LevelModel("04", "Level_04"));
				LEVEL_DEF.push(new LevelModel("05", "Level_05"));
				LEVEL_DEF.push(new LevelModel("06", "Level_06"));
			}
			return LEVEL_DEF;
		}
		
		/**
		 * Add an enabled level in the local SharedObject
		 * @param	levelName
		 */
		public static function addEnabledLevel(levelName:String):void
		{
			if (isEnable(levelName))
			{
				return;
			}
			setLevelModelEnable(levelName);
			var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_CODE);
			if (null == so.data.enabledLevels)
			{
				so.data.enabledLevels = new Array();
			}
			so.data.enabledLevels.push(levelName)
			so.flush();
		}
		
		/**
		 * Load a xml level from its url
		 * @param	url
		 * @param	onSuccess
		 */
		public function loadFromXml(url:String, onSuccess:Function = null):void
		{
			_onSuccess = onSuccess;
			_dataService.url = "./levelDefs/" + url + ".xml";
			_dataService.send();
		}
		
		// Private methods
		
		/**
		 * ResultEvent.RESULT listener.
		 * @param	event
		 */
		private function onLoaded(event:ResultEvent):void
		{
			var xmlLevelObject:Object = event.result.level;
			
			// Level Size
			_levelController.levelView.initializeView(xmlLevelObject);
			
			_levelController.physicController = new PhysicController(xmlLevelObject.width, xmlLevelObject.height);
			
			initScroller(xmlLevelObject);
			initObjects(xmlLevelObject.objects);
			
			_levelController.nextLevelName = xmlLevelObject.nextLevel;
			_levelController.levelTitle = xmlLevelObject.title;
			
			_onSuccess();
		}
		
		/**
		 * FaultEvent.FAULT listener. Show an alert.
		 * @param	event
		 */
		private function onFailed(event:FaultEvent):void
		{
			Alert.show("level loading failed:\n" + event.message);
		}
		
		/**
		 * Create and add the game objects in the level
		 * @param	objects
		 */
		private function initObjects(objects:Object):void
		{
			for each (var xmlGameObject:Object in objects.object)
			{
				var object:GameObject = _gameObjectFactory.createGameObject(_levelController, xmlGameObject);
				_levelController.addObject(object);
				if (true == xmlGameObject.scrollerObject)
				{
					_levelController.levelScroller.addObject(object)
				}
			}
		}
		
		/**
		 * Create the levelScroller from its xml description
		 * @param	xmlLevelObject
		 */
		private function initScroller(xmlLevelObject:Object):void
		{
			_levelController.levelScroller = ScrollerFactory.createScroller(_levelController, xmlLevelObject.scroller);
		}
		
		// Protected attributes
		protected var _gameObjectFactory:GameObjectFactory;
		protected var _levelController:LevelController;
		protected var _onSuccess:Function;
		protected var _dataService:HTTPService = new HTTPService();
		
		// Private static const
		private static const SHARED_OBJECT_CODE:String = "mamutgame";
	}
}
