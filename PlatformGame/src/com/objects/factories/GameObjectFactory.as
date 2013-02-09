package com.objects.factories 
{
	import com.level.LevelController;
	import com.objects.DwarfObject;
	import com.objects.ElevatorObject;
	import com.objects.ExitDoor;
	import com.objects.GameObject;
	import com.objects.GroundObject;
	import com.objects.GroundRepeatObject;
	import com.objects.LavaObject;
	import com.objects.LinearMoveObject;
	import com.objects.PickAxeObject;
	import com.objects.PinocchioObject;
	import com.objects.SnowWhiteObject;
	import com.objects.UturnTrigger;
	import com.objects.WallObject;
	import flash.utils.getDefinitionByName;
    
	/**
	 * GameObjectFactory
	 * @author mamutdelaunay
	 */
    public class GameObjectFactory 
    {   
		/**
		 * Create a GameObject according to its xml definition
		 * @param	level
		 * @param	xmlObject
		 * @return a GameObject
		 */
        public function createGameObject(level:LevelController, xmlObject:Object):GameObject
        {
            var className:String = null == xmlObject.className? DEFAULT_OBJECT_CLASS : xmlObject.className;
            var GameObjectClass:Class = getDefinitionByName(OBJECT_CLASS_PREFIX + className) as Class;
            var gameObject:GameObject = new GameObjectClass(level, xmlObject);
            return gameObject;
        }
		
		private static const DEFAULT_OBJECT_CLASS:String = "GameObject";
		private static const OBJECT_CLASS_PREFIX:String = "com.objects."
		
		/* Compiler Helpers  */
		private var __linearModeObjectForCompiler:LinearMoveObject;
		private var __uturnTriggerForCompiler:UturnTrigger;
        private var __exitDoorForCompiler:ExitDoor;
        private var __snowWhiteObjectForCompiler:SnowWhiteObject;
        private var __pickAxeObjectForCompiler:PickAxeObject;
        private var __dwarfObjectForCompiler:DwarfObject;
        private var __pinocchioObjectForCompiler:PinocchioObject;
        private var __elevatorObjectForCompiler:ElevatorObject;
        private var __wallObjectForCompiler:WallObject;
        private var __groundObjectForCompiler:GroundObject;
        private var __groundRepeatObjectForCompiler:GroundRepeatObject;
        private var __lavaObjectForCompiler:LavaObject;
    }

}