package physic.model
{
	/**
     * The AxisContacts represents the differents contact Objects on a specific axis (x or y).
     * @author mamutdelaunay
     */
	public class AxisContacts
	{   
        /**
         * leftTop represents the contact Objects on the left or top.
         */
		public var leftTop:Array;
        /**
         * leftTop represents the contact Objects on the right or bottom.
         */
		public var rightBottom:Array;
		
        /**
         * Constructor
         */
		public function AxisContacts()
		{
			leftTop = new Array();
			rightBottom = new Array();
		}
		
        /**
         * This method add a contact Object on the min or max position (left/right or top/bottom)
         * @param object The contact object
         * @param position The position of the object on the axis (left/right or top/bottom)
         */
		public function addContact(object:ObjectModel, position:String):void
		{
			this[position].push(object);
		}
	}

}