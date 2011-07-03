package com.sina.microblog.ui.components.call
{
	import mx.controls.ProgressBar;
	import mx.core.FlexGlobals;
	
	import spark.components.BorderContainer;

	public class LoadMaskManager
	{
		public function LoadMaskManager()
		{
		}
		public static function showMask(msg:String="Loading..."):void{
			FlexGlobals.topLevelApplication.loadMaskLayer.visible = true;
			FlexGlobals.topLevelApplication.opProgress.label = msg;
		}
		
		public static function closeMask():void{
			FlexGlobals.topLevelApplication.loadMaskLayer.visible = false;
			FlexGlobals.topLevelApplication.opProgress.label = 'Loading...';
		}
	}
}