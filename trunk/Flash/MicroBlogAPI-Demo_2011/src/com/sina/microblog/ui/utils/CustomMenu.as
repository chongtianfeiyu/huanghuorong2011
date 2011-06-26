package com.sina.microblog.ui.utils
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.events.FlexEvent;
	
	public class CustomMenu extends Canvas
	{
		private var container:VBox = new VBox();
		private var _ifFold:Boolean;
		public function CustomMenu()
		{
			super();
			clipContent = false;
			addEventListener(FlexEvent.CREATION_COMPLETE, this_onCreationComplete);
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
			container.verticalScrollPolicy = "off";
			container.setStyle("verticalGap", 0);
			//container.setStyle("backgroundColor", 0x000000);
			container.setStyle("horizontalAlign", "center");
			super.addChild(container);
		}
		
		
		override protected function initializationComplete() : void
		{
			super.initializationComplete();
			addEventListener(MouseEvent.CLICK, onClick);
			BindingUtils.bindProperty(this, "height", titleChild, "height");
		}
		
		override public function addChild(child:DisplayObject) : DisplayObject
		{
			return container.addChild(child);
		}
		
		private function this_onCreationComplete(event:FlexEvent):void
		{
			fold();
		}
		
		private function onClick(event:MouseEvent):void
		{
			if(_ifFold)
			{
				unFold();
			}
			else
			{
				fold();
			}
		}
		
		public function fold():void
		{
			_ifFold = true;
			container.height = titleChild.height;
		}
		
		public function unFold():void
		{
			_ifFold = false;
			container.height = undefined;
		}
		
		private function get titleChild():DisplayObject
		{
			return container.getChildAt(0);
		}
	}
}