package com.assetviews 
{
	/**
	 * IAnimation
	 * @author mamutdelaunay
	 */
	public interface IAnimation extends IObjectView
	{
		function playAnimation(animation:String, nbLoop:int = -1):void; 
		function stopAnimation():void;
		function get animationNames():Array;
	}
	
}