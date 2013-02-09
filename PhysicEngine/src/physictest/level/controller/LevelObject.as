package physictest.level.controller
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	import physic.events.PhysicEvent;
	import physic.model.ObjectModel;
	import physictest.events.ObjectSettingsEvent;
	import physictest.level.view.ObjectView;
	
	/**
	 * LevelObject associates the physic ObjectModel to the ObjectView
	 * @author mamutdelaunay
	 */
	public class LevelObject extends EventDispatcher
	{
		/**
		 * LevelObject dataFormat for the DragManager
		 */
		public static const DRAG_FORMAT:String = "levelObject";
		
		/**
		 * Constructor
		 * @param	view
		 * @param	model
		 */
		public function LevelObject(view:ObjectView, model:ObjectModel)
		{
			_view = view;
			_model = model;
			
			initializeEventListeners();
		}
		
		/**
		 * Remove references
		 */
		public function dispose():void
		{
            _view.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            _view.removeEventListener(MouseEvent.CLICK, objectClickHandler);
			_model.removeEventListener(PhysicEvent.COLLIDE, onCollide);
			_model.dispose();
		}
		
		/**
		 * Getters
		 */
		public function get model():ObjectModel
		{
			return _model;
		}
		
		public function get view():ObjectView
		{
			return _view;
		}
		
		public function set life(life:int):void 
		{
			_life = life;
		}
		
		public function get life():int 
		{
			return _life;
		}
		
		/**
		 * Set the object center position
		 * @param	x
		 * @param	y
		 */
        public function setCenterPosition(x:Number, y:Number):void
        {
            _model.position.x = x - _model.size.x / 2;
            _model.position.y = y - _model.size.y / 2;
			updateView();
        }
        
		/**
		 * Update the ObjectView from the ObjectModel properties
		 */
		public function updateView():void
		{
			if ( -1 != life)
			{
				life--;
			}
			_view.x = _model.position.x;
			_view.y = _model.position.y;
			_view.width = _model.size.x;
			_view.height = _model.size.y;
		}
		
		/**
		 * Initialize the event listeners
		 */
		protected function initializeEventListeners():void 
		{
            _view.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
            _view.addEventListener(MouseEvent.CLICK, objectClickHandler, false, 0, true);
			_model.addEventListener(PhysicEvent.COLLIDE, onCollide, false, 0, true);
		}
		
		/**
		 * Handler of the ObjectModel PhysicEvent.COLLIDE event.
		 * @param	event
		 */
		protected function onCollide(event:PhysicEvent):void 
		{
			//_view.alpha -= 0.25;
		}
        
		/**
		 * Handler of the ObjectView MouseEvent.CLICK event.
		 * @param	event
		 */
		protected function objectClickHandler(event:MouseEvent):void
		{
			var objectEvent:ObjectSettingsEvent = new ObjectSettingsEvent(ObjectSettingsEvent.OBJECT_CLICK, this);
			dispatchEvent(objectEvent);
		}
		
		/**
		 * Handler of the ObjectView MouseEvent.MOUSE_MOVE event.
		 * @param	event
		 */
        protected function mouseMoveHandler(event:MouseEvent):void 
        {                
            var dragInitiator:ObjectView = ObjectView(event.currentTarget);
            var ds:DragSource = new DragSource();
            ds.addData(LevelObject(this), LevelObject.DRAG_FORMAT);               

            DragManager.doDrag(dragInitiator, ds, event);
        }
		
		protected var _life:int = -1;
		protected var _view:ObjectView;
		protected var _model:ObjectModel;
	}

}