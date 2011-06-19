package com.sina.microblog.ui.utils
{
    import com.sina.microblog.ui.utils.effects.HighLightSequence;
    
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.effects.easing.*;
    import mx.events.*;
    import mx.managers.*;

    public class EffectUtils extends Object
    {
        private static const X_OFFSET:Object = 5;
        private static var timedProcess:uint = 4.29497e+009;

        public function EffectUtils()
        {
            return;
        }// end function

        public static function shadow(param1:Boolean = true) : Array
        {
            var _loc_2:* = new Array();
            var _loc_3:Number;
            var _loc_4:Number;
            var _loc_5:uint;
            var _loc_6:Number;
            var _loc_7:Number;
            var _loc_8:Number;
            var _loc_9:Number;
            var _loc_10:* = BitmapFilterQuality.MEDIUM;
            _loc_2.push(new DropShadowFilter(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, param1));
            return _loc_2;
        }// end function

        public static function setFlowEffect(param1:Object, param2:Number = 16777215, param3:Number = 8) : void
        {
            var _loc_4:* = getBitmapFilter(param2, param3);
            var _loc_5:* = new Array();
            new Array().push(_loc_4);
            param1.filters = _loc_5;
            return;
        }// end function

        public static function moveDownEffect(param1:Object) : void
        {
            var _loc_2:* = Application.application;
            var _loc_3:* = new Move(param1);
            _loc_3.xFrom = _loc_2.width - param1.width - (X_OFFSET as int);
            _loc_3.yFrom = -param1.height - 10;
            _loc_3.xTo = _loc_2.width - param1.width - (X_OFFSET as int);
            _loc_3.yTo = 0;
            _loc_3.play();
            return;
        }// end function

        public static function moveA2B(param1:Object, param2:Point, param3:Point, param4:Function = null) : Effect
        {
            var _loc_5:* = new Move(param1);
            if (param4)
            {
                _loc_5.addEventListener(EffectEvent.EFFECT_END, param4);
            }// end if
            _loc_5.xFrom = param2.x;
            _loc_5.yFrom = param2.y;
            _loc_5.xTo = param3.x;
            _loc_5.yTo = param3.y;
            return _loc_5;
        }// end function

        public static function showMessage(param1:Object, param2:HighLightSequence, param3:Label, param4:String, param5:uint = 16775072) : void
        {
            param1.visible = true;
            param2.highColor = param5;
            if (timedProcess != uint.MAX_VALUE)
            {
                clearTimeout(timedProcess);
            }// end if
            param3.visible = true;
            param3.text = param4;
            timedProcess = setTimeout(clearMessage, 5000, param3, param1);
            param2.play([param1]);
            return;
        }// end function

        public static function moveUpEffect(param1:Object) : void
        {
            var _loc_2:* = Application.application;
            var _loc_3:* = new Move(param1);
            param1.addEventListener(EffectEvent.EFFECT_END, endHandler);
            _loc_3.xFrom = _loc_2.width - param1.width - (X_OFFSET as int);
            _loc_3.yFrom = 0;
            _loc_3.xTo = _loc_2.width - param1.width - (X_OFFSET as int);
            _loc_3.yTo = -param1.height - 10;
            _loc_3.play();
            return;
        }// end function

        public static function moveAndDisppear(param1:Object, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0) : void
        {
            var _loc_6:* = Application.application;
            var _loc_7:* = getQualifiedClassName(param1);
            var _loc_8:* = getDefinitionByName(_loc_7) as Class;
            var _loc_9:* = new getDefinitionByName(_loc_7) as Class;
            (new getDefinitionByName(_loc_7) as Class).width = param1.width;
            _loc_9.height = param1.height;
            PopUpManager.addPopUp(_loc_9 as IFlexDisplayObject, _loc_6);
            _loc_9.addEventListener(EffectEvent.EFFECT_END, endHandler);
            var _loc_10:* = param1.localToGlobal(new Point());
            var _loc_11:* = new Parallel(_loc_9);
            new Parallel(_loc_9).duration = 1000;
            var _loc_12:* = new Move();
            new Move().xFrom = _loc_10.x;
            _loc_12.yFrom = _loc_10.y;
            _loc_12.xTo = param2;
            _loc_12.yTo = param3;
            var _loc_13:* = new Zoom();
            new Zoom().zoomWidthTo = param4;
            _loc_13.zoomHeightTo = param5;
            var _loc_14:* = new Fade();
            new Fade().alphaFrom = 1;
            _loc_14.alphaTo = 0;
            _loc_11.addChild(_loc_12);
            _loc_11.addChild(_loc_13);
            _loc_11.addChild(_loc_14);
            _loc_11.play();
            return;
        }// end function

        private static function endHandler(param1:EffectEvent) : void
        {
            PopUpManager.removePopUp(param1.target as IFlexDisplayObject);
            return;
        }// end function

        public static function moveA2B2C(param1:Object, param2:Point, param3:Point, param4:Point, param5:Function = null) : Effect
        {
            var _loc_6:* = new Sequence(param1);
            if (param5)
            {
                _loc_6.addEventListener(EffectEvent.EFFECT_END, param5);
            }// end if
            var _loc_7:* = new Move();
            new Move().xFrom = param2.x;
            _loc_7.yFrom = param2.y;
            _loc_7.xTo = param3.x;
            _loc_7.yTo = param3.y;
            var _loc_8:* = new Move();
            new Move().xFrom = param3.x;
            _loc_8.yFrom = param3.y;
            _loc_8.xTo = param4.x;
            _loc_8.yTo = param4.y;
            _loc_6.addChild(_loc_7);
            _loc_6.addChild(_loc_8);
            return _loc_6;
        }// end function

        public static function moveResizeA2B(param1:Object, param2:Rectangle, param3:Rectangle, param4:Function = null) : Effect
        {
            var _loc_5:* = new Parallel(param1);
            if (param4)
            {
                _loc_5.addEventListener(EffectEvent.EFFECT_END, param4);
            }// end if
            var _loc_6:* = new Move();
            new Move().xFrom = param2.x;
            _loc_6.yFrom = param2.y;
            _loc_6.xTo = param3.x;
            _loc_6.yTo = param3.y;
            _loc_6.easingFunction = Circular.easeOut;
            var _loc_7:* = new Resize();
            new Resize().widthFrom = param2.width;
            _loc_7.heightFrom = param2.height;
            _loc_7.widthTo = param3.width;
            _loc_7.heightTo = param3.height;
            var _loc_8:* = new Fade();
            new Fade().alphaFrom = 0.5;
            _loc_8.alphaTo = 1;
            _loc_5.addChild(_loc_6);
            _loc_5.addChild(_loc_7);
            _loc_5.addChild(_loc_8);
            return _loc_5;
        }// end function

        public static function moveResizeA2B2C(param1:Object, param2:Rectangle, param3:Rectangle, param4:Rectangle, param5:Function = null) : Effect
        {
            var _loc_6:* = new Sequence(param1);
            if (param5)
            {
                _loc_6.addEventListener(EffectEvent.EFFECT_END, param5);
            }// end if
            var _loc_7:* = moveResizeA2B(param1, param2, param3);
            var _loc_8:* = moveResizeA2B(param1, param3, param4);
            _loc_6.addChild(_loc_7);
            _loc_6.addChild(_loc_8);
            return _loc_6;
        }// end function

        private static function clearMessage(param1:Object, param2:Object) : void
        {
            param1.visible = false;
            return;
        }// end function

        public static function getBitmapFilter(param1:Number = 16777215, param2:Number = 8) : BitmapFilter
        {
            var _loc_3:Number;
            var _loc_4:* = param2;
            var _loc_5:* = param2;
            var _loc_6:Number;
            var _loc_7:Boolean;
            var _loc_8:Boolean;
            var _loc_9:* = BitmapFilterQuality.HIGH;
            return new GlowFilter(param1, _loc_3, _loc_4, _loc_5, _loc_6, _loc_9, _loc_7, _loc_8);
        }// end function

    }
}
