package com.sina.microblog.core.vo
{
	import com.sina.microblog.data.MicroBlogUser;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class MainData
	{
		public var loginData:LoginData = new LoginData();
		public var currentUser:MicroBlogUser;
		public var shownUser:MicroBlogUser;
		public var mainList:ArrayCollection = new ArrayCollection();
		public var currentPos:String;
	}
}