package com.objects
{
	import com.level.LevelController;
	import com.objects.model.GameObjectModel;
	import com.objects.model.LinearMoveObjectModel;
	
	/**
	 * LinearMoveObject
	 * @author mamutdelaunay
	 */
	public class LinearMoveObject extends GameObject
	{
		/**
		 * Constructor
		 * @param	level
		 * @param	xmlGameObject
		 */
		public function LinearMoveObject(level:LevelController, xmlGameObject:Object)
		{
			super(level, xmlGameObject);
		}
		
		/**
		 * Create the LinearMoveObjectMOdel
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @return LinearMoveObjectMOdel
		 */
		override public function createObjectModel(x:int, y:int, width:int, height:int):GameObjectModel
		{
			var model:LinearMoveObjectModel = new LinearMoveObjectModel(x, y, width, height);
			return model;
		}
		
		/**
		 * TODO: Change this function name as it doesn't update the position only ...
		 */
		override public function updatePosition():void
		{
			super.updatePosition();
			if (model.isAlive)
			{
				if (0 != model.velocity.x)
				{
					updateXSpeed();
				}
				if (0 != model.velocity.y)
				{
					updateYSpeed();
				}
			}
		}
		
		/**
		 * Return the modal as a LinearMoveObjectModel
		 */
		public function get linearMoveObjectModel():LinearMoveObjectModel
		{
			return model as LinearMoveObjectModel;
		}
		
		/**
		 * If the object reach a limit its velocity is reversed
		 */
		protected function updateXSpeed():void
		{
			if (view.x + linearMoveObjectModel.velocity.x > linearMoveObjectModel.xMax)
			{
				view.x = linearMoveObjectModel.xMax;
				linearMoveObjectModel.velocity.x = -linearMoveObjectModel.xAnimSpeed;
			}
			else if (view.x + linearMoveObjectModel.velocity.x < linearMoveObjectModel.xMin)
			{
				view.x = linearMoveObjectModel.xMin;
				linearMoveObjectModel.velocity.x = linearMoveObjectModel.xAnimSpeed;
			}
		}
		
		/**
		 * If the object reach a limit its velocity is reversed
		 */
		protected function updateYSpeed():void
		{
			if (view.y + linearMoveObjectModel.velocity.y > linearMoveObjectModel.yMax)
			{
				view.y = linearMoveObjectModel.yMax;
				linearMoveObjectModel.velocity.y = -linearMoveObjectModel.yAnimSpeed;
			}
			else if (view.y + linearMoveObjectModel.velocity.y < linearMoveObjectModel.yMin)
			{
				view.y = linearMoveObjectModel.yMin;
				linearMoveObjectModel.velocity.y = linearMoveObjectModel.yAnimSpeed;
			}
		}
	}

}