package com.sina.microblog.core
{
	import air.update.ApplicationUpdaterUI;
	
	import com.sina.microblog.MicroBlog;
	import com.sina.microblog.core.vo.MainData;
	import com.sina.microblog.data.MicroBlogComment;
	import com.sina.microblog.data.MicroBlogDirectMessage;
	import com.sina.microblog.data.MicroBlogStatus;
	import com.sina.microblog.data.MicroBlogUser;
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class MainController extends EventDispatcher
	{
		public var appUpdater:ApplicationUpdaterUI;
		public var microBlogAPI:MicroBlog = new MicroBlog();
		private var _mainData:MainData = new MainData();
		public function MainController()
		{
//			microBlogAPI.addEventListener(MicroBlogErrorEvent.LOAD_FRIENDS_INFO_ERROR, onErrorHandler);
			microBlogAPI.addEventListener(MicroBlogEvent.VERIFY_CREDENTIALS_RESULT, 	onVerifyResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.OAUTH_CERTIFICATE_ERROR, 	onLoginError);
			microBlogAPI.addEventListener(SecurityErrorEvent.SECURITY_ERROR       , 	onLoginError);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.VERIFY_CREDENTIALS_ERROR, onLoginError);
			
		//Status
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT, 	onLoadFriendsTimeLineResult);
			microBlogAPI.addEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, 			onUpdateStatusResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, 	function(e:MicroBlogErrorEvent):void{
				dispatchEvent(new ClientEvent(ClientEvent.UPDATE_STATUS_FAILED));
			});
			microBlogAPI.addEventListener(MicroBlogEvent.REPOST_STATUS_RESULT, 			onRepostStatusResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.REPOST_STATUS_ERROR, 	function(e:MicroBlogErrorEvent):void{
				dispatchEvent(new ClientEvent(ClientEvent.REPOST_STATUS_FAILED));
			});
			microBlogAPI.addEventListener(MicroBlogEvent.COMMENT_STATUS_RESULT, 		onCommentStatusResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.COMMENT_STATUS_ERROR, 	function(e:MicroBlogErrorEvent):void{
				dispatchEvent(new ClientEvent(ClientEvent.COMMENT_STATUS_FAILED));
			});
			microBlogAPI.addEventListener(MicroBlogEvent.REPLY_STATUS_RESULT, 			onReplyStatusResult);
			microBlogAPI.addEventListener(MicroBlogEvent.DELETE_STATUS_RESULT,			onDeleteStatusResult);
		//User
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_INFO_RESULT, 		onLoadFriendsResult);
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FOLLOWERS_INFO_RESULT, 	onLoadFollowersResult);
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_USER_TIMELINE_RESULT, 	onLoadUserTimeLineResult);
			microBlogAPI.addEventListener(MicroBlogEvent.FOLLOW_RESULT,					onFollowResult);
			microBlogAPI.addEventListener(MicroBlogEvent.CANCEL_FOLLOWING_RESULT, 		onCancelFollowingResult);
		//Comment
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_COMMENTS_TIMELINE_RESULT,	onLoadCommentsTimelineResult);
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_MY_COMMENTS_RESULT, 		onLoadMyCommentsResult);
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_COMMENTS_RESULT,			onLoadStatusCommentsResult);
			microBlogAPI.addEventListener(MicroBlogEvent.DELETE_COMMENT_RESULT, 		onDeleteCommentResult);
		//DirectMessage
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, 	onLoadReceivedDirectMsgResult);
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_SENT_RESULT, 		onLoadSentDirectMsgResult);
			microBlogAPI.addEventListener(MicroBlogEvent.SEND_DIRECT_MESSAGE_RESULT, 	onSendDirectMsgResult);
			microBlogAPI.addEventListener(MicroBlogEvent.DELETE_DIRECT_MESSAGE_RESULT, 	onDeleteDirectMsgResult);
		//Favorite			
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_FAVORITE_LIST_RESULT, 	onLoadFavoritesResult);
			microBlogAPI.addEventListener(MicroBlogEvent.ADD_TO_FAVORITES_RESULT,		onAddToFavoritesResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.ADD_TO_FAVORITES_ERROR, 	function(e:MicroBlogErrorEvent):void{
				dispatchEvent(new ClientEvent(ClientEvent.ADD_TO_FAVORITE_FAILED));
			});
			microBlogAPI.addEventListener(MicroBlogEvent.REMOVE_FROM_FAVORITES_RESULT, 	onRemoveFromFavoritesResult);
			microBlogAPI.addEventListener(MicroBlogErrorEvent.CANCEL_FOLLOWING_ERROR, 	function(e:MicroBlogErrorEvent):void{
				dispatchEvent(new ClientEvent(ClientEvent.CANCEL_FAVORITE_FAILED));
			});
			
		//Mentions
			microBlogAPI.addEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, 			onMensionsResult);
			microBlogAPI.addEventListener(MicroBlogEvent.OPEN_CUSTOME_BROWSER, 			onOpenCustomeBrowser);
		
			appUpdater = new ApplicationUpdaterUI();
			appUpdater.configurationFile = File.applicationDirectory.resolvePath("update-config.xml"); 
			appUpdater.initialize();
		}
		
		private function onErrorHandler(event:MicroBlogErrorEvent):void
		{
			trace(event.message);
			dispatchEvent(new ClientEvent(ClientEvent.LOGIN_FAILED));
		}
		
		public function login(userName:String, password:String):void
		{
			_mainData.loginData.username = userName;
			_mainData.loginData.password = password;
			microBlogAPI.login(userName, password);
		}
		
	//Status		
		public function loadFriendsTimeline():void
		{
			microBlogAPI.loadFriendsTimeline();
		}
		public function publishStatus(text:String, image:ByteArray, imageName:String):void
		{
			microBlogAPI.updateStatus(text, imageName, image);
		}
		public function repostStatus(originalStatus:MicroBlogStatus,text:String):void
		{
			microBlogAPI.repostStatus(originalStatus.id,text);
		}
		public function commentStatus(originalStatus:MicroBlogStatus,text:String):void
		{
			microBlogAPI.commentStatus(originalStatus.id, text);
		}
		public function replyComment(originalComment:MicroBlogComment, text:String):void
		{
			microBlogAPI.replyStatus(originalComment.status.id, text, originalComment.id);
		}
		public function removeStatus(status:MicroBlogStatus):void
		{
			microBlogAPI.deleteStatus(status.id);
		}
	//User
		public function loadUserFriends(user:MicroBlogUser):void
		{
			microBlogAPI.loadFriendsInfo(null, user.id);
		}
		public function loadUserFollowers(user:MicroBlogUser):void
		{
			microBlogAPI.loadFollowersInfo(null, user.id);
		}
		public function loadUserStatus(user:MicroBlogUser):void
		{
			microBlogAPI.loadUserTimeline(null, user.id);
		}
		public function follow(user:MicroBlogUser):void
		{
			microBlogAPI.follow(user.name, user.id, user.screenName);
		}
		public function cancelFollow(user:MicroBlogUser):void
		{
			microBlogAPI.cancelFollowing(user.name, user.id, user.screenName);
		}
		public function cancelFans(user:MicroBlogUser):void
		{
		}
	//Comment
		public function loadCommentsTimeline():void
		{
			microBlogAPI.loadCommentsTimeline();
		}
		public function loadMyComments():void
		{
			microBlogAPI.loadMyComments();
		}
		public function loadStatusComments(status:MicroBlogStatus):void
		{
			microBlogAPI.loadCommentList(status.id);
		}
		public function removeComment(comment:MicroBlogComment):void
		{
			microBlogAPI.deleteComment(comment.id);
		}
		
	//DirectMessage
		public function loadReceivedDirectMsg():void
		{
			microBlogAPI.loadDirectMessagesReceived();
		}
		public function loadSentDirectMsg():void
		{
			microBlogAPI.loadDirectMessagesSent();
		}
		public function sendDirectMsg(reciever:MicroBlogUser, msg:String):void
		{
			microBlogAPI.sendDirectMessage(String(reciever.id), msg);
		}
		public function removeDirectMsg(directMsg:MicroBlogDirectMessage):void
		{
			microBlogAPI.deleteDirectMessage(directMsg.id);
		}
		
	//Favorite
		public function loadfavorites():void
		{
			microBlogAPI.loadFavoriteList();
		}
		public function favoriteStatus(status:MicroBlogStatus):void
		{
			microBlogAPI.addToFavorites(status.id);
		}
		public function cancelFavoriteStatus(status:MicroBlogStatus):void
		{
			/**
			 * 为适应新的FLASH API而修改，为测试是否有问题
			 * by win
			 * */
			microBlogAPI.removeFromFavorites(status.id);
		}
		
	//Mentions
		public function loadMentions():void
		{
			microBlogAPI.loadMentions();
		}
		
//CallBack
		private function onVerifyResult(event:MicroBlogEvent):void
		{
			_mainData.currentUser = event.result as MicroBlogUser;
			_mainData.shownUser = _mainData.currentUser;
			dispatchEvent(new ClientEvent(ClientEvent.LOGIN_SUCCESS));
		}
		
		private function onLoginError(event:MicroBlogErrorEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.LOGIN_FAILED));
		}
	//Status
		private function onLoadFriendsTimeLineResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
			var e:ClientEvent = new ClientEvent(ClientEvent.LOAD_FRIENDS_TIMELINE_RESULT);
			e.data = mainData.mainList;
			dispatchEvent(e);
		}
		private function onUpdateStatusResult(event:MicroBlogEvent):void
		{
			loadFriendsTimeline();
			dispatchEvent(new ClientEvent(ClientEvent.UPDATE_STATUS_SUCCESS));
		}
		private function onRepostStatusResult(event:MicroBlogEvent):void
		{
			loadFriendsTimeline();
			dispatchEvent(new ClientEvent(ClientEvent.REPOST_STATUS_SUCCESS));
		}
		private function onCommentStatusResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.COMMENT_STATUS_SUCCESS));
		}
		private function onReplyStatusResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.REPLY_COMMENT_SUCCESS));
		}
		private function onDeleteStatusResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.DELETE_STATUS_SUCCESS));
		}
		
	//User
		private function onLoadFriendsResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
			var e:ClientEvent = new  ClientEvent(ClientEvent.LOAD_FRIENDS_INFO_RESULT);
			e.data = mainData.mainList;
			dispatchEvent(e);
		}
		private function onLoadFollowersResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
			var e:ClientEvent = new  ClientEvent(ClientEvent.LOAD_FOLLOWERS_INFO_RESULT);
			e.data = mainData.mainList;
			dispatchEvent(e);
		}
		private function onLoadUserTimeLineResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
		}
		private function onFollowResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.FOLLOW_SUCCESS));
		}
		private function onCancelFollowingResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.CANCEL_FOLLOW_SUCCESS));
		}
		
	//Comment
		private function onLoadCommentsTimelineResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
			var e:ClientEvent = new  ClientEvent(ClientEvent.LOAD_COMMENTS_TIMELINE_RESULT);
			e.data = mainData.mainList;
			dispatchEvent(e);
		}
		private function onLoadMyCommentsResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
		}
		private function onLoadStatusCommentsResult(event:MicroBlogEvent):void
		{
			trace(1);
		}
		private function onDeleteCommentResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.DELETE_COMMENT_SUCCESS));
		}
		
	//DirectMessage
		private function onLoadReceivedDirectMsgResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
			var e:ClientEvent = new  ClientEvent(ClientEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT);
			e.data = mainData.mainList;
			dispatchEvent(e);
		}		
		private function onLoadSentDirectMsgResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
		}
		private function onSendDirectMsgResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.SEND_MSG_SUCCESS));
		}
		private function onDeleteDirectMsgResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.DELETE_MSG_SUCCESS));
		}
	//Favorite
		private function onLoadFavoritesResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
		}
		private function onAddToFavoritesResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.ADD_TO_FAVORITE_SUCCESS));
		}
		private function onRemoveFromFavoritesResult(event:MicroBlogEvent):void
		{
			dispatchEvent(new ClientEvent(ClientEvent.CANCEL_FAVORITE_SUCCESS));
		}
	//Mentions
		private function onMensionsResult(event:MicroBlogEvent):void
		{
			mainData.mainList = new ArrayCollection(event.result as Array);
		}
		
		private function onOpenCustomeBrowser(event:MicroBlogEvent):void{
			var e:ClientEvent = new ClientEvent(ClientEvent.OPEN_CUSTOME_BROWSER);
			e.data = event.result;
			dispatchEvent(e);
		}
		
		[Bindable]
		public function get mainData():MainData
		{
			return _mainData
		}
		
		public function set mainData(value:MainData):void
		{
			_mainData = value;
		}
	}
}