package com.assetviews 
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	/**
	 * IObjectView
	 * @author mamutdelaunay
	 */
	public interface IObjectView extends IEventDispatcher
	{
		function get displayObject():DisplayObject;
		function get width():int;
		function set width(width:int):void;
		function get height():int;
		function set height(height:int):void;
		function get x():int;
		function set x(x:int):void;
		function get y():int;
		function set y(y:int):void;
		function get xFlip():Boolean;
		function set xFlip(xFlip:Boolean):void;
		function get yFlip():Boolean;
		function set yFlip(yFlip:Boolean):void;
		function hasAnimation(animationName:String):Boolean;
	}
	
}