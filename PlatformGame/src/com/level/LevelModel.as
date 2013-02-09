package com.level
{
	import spark.components.Button;
	
	/**
	 * LevelModel
	 * @author mamutdelaunay
	 */
	public class LevelModel
	{
		// Public properties
		public var name:String;
		public var code:String;
		public var enable:Boolean = false;
		public var button:Button;
		
		/**
		 * Constructor
		 * @param	code
		 * @param	name
		 * @param	enable
		 */
		public function LevelModel(code:String, name:String, enable:Boolean = false)
		{
			this.code = code;
			this.name = name;
			this.enable = enable;
		}
	}
}