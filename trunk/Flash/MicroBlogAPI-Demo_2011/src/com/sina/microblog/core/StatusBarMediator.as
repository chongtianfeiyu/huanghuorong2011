package com.sina.microblog.core
{
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import flash.utils.Dictionary;

	public class StatusBarMediator
	{
		private var _client:MicroBlogClient;
		private var _controller:MainController;
		
		private var mappingData:Dictionary = new Dictionary(true);
		
		public function set client(value:MicroBlogClient):void
		{
			_client = value;
		}
		
		public function set controller(value:MainController):void
		{
			_controller = value;
		}
		
		public function init():void
		{
			addEvent(ClientEvent.LOGIN_SUCCESS, 		"登陆成功");
			addEvent(ClientEvent.LOGIN_FAILED,			"登陆失败");
			
			addEvent(ClientEvent.UPDATE_STATUS_SUCCESS,	"微博发送成功");
			addEvent(ClientEvent.UPDATE_STATUS_FAILED,	"微博发送失败");
			addEvent(ClientEvent.REPOST_STATUS_SUCCESS,	"转发成功");
			addEvent(ClientEvent.REPOST_STATUS_FAILED,	"转发失败");
			addEvent(ClientEvent.COMMENT_STATUS_SUCCESS,"评论成功");
			addEvent(ClientEvent.COMMENT_STATUS_FAILED,	"评论失败");
			addEvent(ClientEvent.REPLY_COMMENT_SUCCESS,	"回复成功");
			addEvent(ClientEvent.REPLY_COMMENT_FAILED,	"回复失败");
			addEvent(ClientEvent.DELETE_STATUS_SUCCESS,	"微博删除成功");
			addEvent(ClientEvent.DELETE_STATUS_FAILED,	"微博删除失败");
			
			addEvent(ClientEvent.FOLLOW_SUCCESS,		"加关注成功");
			addEvent(ClientEvent.FOLLOW_FAILED,			"加关注失败");
			addEvent(ClientEvent.CANCEL_FOLLOW_SUCCESS,	"取消关注成功");
			addEvent(ClientEvent.CANCEL_FOLLOW_FAILED,	"取消关注失败");
			
			addEvent(ClientEvent.DELETE_COMMENT_SUCCESS,"评论删除成功");
			addEvent(ClientEvent.DELETE_COMMENT_FAILED,	"评论删除失败");
			
			addEvent(ClientEvent.SEND_MSG_SUCCESS,		"私信发送成功");
			addEvent(ClientEvent.SEND_MSG_FAILED,		"私信发送失败");
			addEvent(ClientEvent.DELETE_MSG_SUCCESS,	"私信删除成功");
			addEvent(ClientEvent.DELETE_MSG_FAILED,		"私信删除失败");
			
			addEvent(ClientEvent.ADD_TO_FAVORITE_SUCCESS,"收藏成功");
			addEvent(ClientEvent.ADD_TO_FAVORITE_FAILED,"收藏失败");
			
			addEvent(ClientEvent.ADD_TO_FAVORITE_SUCCESS,"收藏成功");
			addEvent(ClientEvent.ADD_TO_FAVORITE_FAILED,"收藏失败");
			
			_controller.microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT, 	function(e:MicroBlogEvent):void{
				_client.status = "获取微博成功";
			});
			_controller.microBlogAPI.addEventListener(MicroBlogErrorEvent.LOAD_FRIENDS_TIMELINE_ERROR, 	function(e:MicroBlogErrorEvent):void{
				_client.status = "获取微博失败";
			});
			_controller.microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FAVORITE_LIST_RESULT, 	function(e:MicroBlogEvent):void{
				_client.status = "获取收藏成功";
			});
			_controller.microBlogAPI.addEventListener(MicroBlogErrorEvent.LOAD_FAVORITE_LIST_ERROR, 	function(e:MicroBlogErrorEvent):void{
				_client.status = "获取收藏失败";
			});
		}
		
		private function addEvent(eventType:String, status:String):void
		{
			mappingData[eventType]= status;
			_controller.addEventListener(eventType, eventHandler);
		}
		
		private function eventHandler(event:ClientEvent):void
		{
			_client.status = mappingData[event.type];
		}
	}
}