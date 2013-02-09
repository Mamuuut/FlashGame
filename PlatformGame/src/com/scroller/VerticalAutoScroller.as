package com.scroller
{
	import com.helpers.XmlPropertiesHelper;
	import com.level.LevelController;
	import com.objects.GameObject;
	import com.objects.LavaObject;
	import com.objects.Player;
	
	/**
	 * VerticalAutoScroller
     * @author mamutdelaunay
     */
	public class VerticalAutoScroller extends PlayerScroller
	{
		/**
		 * Constructor
		 * @param	level
		 */
		public function VerticalAutoScroller(level:LevelController)
		{
			super(level);
		}
		
		/**
		 * Initialize vertical auto scroller specific attributes from xml description.
		 * @param	xmlObject
		 */
        override public function initXmlProperties(xmlObject:Object):void {
            super.initXmlProperties(xmlObject);
            
            _scrollSpeed = XmlPropertiesHelper.getNumberValue(xmlObject.scrollSpeed, _scrollSpeed);
            _maxVerticalScrollPosition = _startScrollY;
        }
        
		/**
		 * Update the gameGroup vertical scroll position and the associated objects position
		 * @param	player
		 */
		override public function update(player:Player):void
		{
			super.update(player);
            _maxVerticalScrollPosition = Math.max(0, _maxVerticalScrollPosition - _scrollSpeed);
			_levelView.gameGroup.verticalScrollPosition = Math.min(_maxVerticalScrollPosition, _levelView.gameGroup.verticalScrollPosition);
			for each(var object:GameObject in _objects)
			{
				object.model.position.y = _maxVerticalScrollPosition + _levelView.height - object.model.size.y - BOTTOM_MARGIN;
			}
		}
		
		// Protected attributes
        protected var _scrollSpeed:int = 1;
        protected var _maxVerticalScrollPosition:Number;
        
		// Private static const
        private static const BOTTOM_MARGIN:int = 80;
	}
}
