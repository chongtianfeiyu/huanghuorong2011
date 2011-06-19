package com.sina.microblog.ui.utils
{
    import flash.events.*;
    import mx.styles.*;

    public class CSSParser extends EventDispatcher
    {
        static const COLORVALUE_SHORTHAND:RegExp = /0x([a-f0-9]{1})([a-f0-9]{1})([a-f0-9]{1})/i;
        static const EMBED_END:String = ")";
        static const PIXELVALUE_REPLACE:RegExp = /([0-9]*)px/ig;
        public static const ERROR:String = "onCSSParseError";
        static const EMBED_START:String = "@Embed(";
        static const COLORVALUE:RegExp = /#{1}(([a-f0-9]){3}(([a-f0-9]){3})?)/i;
        static const COMMENTS:RegExp = /\/\*[a-z0-9\s\n\!@#$%^&*()-_=+\[\]\\|:;'",.<>\/\?]*\*\//ig;
        static const COLORKEYS:Object = {black:"0x000000", blue:"0x0000FF", green:"0x00FF00", red:"0xFF0000", fuchsia:"0xFF00FF", cyan:"0x00FFFF", yellow:"0xFFFF00", white:"0xFFFFFF"};
        static const PIXELVALUE_SEARCH:RegExp = /[0-9]*px/ig;
        static const WHITESPACE:RegExp = /[\s\n]*/ig;

        public function CSSParser() : void
        {
            return;
        }// end function

        protected function parseProperty(param1:String) : XML
        {
            var _loc_5:String;
            var _loc_2:* = param1.indexOf(":");
            var _loc_3:Array;
            _loc_3.push(param1.slice(0, _loc_2));
            _loc_3.push(param1.slice(_loc_2 + 1));
            if (_loc_3[1].indexOf(",") > -1)
            {
                _loc_3[1] = _loc_3[1].split(",");
                for (_loc_5 in _loc_3[1])
                {
                    // label
                    _loc_3[1][_loc_5] = this.parseValue(_loc_3[1][_loc_5]);
                }// end of for ... in
                _loc_3[1] = _loc_3[1].join(",");
            }
            else
            {
                _loc_3[1] = this.parseValue(_loc_3[1]);
            }// end else if
            var _loc_4:* = new XML("<property name=\"" + _loc_3[0] + "\" value=\"" + _loc_3[1] + "\"/>");
            return new XML("<property name=\"" + _loc_3[0] + "\" value=\"" + _loc_3[1] + "\"/>");
        }// end function

        protected function parseSelector(param1:String) : XML
        {
            var _loc_2:String;
            var _loc_3:String;
            var _loc_4:String;
            var _loc_5:String;
            _loc_2 = param1.split(".")[0].split("#")[0];
            if (_loc_2.indexOf(":") > -1)
            {
                _loc_3 = _loc_2.split(":")[1];
                _loc_2 = _loc_2.split(":")[0];
            }// end if
            _loc_4 = param1.split("#")[1];
            _loc_5 = param1.split(".")[1];
            if (_loc_2 == null)
            {
                _loc_2 = "";
            }// end if
            if (_loc_3 == null)
            {
                _loc_3 = "";
            }// end if
            if (_loc_4 == null)
            {
                _loc_4 = "";
            }// end if
            if (_loc_5 == null)
            {
                _loc_5 = "";
            }// end if
            if (_loc_2 == "*")
            {
                _loc_2 = "";
            }// end if
            var _loc_6:* = new XML("<selector name=\"" + _loc_2 + "\" pseudo=\"" + _loc_3 + "\" id=\"" + _loc_4 + "\" _class=\"" + _loc_5 + "\"/>");
            return new XML("<selector name=\"" + _loc_2 + "\" pseudo=\"" + _loc_3 + "\" id=\"" + _loc_4 + "\" _class=\"" + _loc_5 + "\"/>");
        }// end function

        public function parse(param1:String) : XML
        {
            var _loc_3:XML;
            var _loc_6:Array;
            var _loc_7:Array;
            var _loc_8:String;
            var _loc_9:Array;
            var _loc_10:String;
            param1 = param1.replace(COMMENTS, "");
            param1 = param1.replace(WHITESPACE, "");
            if (param1.indexOf("/*") > -1)
            {
                this.dispatchEvent(new Event(ERROR));
                return null;
            }// end if
            var _loc_2:* = <styleSheet name="" url="" loaded="true"></styleSheet>;
            var _loc_4:* = param1.split("}");
            param1.split("}").splice(param1.split("}").length--, 1);
            var _loc_5:int;
            while (_loc_5 < _loc_4.length)
            {
                // label
                _loc_3 = <style>
							<selectors>
							</selectors>
							<properties>
							</properties>
						</style>;
                _loc_6 = _loc_4[_loc_5].split("{");
                _loc_7 = _loc_6[0].split(",");
                for (_loc_8 in _loc_7)
                {
                    // label
                    _loc_3.selectors.appendChild(this.parseSelector(_loc_7[_loc_8]));
                }// end of for ... in
                _loc_9 = _loc_6[1].split(";");
                _loc_9.pop();
                if (_loc_9.length == 0)
                {
                }
                else
                {
                    for (_loc_10 in _loc_9)
                    {
                        // label
                        _loc_3.properties.appendChild(this.parseProperty(_loc_9[_loc_10]));
                    }// end of for ... in
                    _loc_2.appendChild(_loc_3);
                }// end else if
                _loc_5++;
            }// end while
            return _loc_2;
        }// end function

        protected function parseValue(param1:String) : String
        {
            var _loc_3:String;
            if (param1.search(PIXELVALUE_SEARCH) > -1)
            {
                param1 = param1.replace(PIXELVALUE_REPLACE, "$1");
                return param1;
            }// end if
            if (param1.search(COLORVALUE) > -1)
            {
                param1 = param1.replace(COLORVALUE, "0x$1");
                if (param1.length == 5)
                {
                    param1 = param1.replace(COLORVALUE_SHORTHAND, "0x$1$1$2$2$3$3");
                }// end if
                return param1;
            }// end if
            var _loc_2:* = COLORKEYS;
            for (_loc_3 in _loc_2)
            {
                // label
                if (_loc_3 == param1.toLowerCase())
                {
                    return _loc_2[_loc_3];
                }// end if
            }// end of for ... in
            if (param1.slice(0, 1) == "\"" && param1.slice(-1) == "\"" || param1.slice(0, 1) == "\'" && param1.slice(-1) == "\'")
            {
                return param1.slice(1, param1.length-1);
            }// end if
            return param1;
        }// end function

        public static function getStyle(param1:String, param2:String)
        {
            var _loc_3:* = StyleManager.getStyleDeclaration(param1);
            if (!_loc_3)
            {
                return;
            }// end if
            return _loc_3.getStyle(param2);
        }// end function

    }
}
