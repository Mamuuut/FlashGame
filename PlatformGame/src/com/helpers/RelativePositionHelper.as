package com.helpers 
{
	import com.assetviews.IObjectView;
	import com.objects.GameObject;
	
	/**
	 * RelativePositionHelper 
	 * @author mamutdelaunay
	 */
	public class RelativePositionHelper 
	{
		// Public static methods
		
		/**
		 * @param	gameObject
		 * @param	targetWidth
		 * @param	offset
		 * @return the x position of an object relative to the gameObject and its direction (left or right)
 		 */
		public static function getXPos(gameObject:GameObject, targetWidth:Number, offset:Number):Number {
			if (!gameObject.view.xFlip) {
				return gameObject.model.rightBottom.x + offset;
			} else {
				return gameObject.model.leftTop.x - offset - targetWidth;
			}
		}
		
		/**
		 * @param	gameObject
		 * @param	targetHeight
		 * @param	offset
		 * @return the y position of an object relative to the gameObject
		 */
		public static function getYPos(gameObject:GameObject, targetHeight:Number, offset:Number):Number {
			return gameObject.model.rightBottom.y - targetHeight + offset;
		}
	}

}