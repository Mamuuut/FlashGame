package com.scroller {

	import flash.geom.Point;
	import com.level.LevelController;
	import com.objects.Player;
	
	/**
	 * PlayerScroller is level scroller following the player position
	 * @author mamutdelaunay
	 */
	public class PlayerScroller extends LevelScroller {

		/**
		 * Constructor
		 * @param	level
		 */
		public function PlayerScroller(level:LevelController) {
			super(level);
		}

		/**
		 * Update the Level scroll position in order to keep the player visible
		 * @param	player
		 */
		override public function update(player:Player):void {
			super.update(player);
			var viewPlayerPos:Point = _levelView.getViewPlayerPos(player);
			var levelPlayerPos:Point = _levelView.getLevelPlayerPos(player);

			if (viewPlayerPos.x + player.view.width < LEFT_MARGIN) {
				_levelView.gameGroup.horizontalScrollPosition = levelPlayerPos.x + player.view.width - LEFT_MARGIN;
			}

			if (viewPlayerPos.x > _levelView.width - RIGHT_MARGIN) {
				_levelView.gameGroup.horizontalScrollPosition = levelPlayerPos.x + RIGHT_MARGIN - _levelView.width;
			}

			if (viewPlayerPos.y + player.view.height < TOP_MARGIN) {
				_levelView.gameGroup.verticalScrollPosition = levelPlayerPos.y + player.view.height - TOP_MARGIN;
			}

			if (viewPlayerPos.y > _levelView.height - BOTTOM_MARGIN) {
				_levelView.gameGroup.verticalScrollPosition = levelPlayerPos.y + BOTTOM_MARGIN - _levelView.height;
			}
		}

		// Private static const
		private static const TOP_MARGIN:Number = 300;
		private static const LEFT_MARGIN:Number = 400;
		private static const RIGHT_MARGIN:Number = 400;
		private static const BOTTOM_MARGIN:Number = 300;
	}
}
