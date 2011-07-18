package com.sina.microblog.core
{
	import flash.events.EventDispatcher;
	
	import mx.core.FlexGlobals;

	public class OAuthManager extends EventDispatcher
	{
		import com.adobe.crypto.HMAC;
		import com.adobe.crypto.SHA1;
		import com.dynamicflash.util.Base64;
		import com.sina.microblog.MicroBlog;
		import com.sina.microblog.data.MicroBlogUser;
		import com.sina.microblog.events.MicroBlogEvent;
		import com.sina.microblog.utils.GUID;
		import com.sina.microblog.utils.StringEncoders;
		
		import flash.display.MovieClip;
		import flash.display.SimpleButton;
		import flash.display.StageAlign;
		import flash.display.StageScaleMode;
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.events.MouseEvent;
		import flash.events.SecurityErrorEvent;
		import flash.html.HTMLLoader;
		import flash.net.LocalConnection;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import flash.net.URLRequestHeader;
		import flash.net.URLRequestMethod;
		import flash.net.URLVariables;
		import flash.text.TextField;
		import flash.text.TextFieldAutoSize;
		import flash.text.TextFormat;
		
		public function OAuthManager()
		{
		}
		
		private var _mb:MicroBlog;
		private var _consumerKey:String="";
		private var _source:String = "";
		private var _consumerSecret:String="";
		private var _accessTokenKey:String="";
		private var _accessTokenSecret:String="";
		private var _pin:String="";
		
		
		private static const API_BASE_URL:String = "http://api.t.sina.com.cn";
		private static const OAUTH_REQUEST_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/request_token";
		private static const OAUTH_AUTHORIZE_REQUEST_URL:String = API_BASE_URL + "/oauth/authorize";
		private static const OAUTH_ACCESS_TOKEN_REQUEST_URL:String=API_BASE_URL + "/oauth/access_token";
		
		private static var manager:OAuthManager =new OAuthManager();
		
		public static function get instance():OAuthManager{
			return manager;
		}
		
		private var _btnLogin:SimpleButton;
		private var _urlTxt:TextField;
		
		private var _html:HTMLLoader;
		
		///登录的时候临时建立的频道
		private var _localConnectionChanel:String;
		///获取anywheretoken值的连接
		private var _conn:LocalConnection;
		///通过此值获取用户当前状态，使用proxy接口时需要带上此值
		private var _anywhereToken:String = "";		
		
		private var oauthLoader:URLLoader;
		
		/**
		 * @第一步：获取授权页面的URL，使用事件方式发送结果给调用端。
		 * 
		 */ 
		public function onLoadRequest():void 
		{
			if(_mb==null){
				_mb = FlexGlobals.topLevelApplication.controller.microBlogAPI;
				_consumerKey = FlexGlobals.topLevelApplication._consumerKey;
				_source      = FlexGlobals.topLevelApplication._source;
				_consumerSecret = FlexGlobals.topLevelApplication._consumerSecret;
			}
			
			if (null == oauthLoader)
			{
				oauthLoader=new URLLoader();
				oauthLoader.addEventListener(Event.COMPLETE, oauthLoader_onComplete, false, 0, true);
				oauthLoader.addEventListener(IOErrorEvent.IO_ERROR, oauthLoader_onError, false, 0, true);
				oauthLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, oauthLoader_onSecurityError, false, 0, true);
			}
			
			var req:URLRequest = new URLRequest(OAUTH_REQUEST_TOKEN_REQUEST_URL);
			req.method = URLRequestMethod.POST;
			
			var params:URLVariables = new URLVariables;
			var now:Date=new Date();
			params["oauth_consumer_key"]=_consumerKey;
			params["oauth_signature_method"]="HMAC-SHA1";
			params["oauth_timestamp"]=now.time.toString().substr(0, 10);
			params["oauth_nonce"]=GUID.createGUID();
			params["oauth_version"]="1.0";
			params["oauth_callback"] = "http://api.t.sina.com.cn/flash/callback.htm";	
			
			var retParams:Array=[];
			for (var param:String in params)
			{
				if(params[param] != null) retParams.push(param + "=" + StringEncoders.urlEncodeUtf8String(params[param].toString()));
			}
			retParams.sort();
			var paramsStr:String =  retParams.join("&");
			
			var msgStr:String=StringEncoders.urlEncodeUtf8String(URLRequestMethod.POST.toUpperCase()) + "&";
			msgStr+=StringEncoders.urlEncodeUtf8String(OAUTH_REQUEST_TOKEN_REQUEST_URL);
			msgStr+="&";
			msgStr += StringEncoders.urlEncodeUtf8String(paramsStr);	
			
			var secrectStr:String = _consumerSecret + "&";
			var sig:String = Base64.encode(HMAC.hash(secrectStr, msgStr, SHA1));		
			params["oauth_signature"] = sig;
			
			req.data = params;
			oauthLoader.load(req);
		}
		
		private function requestAuthorize():void
		{
			var url:String=OAUTH_AUTHORIZE_REQUEST_URL;
			url+="?oauth_token=" + StringEncoders.urlEncodeUtf8String(_accessTokenKey);
			url += "&oauth_callback=http://api.t.sina.com.cn/flash/callback.htm";
			var clientEvent:ClientEvent = new ClientEvent(ClientEvent.OPEN_CUSTOME_BROWSER);
			clientEvent.data = url;
			dispatchEvent(clientEvent);
//			_html = new HTMLLoader();
//			var urlReq:URLRequest = new URLRequest(url);
//			_html.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
//			_html.width = 780;
//			_html.height = 400;
//			_html.load(urlReq); 
//			_html.x = 10;
//			_html.y = 89;
//			addChild(_html);					
		}
		
		/**
		 * @第二步：验证返回的token和Pin码是否正确，正确则调用验证用户身份接口。
		 * 
		 */ 
		public function onLoadAccess(location:String):void 
		{
			var lc:String = location;
			trace(lc);
			var arr:Array = String(lc.split("?")[1]).split("&");
			var oauth_token:String = "";
			var oauth_verifier:String = "";
			for (var i:int = 0 ; i < arr.length; i ++)
			{
				var str:String = arr[i];
				if (str.indexOf("oauth_token=") >= 0) oauth_token = str.split("=")[1];
				if (str.indexOf("oauth_verifier=") >= 0) oauth_verifier = str.split("=")[1];
			}
			
			if (oauth_verifier != "") {
				dispatchEvent(new ClientEvent(ClientEvent.CLOSE_CUSTOME_BROWSER));
				_pin = oauth_verifier;
				
				var req:URLRequest = new URLRequest(OAUTH_ACCESS_TOKEN_REQUEST_URL);
				req.method = URLRequestMethod.POST;
				
				var params:URLVariables = new URLVariables;
				var now:Date=new Date();
				params["oauth_consumer_key"]=_consumerKey;
				if (_accessTokenKey.length > 0)	params["oauth_token"] = _accessTokenKey;
				if (_pin && _pin.length > 0) params["oauth_verifier"] = _pin;
				params["oauth_signature_method"]="HMAC-SHA1";
				params["oauth_timestamp"]=now.time.toString().substr(0, 10);
				params["oauth_nonce"]=GUID.createGUID();
				params["oauth_version"]="1.0";
				params["oauth_callback"] = "oob";
				
				var retParams:Array=[];
				for (var param:String in params)
				{
					if(params[param] != null) retParams.push(param + "=" + StringEncoders.urlEncodeUtf8String(params[param].toString()));
				}
				retParams.sort();
				var paramsStr:String =  retParams.join("&");
				
				var msgStr:String=StringEncoders.urlEncodeUtf8String(URLRequestMethod.POST.toUpperCase()) + "&";
				msgStr+=StringEncoders.urlEncodeUtf8String(OAUTH_ACCESS_TOKEN_REQUEST_URL);
				msgStr+="&";
				msgStr += StringEncoders.urlEncodeUtf8String(paramsStr);		
				var secrectStr:String = _consumerSecret + "&";		
				secrectStr += _accessTokenSecret;		
				var sig:String = Base64.encode(HMAC.hash(secrectStr, msgStr, SHA1));		
				params["oauth_signature"] = sig;			
				req.data = params;
				oauthLoader.load(req);
				
			}	
		}
		
		private function oauthLoader_onComplete(event:Event):void
		{
			var needRequestAuthorize:Boolean = _accessTokenKey.length == 0;
			var result:String = oauthLoader.data as String;
			if (result.length > 0)
			{
				var urlVar:URLVariables = new URLVariables(oauthLoader.data);
				_accessTokenKey=urlVar.oauth_token;
				_accessTokenSecret = urlVar.oauth_token_secret;
				
				if (needRequestAuthorize)
				{
					requestAuthorize();
					needRequestAuthorize=false;
				}else {
					//					removeChild(_html);	
					_mb.accessTokenKey = _accessTokenKey;
					_mb.accessTokenSecrect = _accessTokenSecret;
					_mb.verifyCredentials();
				}
			}
		}
		
		private function oauthLoader_onError(event:IOErrorEvent):void
		{
			
		}
		
		private function oauthLoader_onSecurityError(event:SecurityErrorEvent):void
		{
			
		}
	}
}