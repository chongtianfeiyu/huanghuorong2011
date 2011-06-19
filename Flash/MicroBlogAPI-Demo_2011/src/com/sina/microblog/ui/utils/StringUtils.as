package com.sina.microblog.ui.utils
{

    public class StringUtils extends Object
    {

        public function StringUtils()
        {
            return;
        }// end function

        function StringUtil()
        {
            throw new Error("StringUtil class is static container only");
        }// end function

        public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
        {
            return param1.toLowerCase() == param2.toLowerCase();
        }// end function

        public static function isChinese(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1);
            var _loc_2:* = /^[��-��]+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function mashUp(param1:Array) : String
        {
            var _loc_2:String;
            var _loc_3:int;
            while (_loc_3 < param1.length)
            {
                // label
                _loc_2 = _loc_2 + param1[_loc_3].toString();
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public static function isURL(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1).toLowerCase();
            var _loc_2:* = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function isEnglish(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1);
            var _loc_2:* = /^[A-Za-z]+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function isWhitespace(param1:String) : Boolean
        {
            switch(param1)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                {
                    return true;
                }// end case
                default:
                {
                    return false;
                    break;
                }// end default
            }// end switch
        }// end function

        public static function hasChineseChar(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1);
            var _loc_2:* = /[^\x00-\xff]/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function isEmpty(param1:String) : Boolean
        {
            if (!(param1 == null || param1 == ""))
            {
            }// end if
            return param1 == undefined;
        }// end function

        public static function remove(param1:String, param2:String) : String
        {
            return replace(param1, param2, "");
        }// end function

        public static function rtrim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }// end if
            var _loc_2:* = /\s*$/;
            return param1.replace(_loc_2, "");
        }// end function

        public static function ltrim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }// end if
            var _loc_2:* = /^\s*/;
            return param1.replace(_loc_2, "");
        }// end function

        public static function removeLastChar(param1:String) : String
        {
            return param1.substr(0, param1.length-1);
        }// end function

        public static function trim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }// end if
            return rtrim(ltrim(param1));
        }// end function

        public static function isEmail(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1);
            var _loc_2:* = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function isInteger(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }// end if
            param1 = trim(param1);
            var _loc_2:* = /^[-\+]?\d+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function replace(param1:String, param2:String, param3:String) : String
        {
            return param1.split(param2).join(param3);
        }// end function

        public static function startsWith(param1:String, param2:String) : Boolean
        {
            if (param2.length > param1.length)
            {
                return false;
            }// end if
            return param1.substr(0, param2.length) == param2;
        }// end function

        public static function breakUp(param1:String) : Array
        {
            var _loc_2:* = new Array(param1.length);
            var _loc_3:int;
            while (_loc_3 < param1.length)
            {
                // label
                _loc_2[_loc_3] = param1.substr(_loc_3, 1);
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public static function isDouble(param1:String) : Boolean
        {
            param1 = trim(param1);
            var _loc_2:* = /^[-\+]?\d+(\.\d+)?$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }// end if
            return true;
        }// end function

        public static function repeatStr(param1:String, param2:int)
        {
            var _loc_3:String;
            var _loc_4:int;
            while (_loc_4 < param2--)
            {
                // label
                _loc_3 = _loc_3 + param1;
                _loc_4++;
            }// end while
            return _loc_3;
        }// end function

        public static function endsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(param1.length - param2.length);
        }// end function

        public static function beginsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(0, param2.length);
        }// end function

    }
}
