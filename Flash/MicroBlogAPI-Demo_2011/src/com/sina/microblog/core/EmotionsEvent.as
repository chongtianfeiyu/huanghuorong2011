package com.sina.microblog.core
{
	import flash.events.Event;

	public class EmotionsEvent extends Event
	{
		public var info:*;
		
		public function EmotionsEvent($type:String, $info:*=null, $bubbles:Boolean=false, $cancelable:Boolean=false)
		{
			//TODO: implement function
			super($type, $bubbles, $cancelable);
			info = $info;
		}
		
		override public function clone():Event
		{
			return new EmotionsEvent(type, info, bubbles, cancelable);
		}		
	}
}