/**   
 * 背景渐变色   
 * whisht   
 * */   
package com.sina.microblog.ui.components.style{   
	
	import flash.display.*;   
	import flash.geom.*;   
	import flash.utils.*;   
	
	import mx.core.EdgeMetrics;   
	import mx.skins.halo.HaloBorder;   
	import mx.utils.ColorUtil;   
	import mx.utils.GraphicsUtil;   
	
	public class GradientBorder extends HaloBorder    
	{   
		
		private var topCornerRadius:Number;        // top corner radius   
		private var bottomCornerRadius:Number;    // bottom corner radius   
		private var fillColors:Array;            // fill colors (two)   
		private var setup:Boolean;   
		
		
		private function setupStyles():void   
		{   
			fillColors = getStyle("fillColors") as Array;   
			if (!fillColors) fillColors = [0xFFFFFF, 0xFFFFFF];   
			
			topCornerRadius = getStyle("cornerRadius") as Number;   
			if (!topCornerRadius) topCornerRadius = 0;       
			
			bottomCornerRadius = getStyle("bottomCornerRadius") as Number;   
			if (!bottomCornerRadius) bottomCornerRadius = topCornerRadius;       
			
		}   
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void   
		{   
			graphics.clear();//清除上一次画出来的背景
			super.updateDisplayList(unscaledWidth, unscaledHeight);       
			setupStyles();   
			var g:Graphics = graphics; 
			var b:EdgeMetrics = borderMetrics;   
			var w:Number = unscaledWidth - b.left - b.right;   
			var h:Number = unscaledHeight - b.top - b.bottom;   
//			var m:Matrix = verticalGradientMatrix(0, 0, w, h);   
			var m:Matrix = horizontalGradientMatrix(0, 0, w, h);
			
			g.beginGradientFill("linear", fillColors, [1, 1], [0, 255], m);   
			
			var tr:Number = Math.max(topCornerRadius-2, 0);   
			var br:Number = Math.max(bottomCornerRadius-2, 0);   
			
			GraphicsUtil.drawRoundRectComplex(g, b.left, b.top, w, h, tr, tr, br, br);   
			g.endFill();   
			
		}   
		
	}   
}