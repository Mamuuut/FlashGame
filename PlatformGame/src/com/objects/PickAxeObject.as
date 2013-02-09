package com.objects 
{
	import com.level.LevelController;
	import com.objects.actions.KillAction;
	
	/**
	 * PickAxeObject
     * @author mamutdelaunay
     */
	public class PickAxeObject extends ThrownObject
	{
		/**
		 * Constructor
		 * @param	throwingObject
		 * @param	level
		 */
		public function PickAxeObject(throwingObject:GameObject, level:LevelController)
		{
			var xmlGameObject:Object = new Object();
			xmlGameObject.animation = "pick_axe";
			super(throwingObject, level, xmlGameObject);
		}
	}

}