package com.sina.microblog.ui.components.ext
{
	import com.sina.microblog.data.MicroBlogEmotions;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;

	public class TextFlowUtils
	{
		public static function getTextFlow(xmlContent:String, emoArr:Array, emos_reg:RegExp):TextFlow
		{
			if(emoArr!=null && emoArr.length>0){
				var emoName:String = "";
				do{
					if(emoName && emoName.length>0){
						for (var i:int = 0; i<emoArr.length; i++){
							var mbe:MicroBlogEmotions = emoArr[i] as MicroBlogEmotions;
							if(emoName==mbe.phrase){
								var url:String = mbe.url;
								xmlContent = xmlContent.replace(emoName, " <img source=\""+url+"\"/> ");
								break;
							}
						}
					}
					//搜索字符串中的表情，由addEmo进行替换。
					var emoNameArr:Array = emos_reg.exec(xmlContent);
					if(emoNameArr!=null && emoNameArr.length>0){
						emoName = emoNameArr[0];
					}else{
						emoName = "";
					}
				}while (emoName)
			}
			var markup:String = "<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'><p>" + xmlContent + " </p></TextFlow>";
			//				trace("markup: " +markup);
			var textFlow:TextFlow = TextConverter.importToFlow(markup, TextConverter.TEXT_LAYOUT_FORMAT);
			return textFlow;
		}
		
	}
}