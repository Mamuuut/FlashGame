package com.scroller
{
	import com.helpers.XmlPropertiesHelper;
	import com.level.LevelController;
	import com.objects.GameObject;
	import com.objects.Player;
	import com.view.LevelView;
	import flash.geom.Point;
	
	/**
	 * LevelScroller
	 * @author mamutdelaunay
	 */
	public class LevelScroller implements ILevelScroller
	{
		/**
		 * Constructor
		 * @param	level
		 */
		public function LevelScroller(level:LevelController)
		{
			_levelView = level.levelView;
			_objects = new Vector.<GameObject>();
		}
		
		/**
		 * Initialize attributes from xml description
		 * @param	xmlObject
		 */
		public function initXmlProperties(xmlObject:Object):void
		{
			_startScrollX = XmlPropertiesHelper.getNumberValue(xmlObject.scrollX, 0);
			_startScrollY = XmlPropertiesHelper.getNumberValue(xmlObject.scrollY, 0);
		}
		
		/**
		 * Add an object scrolling with the Level
		 * @param	object
		 */
		public function addObject(object:GameObject):void
		{
			_objects.push(object);
		}
		
		/**
		 * Update the Level scroll position from the player position
		 * @param	player
		 */
		public function update(player:Player):void
		{
			if (!_scrollInitialized)
			{
				_scrollInitialized = true;
				
				_levelView.gameGroup.horizontalScrollPosition = _startScrollX;
				_levelView.gameGroup.verticalScrollPosition = _startScrollY;
			}
		}
		
		/**
		 * @param	player
		 * @return true if the player went out of the scroll view bounds
		 */
		public function isPlayerOutOfBounds(player:Player):Boolean
		{
			var viewPlayerPos:Point = _levelView.getViewPlayerPos(player);
			
			var isOutLeft:Boolean = viewPlayerPos.x + player.view.width < 0;
			var isOutRight:Boolean = viewPlayerPos.x > _levelView.width;
			var isOutTop:Boolean = viewPlayerPos.y + player.view.height < 0;
			var isOutBottom:Boolean = viewPlayerPos.y > _levelView.height;
			
			return isOutLeft || isOutRight || isOutTop || isOutBottom;
		}
		
		// Protected attributes
		protected var _levelView:LevelView;
		protected var _scrollInitialized:Boolean = false;
		protected var _objects:Vector.<GameObject>;
		protected var _startScrollX:Number;
		protected var _startScrollY:Number;
	}
}
