package com.sina.microblog.data
{

	/**
	 * MicroBlogEmotions是一个数据封装类(Value Object)，该类代表一条表情
	 *  字段名	描述
		phrase	表情使用的替代文字
		type	表情类型，image为普通图片表情，magic为魔法表情
		url	    表情图片存放的位置
		is_hot	是否为热门表情
		order_number	该表情在系统中的排序号码
		category	    表情分类
	 */ 
	public class MicroBlogEmotions
	{
		/**
		 * 表情使用的替代文字
		 */ 
		public var phrase:String;
		/**
		 * 表情类型，image为普通图片表情，magic为魔法表情
		 */ 
		public var type:String;
		/**
		 *  表情图片存放的位置
		 */ 
		public var url:String;
		/**
		 * 是否为热门表情
		 */ 
		public var is_hot:Boolean;
		/**
		 * 该表情在系统中的排序号码
		 */ 
		public var order_number:int;
		/**
		 * 表情分类
		 */ 
		public var category:String;
		
		/**
		 * @private
		 */ 
		public function MicroBlogEmotions(emotion:XML)
		{
			phrase = emotion.phrase;
			type = emotion.text;
			url = emotion.url;
			is_hot = (emotion.emotion=='true');
			order_number = emotion.order_number;
			category = emotion.category;
		}
	}
}