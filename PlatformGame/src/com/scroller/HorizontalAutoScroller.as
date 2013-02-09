package com.scroller
{
	import com.level.LevelController;
	import com.objects.Player;
	
	/**
	 * HorizontalAutoScroller
	 * Inherits from LevelScroller
	 * The level automaticly scroll to the right
	 */
	public class HorizontalAutoScroller extends LevelScroller
	{	
		/**
		 * Constructor
		 * @param	level
		 */
		public function HorizontalAutoScroller(level:LevelController)
		{
			super(level);
		}
		
		/**
		 * Increase the gameGroup horizontalScrollPosition each frame
		 * @param	player
		 */
		override public function update(player:Player):void
		{
			super.update(player);
			_levelView.gameGroup.horizontalScrollPosition += 1;
		}
	}
}
