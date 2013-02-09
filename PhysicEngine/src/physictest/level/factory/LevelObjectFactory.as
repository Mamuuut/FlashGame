package physictest.level.factory 
{
	import physictest.level.controller.LevelObject;
	import physictest.level.view.ObjectView;
	import physic.model.ObjectModel;
	import physic.model.Vector2D;
	
	/**
	 * LevelObjectFactory
	 * @author mamutdelaunay
	 */
	public class LevelObjectFactory 
	{	
		/**
		 * @param	objectProperties is an array with the following properties:
			 * width
			 * height
			 * position x
			 * position y
			 * velocity x
			 * velocity y
			 * color
			 * mass
			 * collideBits
			 * kineticFriction
		 * @return a LevelObject from view and model properties
		 */
		public function createLevelObject(objectProperties:Array):LevelObject 
		{
			var model:ObjectModel = new ObjectModel(objectProperties[2], objectProperties[3], objectProperties[0], objectProperties[1]);
			model.velocity = new Vector2D(objectProperties[4], objectProperties[5]);
			model.mass = objectProperties[7] || model.mass;
			model.collideBits = objectProperties[8] || 1;
			model.defaultKineticFrictionCoefficient = objectProperties[9] || model.defaultKineticFrictionCoefficient;
			
			var view:ObjectView = new ObjectView();
			view.color = objectProperties[6] || view.color;
			
			return new LevelObject(view, model);
		}
	}
}