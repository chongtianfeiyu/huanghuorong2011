package com.sina.microblog.core.utils
{
	public class Utility
	{
		static public function getTimeByDate(date:Date):String
		{
			return 	String(date.fullYear).slice(2) + "-" + 
					String(date.month) + "-" + 
					String(date.date) + " " + 
					String(date.hours) + ":" + 
					String(date.minutes);
		}
	}
}