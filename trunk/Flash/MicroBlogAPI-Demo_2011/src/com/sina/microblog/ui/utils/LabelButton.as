package com.sina.microblog.ui.utils
{
	import flash.events.MouseEvent;
	
	import mx.controls.Label;

	public class LabelButton extends Label
	{
		private var _fontColor:String = "0x002aff";
		public function LabelButton()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER, this_onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, this_onRollOut);
			
			buttonMode = true;
			mouseChildren = false;
		}
		
		override protected function initializationComplete():void
		{
			super.initializationComplete();
			setStyle("color", _fontColor);
		}
		
		private function this_onRollOver(event:MouseEvent):void
		{
		}
		private function this_onRollOut(event:MouseEvent):void
		{
		}
		
		public function set fontColor(value:String):void
		{
			_fontColor = value;
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
		}
	}
}