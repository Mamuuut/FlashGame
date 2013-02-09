
package com.objects
{
	import com.assetviews.IAnimation;
	import com.assetviews.IObjectView;
	import com.assetviews.ObjectView;
	import com.events.ObjectEvent;
	import com.level.LevelController;
	import com.objects.actions.IAction;
	import com.objects.factories.ObjectViewFactory;
	import com.objects.model.CollideBits;
	import com.objects.model.GameObjectModel;
	import com.pinocchio.AnimationNames;
	import flash.events.EventDispatcher;
	import physic.events.PhysicEvent;
	
	/**
	 * GameObject controls a view and a model of an object in the level
	 * @author mamutdelaunay
	 */
	public class GameObject extends EventDispatcher
	{
		public var removeFlag:Boolean = false;
		
		/**
		 * Constructor
		 * @param	level The LevelController
		 * @param	xmlGameObject The xml description of the GameObject
		 */
		public function GameObject(level:LevelController, xmlGameObject:Object)
		{
			_level = level;
			_actions = new Vector.<IAction>();
			
			var x:int = xmlGameObject.x;
			var y:int = xmlGameObject.y;
			var width:int = xmlGameObject.width;
			var height:int = xmlGameObject.height;
			_objectModel = createObjectModel(x, y, width, height);
			_objectModel.initPropertiesFromXml(xmlGameObject);
			
			var viewFactory:ObjectViewFactory = new ObjectViewFactory();
			_objectView = viewFactory.createView(xmlGameObject);
			
			_objectModel.addEventListener(PhysicEvent.COLLIDE, onCollide, false, 0, true);
			_objectModel.addEventListener(PhysicEvent.INTERSECT, onIntersect, false, 0, true);
			_objectModel.addEventListener(ObjectEvent.DYING, die, false, 0, true);
			
			_objectModel.isAlive = true;
		}
		
		/**
		 * Create the GameObjectModel
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @return GameObjectModel
		 */
		public function createObjectModel(x:int, y:int, width:int, height:int):GameObjectModel
		{
			var model:GameObjectModel = new GameObjectModel(x, y, width, height);
			return model;
		}
		
		/**
		 * Remove the references
		 */
		public function dispose():void
		{
			_objectModel.removeEventListener(PhysicEvent.COLLIDE, onCollide);
			_objectModel.removeEventListener(PhysicEvent.INTERSECT, onIntersect);
			_objectModel.removeEventListener(ObjectEvent.DYING, die);
			_objectModel.clearContacts();
			_objectModel.dispose();
			_objectModel = null;
			
			if (_objectView is IAnimation)
			{
				_objectView.removeEventListener(ObjectView.LOOP_END, onRemoved);
				(_objectView as IAnimation).stopAnimation();
			}
			_objectView = null;
			
			_level = null;
		}
		
		/**
		 * Update the view according to the model
		 */
		public function updateView():void
		{
			_objectModel.size.x = _objectView.width;
			_objectModel.size.y = _objectView.height;
			
			if (Math.round(model.velocity.x) < 0)
			{
				_objectView.xFlip = true;
			}
			else if (Math.round(model.velocity.x) > 0)
			{
				_objectView.xFlip = false;
			}
		}
		
		/**
		 * Play an animation if possible for the view
		 * @param	animationName
		 * @param	nbLoop
		 */
		public function playAnimation(animationName:String, nbLoop:int = -1):void
		{
			if (view.hasAnimation(animationName))
			{
				(view as IAnimation).playAnimation(animationName, nbLoop);
			}
		}
		
		/**
		 * Update the view position according to the model
		 */
		public function updatePosition():void
		{
			_objectView.x = _objectModel.position.x;
			_objectView.y = _objectModel.position.y;
		}
		
		/* getset */
		public function get view():IObjectView
		{
			return _objectView;
		}
		
		public function get model():GameObjectModel
		{
			return _objectModel;
		}
		
		/* Actions */
		
		/**
		 * Add an action to be executed when this object intersects with another one.
		 * @param	action
		 */
		public function addAction(action:IAction):void 
		{
			_actions.push(action);
		}
				
		/**
		 * Executed the action accepted by the targeted object
		 * @param	gameObject
		 */
		public function applyActions(gameObjectModel:GameObjectModel):void
		{
			for each(var action:IAction in _actions)
			{
				if (action.acceptsObject(model, gameObjectModel))
				{
					action.execute(model, gameObjectModel);
				}
			}
		}
		
		/**
		 * Manage Object death
		 * @param	event
		 */
		public function die(event:ObjectEvent = null):void
		{
            _objectModel.collideBits = _objectModel.collideBits & CollideBits.DEATH_MASK;
			_objectModel.isAlive = false;
			_objectModel.velocity.x = 0;
			_objectModel.velocity.y = 0;
            _objectModel.preyBits = 0;
			
			if (_objectView.hasAnimation(AnimationNames.DEATH))
			{
				_objectView.addEventListener(ObjectView.LOOP_END, onRemoved, false, 0, true);
				playAnimation(AnimationNames.DEATH, 1);
			}
			else 
			{
				onRemoved();
			}
		}
		
		/**
		 * Set removeFlag to true so that the LevelController will remove this instance from the level
		 * @param	event
		 */
		protected function onRemoved(event:* = null):void
		{	
			removeFlag = true;
		}
		
		/**
		 * COLLIDE event handler
		 * @param	event
		 */
		protected function onCollide(event:PhysicEvent):void
		{
			// Abstract
		}
		
		/**
		 * INTERSECT event handler
		 * @param	event
		 */
		protected function onIntersect(event:PhysicEvent):void
		{
			applyActions(event.object as GameObjectModel);
		}
		
		protected var _objectModel:GameObjectModel;
		protected var _objectView:IObjectView;
		
		protected var _level:LevelController;
		protected var _actions:Vector.<IAction>;
	}
}
