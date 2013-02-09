package com.objects.model 
{
	import physic.model.ObjectModel;
	/**
	 * PlayerModel
	 * @author mamutdelaunay
	 */
    public class PlayerModel extends GameObjectModel
    {	
		public var nbJumpLeft:Number = 0;    
		
        /**
         * Constructor
         */
		public function PlayerModel(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height);
		}    
		
		override protected function getKineticFrictionCoefficient(object:ObjectModel):Number
		{
			return 0.2;
		}
		
		override protected function getStaticFrictionCoefficient(object:ObjectModel):Number
		{
			return 0.3;
		}
	}

}