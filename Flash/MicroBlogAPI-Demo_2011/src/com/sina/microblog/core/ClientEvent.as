package com.sina.microblog.core
{
	import flash.events.Event;

	public class ClientEvent extends Event
	{
	//UI
		public static const JUMPTO_HOME				:String = "jumpToHome";
		public static const JUMPTO_FRIENDS			:String = "jumpToFriends";
		public static const JUMPTO_FANS				:String = "jumpToFans";
		public static const JUMPTO_STATUS			:String = "jumpToStatus";
		public static const JUMPTO_RECEIVED_MSGS	:String = "jumpToReceivedMsgs";
		public static const JUMPTO_SENT_MSGS		:String = "jumpToSentMsgs";
		public static const JUMPTO_SENT_COMMENTS	:String = "jumpToSentComments";
		public static const JUMPTO_RECEIVED_COMMENTS:String = "jumpToReceivedComments";
		public static const JUMPTO_FAVOURITES		:String = "jumpToFavourites";
		public static const JUMPTO_MENTIONS			:String = "jumpToMentions";
		public static const JUMPTO_LOGIN			:String = "jumpToLogin";
		
		public static const START_REPOST_STATUS		:String = "startRepostStatus";
		public static const CANCEL_REPOST_STATUS	:String = "cancelRepostStatus";
		
		public static const START_SEND_MSG			:String 	= "startSendMsg";
		public static const CANCEL_SEND_MSG			:String 	= "cancelSendMsg";
		
	//Controller
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		public static const LOGIN_FAILED:String = "loginFailed";
		
		public static const UPDATE_STATUS_SUCCESS	:String 	= "updateStatusSuccess";
		public static const UPDATE_STATUS_FAILED	:String 	= "updateStatusFailed";
		
		public static const REPOST_STATUS_SUCCESS	:String 	= "repostStatusSuccess";
		public static const REPOST_STATUS_FAILED	:String 	= "repostStatusFailed";
		
		public static const COMMENT_STATUS_SUCCESS	:String		= "commentStatusSuccess";
		public static const COMMENT_STATUS_FAILED	:String		= "commentStatusFailed";
		
		public static const REPLY_COMMENT_SUCCESS	:String		= "replyCommentSuccess";
		public static const REPLY_COMMENT_FAILED	:String		= "replyCommentFailed";
		
		public static const DELETE_STATUS_SUCCESS	:String		= "deleteStatusSuccess";
		public static const DELETE_STATUS_FAILED	:String		= "deleteStatusFailed";
		
	//User
		public static const FOLLOW_SUCCESS			:String		= "followSuccess";
		public static const FOLLOW_FAILED			:String		= "followFailed";
		
		public static const CANCEL_FOLLOW_SUCCESS	:String		= "cancelFollowSuccess";
		public static const CANCEL_FOLLOW_FAILED	:String		= "cancelFollowFailed";
		
	//Comment
		public static const DELETE_COMMENT_SUCCESS	:String		= "deleteCommentSuccess";
		public static const DELETE_COMMENT_FAILED	:String		= "deleteCommentFailed";
		
	//DirectMessage
		public static const SEND_MSG_SUCCESS		:String		= "sendMsgSuccess";
		public static const SEND_MSG_FAILED			:String		= "sendMsgFailed";
		
		public static const DELETE_MSG_SUCCESS		:String		= "deleteMsgSuccess";
		public static const DELETE_MSG_FAILED		:String		= "deleteMsgFailed";
	
	//Favorite
		public static const ADD_TO_FAVORITE_SUCCESS	:String		= "addToFavoriteSuccess";
		public static const ADD_TO_FAVORITE_FAILED	:String		= "addToFavoriteFailed";
		
		public static const CANCEL_FAVORITE_SUCCESS:String 		= "removeFavoriteSuccess";
		public static const CANCEL_FAVORITE_FAILED	:String		= "removeFavoriteFailed";
		
		public static const OPEN_CUSTOME_BROWSER:String = "OpenCustomeBrowser";
		public static const CLOSE_CUSTOME_BROWSER:String = "CloseCustomeBrowser";
		
		public static const LOAD_FRIENDS_TIMELINE_RESULT:String = "loadFriendsTimeLineResult";
		public static const LOAD_COMMENTS_TIMELINE_RESULT:String = "loadCommentsTimelineResult";
		public static const LOAD_DIRECT_MESSAGES_RECEIVED_RESULT:String = "loadDirectMessagesReceivedResult";
		
		public static const LOAD_FRIENDS_INFO_RESULT:String = "loadFriendsInfoResult";
		public static const LOAD_FOLLOWERS_INFO_RESULT:String = "loadFollowersInfoResult";
		
		public static const LOAD_STATUS_UNREAD_RESULT:String = "loadStatusUnreadResult";
		public static const RESET_STATUS_COUNT_RESULT:String = "resetStatusResult";
		public static const RESET_STATUS_COUNT_ERROR:String = "resetStatusError";
		
		public var data:Object;
		public function ClientEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}