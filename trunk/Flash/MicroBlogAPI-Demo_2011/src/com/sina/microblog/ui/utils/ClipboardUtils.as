package com.sina.microblog.ui.utils
{
	import flash.desktop.Clipboard;

	/**
	 * @获取剪切板的数据，可以取截图。
	 * <p>
	 * 
	 * @Auth by winters_huang
	 * @Seetoo http://blog.csdn.net/huanghr_1/article/details/6581557
	 */ 
	public class ClipboardUtils
	{
		import flash.desktop.ClipboardFormats;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		
		import mx.core.UIComponent;   
		
		private static var Instance:ClipboardUtils=new ClipboardUtils();   
		public static function getInstance():ClipboardUtils{   
			return Instance;   
		}    
		
		public function ClipboardUtils()
		{
		}
		
		/**
		 * @直接返回bitmap
		 * 
		 */ 
		public function getBitmap():Bitmap{
			var backStr:String =getFormat(ClipboardFormats.BITMAP_FORMAT);
			var bm:Bitmap;
			if(backStr!=""){
				var obj:Object = Clipboard.generalClipboard.getData(backStr);
				var bmd:BitmapData = obj as BitmapData;
				bm = new Bitmap(bmd);
			}
			return bm;
		}
		
		public function getData():BoardFormat{   
			var returnObj:BoardFormat;   
			returnObj.sort=getSelFormat();   
			returnObj.data=Clipboard.generalClipboard.getData(returnObj.sort)   
			var bmd:BitmapData =returnObj.data as BitmapData;   
			toBitmap(bmd)   
			return returnObj;   
		}   
		private function toBitmap(bmd:BitmapData):UIComponent{   
			var ui:UIComponent=new UIComponent;   
			var bm:Bitmap = new Bitmap(bmd);   
			ui.addChild(bm);   
			return ui;   
		}   
		private function getSelFormat():String{   
			var backStr:String;   
			backStr=getFormat(ClipboardFormats.BITMAP_FORMAT)   
			if(backStr!=""){   
				return backStr;   
			}   
			backStr=getFormat(ClipboardFormats.FILE_LIST_FORMAT)   
			if(backStr!=""){   
				return backStr;   
			}   
			backStr=getFormat(ClipboardFormats.HTML_FORMAT)   
			if(backStr!=""){   
				return backStr;   
			}   
			backStr=getFormat(ClipboardFormats.TEXT_FORMAT)   
			if(backStr!=""){   
				return backStr;   
			}   
			backStr=getFormat(ClipboardFormats.URL_FORMAT)   
			if(backStr!=""){   
				return backStr;   
			}   
			return null; 
		}
		private function getFormat(str:String):String{   
			if(Clipboard.generalClipboard.hasFormat(str)){   
				return str   
			}else{   
				return "";   
			}   
		}   
	}
}