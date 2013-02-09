package com.scroller 
{
	import com.objects.GameObject;
    import com.objects.Player;
    
	/**
	 * LevelScroller interface
	 */
    public interface ILevelScroller 
    {	
		function update(player:Player):void;
        function isPlayerOutOfBounds(player:Player):Boolean;
		function addObject(object:GameObject):void;
    }
}