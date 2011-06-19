package com.sina.microblog.ui.utils
{
	import com.sina.microblog.core.MainController;
	import com.sina.microblog.data.MicroBlogUser;
	
	import mx.containers.Canvas;
	import mx.containers.Panel;
	import mx.events.FlexEvent;
	
	public class User extends Canvas
	{
		[Bindable]
		protected var _controller:MainController;
		
		[Bindable]
		protected var userName:String;
		[Bindable]
		protected var profileImageSource:String;
		[Bindable]
		protected var location:String;
		[Bindable]
		protected var followerNum:int;
		[Bindable]
		protected var latestStatus:String
		
		public function User():void
		{
			super()
			horizontalScrollPolicy="off";
			verticalScrollPolicy="off";
			setStyle("fontFamily", "simhei");
			setStyle("fontSize", 11);
			addEventListener(FlexEvent.DATA_CHANGE, onDataChange);
		}
		
		protected function onDataChange(event:FlexEvent):void
		{
			if(!userData)
			{
				return;
			}
			userName = userData.screenName;
			profileImageSource = userData.profileImageUrl;
			location = userData.location;
			followerNum = userData.followersCount;
			if(userData.status)
			{
				latestStatus = userData.status.text;
			}
		}
		
		public function set controller(value:MainController):void
		{
			_controller = value;
		}
		protected function get userData():MicroBlogUser
		{
			return data as MicroBlogUser;
		}
	}
}