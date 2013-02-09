package physic.model 
{
	
    /**
     * The Contacts represents the differents contact Objects on a both axis (x and y).
     * @author mamutdelaunay
     */
	public class Contacts
	{
		public var x:AxisContacts;
		public var y:AxisContacts;
		
        /**
         * Constructor
         */
		public function Contacts()
		{
			clear();
		}
		
        /**
         * Reset axis contacts on x and y axis
         */
		public function clear():void 
		{
			x = new AxisContacts();
			y = new AxisContacts();
		}
		
        /**
         * Add a contact object on a specific axis and position
         * x axis_min -> left
         * x axis_max -> right
         * y axis_min -> top
         * y axis_max -> bottom
         * @param	object The contact object
         * @param	axis The contact axis (x or y)
         * @param	position The contact position on the axis (axis_min or axis_max)
         */
		public function addContact(object:ObjectModel, axis:String, position:String):void
		{
            getObjects(axis, position).push(object);
		}
		
        /**
         * Check if there a contact on a specific axis
         * @param	axis The axis to check
         * @return true if there is a contact on the axis
         */
		public function hasContact(axis:String):Boolean
		{
			return 0 != this[axis].axis_min.length || 0 != this[axis].axis_max.length;
		}
		
        /**
         * Return the contact Object array for a specific axis and position
         * @param	axis
         * @param	position
         * @return a contact Object array
         */
		public function getObjects(axis:String, position:String):Array
		{
			return getAxisContacts(axis)[position];
		}
		
        /**
         * Return the AxisContact for a specific axis
         * @param	axis
         * @return an AxisContact
         */
		public function getAxisContacts(axis:String):AxisContacts
		{
			return this[axis];
		}
	}

}