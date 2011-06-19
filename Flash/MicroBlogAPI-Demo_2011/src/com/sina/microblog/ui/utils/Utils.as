package com.sina.microblog.ui.utils
{
	import flash.display.NativeWindow;
	import flash.system.Capabilities;
	
	import mx.core.Window;
	import mx.formatters.DateFormatter;
	
	public class Utils
	{
		public static function formatDate(d:Date, fmt:String):String
		{
			var format:DateFormatter = new DateFormatter();
			format.formatString = fmt;
			return format.format(d);
		}
		
		public static function getDateString(d:Date):String
		{
			var dateString:String;
			var now:Date = new Date();
			var interval:Number = now.getFullYear() - d.getFullYear();
			if (interval != 0)
			{
				dateString = formatDate(d, "YYYY.MM.DD HH:NN");
			}
			else
			{
				interval = now.getMonth() - d.getMonth();
				if (interval != 0)
				{
					dateString = formatDate(d, "MM月DD日 HH:NN");
				}
				else
				{
					interval = now.getDate() - d.getDate();
					if (interval != 0)
					{
						dateString = formatDate(d, "MM月DD日 HH:NN");
					}
					else
					{
						interval = now.getHours() - d.getHours();
						if (interval != 0)
						{
							dateString = formatDate(d, "今天 HH:NN");
						}
						else
						{
							interval = now.getMinutes() - d.getMinutes();
							if (interval < 0)
							{
								dateString = formatDate(d, "今天 HH:NN");
							}
							else if (interval > 0)
							{
								dateString = interval + "分钟前";
							}
							else if (interval == 0)
							{
								dateString = "1分钟前";
							}
						}
					}
				}
			}
			return dateString;
		}
		
		public static function checkInput(t:String):Boolean
		{
			if (cnLength(t) > 280)
			{
				return false;
			}
			return true;
		}
		
		public static function countInput(t:String):int
		{
			return int( (280 - cnLength(t)) / 2 );
		}
		
		public static function cnLength(str:String):int
		{
			var n:int = str.replace(/[^\x00-\xff]/g, "xx").length;
			return n;
		}
		
		public static function trimStr(str:String):String
		{
			return str.replace(/(^\s*)|(\s*$)/g, '');
		}
		
		public static function replaceSpace(str:String):String
		{
			return str.replace(/[\s*]+/g, ' ');
		}
		
		public static function transformStr(str:String):String
		{
			str = str.replace(/&quot;/g, "\"");
			str = str.replace(/&amp;/g, "&");
			str = str.replace(/>/g, "&gt;");
			str = str.replace(/</g, "&lt;");
			return str;
		}
		
		public static function getStatusHtmlText(str:String):String
		{
			str = replaceSpace(str);
			str = transformStr(str);
			var atRegx:RegExp = /@([A-Za-z0-9\u4e00-\u9fa5]+)/gi;
			var keywordRegx:RegExp = /(?<![color='])#([^#]+)#/gi;
			var shortUrlRegx:RegExp = /((http[s]?|ftp)?:\/\/(([\w-]+:)?[\w-]+@)?([\w-]+\.)+[\w-]+(:[\d]+)?(\/[\w-   .\/?%&=]*)?(#[\w,]+)?)/gi;
			str = str.replace(shortUrlRegx, "<a href='$1' target='_blank'>$1</a>");
			str = str.replace(atRegx, "<a href='http://t.sina.com.cn/n/$1' target='_blank'>@$1</a>");
			str = str.replace(keywordRegx, "<a href='http://t.sina.com.cn/k/$1' target='_blank'>#$1#</a>");
			return str;
		}
		
		public static function getSourceHtmlText(str:String):String
		{
			var aRegx:RegExp = /<a[\s]+[^>]*?href[\s]?=[\s\"\']+(.*?)[\"\']+.*?>([^<]+|.*?)?<\/a>/gi;
			str = str.replace(aRegx, "$2");
			return "来自" + str;
		}
		
		public static function trunckStr(str:String, length:int):String
		{
			if ( length <= str.length )
			{
				return str;
			}
			return str.slice(0, length);
		}
		
		public static function resetWindowPos(param1:NativeWindow, param2:Window) : String
		{
			var _loc_3:String;
			var _loc_4:* = Capabilities.screenResolutionX;
			var _loc_5:* = Capabilities.screenResolutionY;
			if (param1.x < param2.width)
			{
				param2.nativeWindow.x = param1.width + param1.x;
				_loc_3 = "right";
			}
			else
			{
				param2.nativeWindow.x = param1.x - param2.width;
				_loc_3 = "left";
			}// end else if
			if (_loc_5 - param1.y < param2.height)
			{
				param2.nativeWindow.y = _loc_5 - param2.height - 10;
			}
			else
			{
				param2.nativeWindow.y = param1.y + 30;
			}// end else if
			return _loc_3;
		}
	}
}