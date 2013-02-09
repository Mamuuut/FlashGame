package com.objects.factories
{
	import com.assetviews.AssetManager;
	import com.assetviews.IAnimation;
	import com.assetviews.IObjectView;
	import com.helpers.XmlPropertiesHelper;
	import com.pinocchio.AnimationNames;
    
	/**
	 * ObjectViewFactory
	 * @author mamutdelaunay
	 */
	public class ObjectViewFactory
	{	
		/**
		 * Create an IObjectView according to its xml definition
		 * @param	xmlObject
		 * @return a IObjectView
		 */
		public function createView(xmlObject:Object):IObjectView
		{
			var view:IObjectView;
			if (null != xmlObject.animation)
			{
				view = AssetManager.instance.getAnimation(xmlObject.animation);
				(view as IAnimation).playAnimation(AnimationNames.IDLE);
			}
			else if (null != xmlObject.sprite)
			{
				view = AssetManager.instance.getSprite(xmlObject.sprite);
			}
			if (null != view)
			{
				view.width = xmlObject.width;
				view.height = xmlObject.height;
				view.xFlip = XmlPropertiesHelper.getBooleanValue(xmlObject.xFlip, false);
				view.yFlip = XmlPropertiesHelper.getBooleanValue(xmlObject.yFlip, false);
			}
			
			return view;
		}
	}
}