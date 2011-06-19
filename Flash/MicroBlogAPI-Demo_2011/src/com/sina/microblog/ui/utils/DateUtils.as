package com.sina.microblog.ui.utils
{

    public class DateUtils extends Object
    {
        public static const TERRESTRIAL_BRANCH:Object = ["��ʱ", "��ʱ", "��ʱ", "îʱ", "��ʱ", "��ʱ", "��ʱ", "δʱ", "��ʱ", "��ʱ", "��ʱ", "��ʱ"];
        public static const WEEKS_CN:Array = ["������", "����һ", "���ڶ�", "������", "������", "������", "������"];
        public static const WEEKS_EN:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "ThursDay", "Friday", "Saturday"];

        public function DateUtils()
        {
            return;
        }// end function

        private static function convertTime(param1:Number) : String
        {
            if (param1 <= 0)
            {
                return "�ѹ��ڣ�";
            }// end if
            var _loc_2:* = param1 / 1000;
            var _loc_3:* = new String();
            var _loc_4:* = _loc_2 / (30 * 24 * 3600);
            _loc_2 = _loc_2 % (30 * 24 * 3600);
            if (_loc_4 > 0)
            {
                _loc_3 = _loc_3 + (_loc_4 + "����");
            }// end if
            var _loc_5:* = _loc_2 / (7 * 24 * 3600);
            _loc_2 = _loc_2 % (7 * 24 * 3600);
            if (_loc_5 > 0)
            {
                _loc_3 = _loc_3 + (_loc_5 + "��");
            }// end if
            var _loc_6:* = _loc_2 / (24 * 3600);
            _loc_2 = _loc_2 % (24 * 3600);
            if (_loc_6 > 0)
            {
                _loc_3 = _loc_3 + (_loc_6 + "��");
            }// end if
            var _loc_7:* = _loc_2 / 3600;
            _loc_2 = _loc_2 % 3600;
            if (_loc_7 > 0)
            {
                _loc_3 = _loc_3 + (_loc_7 + "Сʱ");
            }// end if
            var _loc_8:* = _loc_2 / 60;
            _loc_2 = _loc_2 % 60;
            if (_loc_8 > 0)
            {
                _loc_3 = _loc_3 + (_loc_8 + "����");
            }// end if
            if (Math.round(_loc_2) > 0)
            {
                _loc_3 = _loc_3 + (Math.round(_loc_2) + "��");
            }// end if
            return _loc_3;
        }// end function

        public static function getTerrestrialBranch() : String
        {
            var _loc_1:* = format(new Date(), "HH");
            switch(_loc_1)
            {
                case "00":
                {
                    return TERRESTRIAL_BRANCH[0];
                }// end case
                case "02":
                {
                    return TERRESTRIAL_BRANCH[1];
                }// end case
                case "04":
                {
                    return TERRESTRIAL_BRANCH[2];
                }// end case
                case "06":
                {
                    return TERRESTRIAL_BRANCH[3];
                }// end case
                case "07":
                {
                    return TERRESTRIAL_BRANCH[4];
                }// end case
                case "10":
                {
                    return TERRESTRIAL_BRANCH[5];
                }// end case
                case "12":
                {
                    return TERRESTRIAL_BRANCH[6];
                }// end case
                case "14":
                {
                    return TERRESTRIAL_BRANCH[7];
                }// end case
                case "16":
                {
                    return TERRESTRIAL_BRANCH[8];
                }// end case
                case "18":
                {
                    return TERRESTRIAL_BRANCH[9];
                }// end case
                case "20":
                {
                    return TERRESTRIAL_BRANCH[10];
                }// end case
                case "22":
                {
                    return TERRESTRIAL_BRANCH[11];
                }// end case
                default:
                {
                    return "";
                    break;
                }// end default
            }// end switch
        }// end function

        public static function nowSegment(param1:Date = null) : String
        {
            if (!param1)
            {
                param1 = new Date();
            }// end if
            var _loc_2:* = int(format(param1, "HH"));
            if (_loc_2 >= 6 && _loc_2 < 12)
            {
                return "����";
            }// end if
            if (_loc_2 >= 12 && _loc_2 < 13)
            {
                return "����";
            }// end if
            if (_loc_2 >= 13 && _loc_2 < 18)
            {
                return "����";
            }// end if
            if (_loc_2 >= 18 && _loc_2 < 24)
            {
                return "����";
            }// end if
            return "�賿";
        }// end function

        public static function compare(param1:Date, param2:Date) : Number
        {
            var _loc_3:* = param1.getTime();
            var _loc_4:* = param2.getTime();
            return param2.getTime() - _loc_3;
        }// end function

        public static function num2cn(param1:String) : String
        {
            switch(param1)
            {
                case "0":
                {
                    return "";
                }// end case
                case "1":
                {
                    return "һ";
                }// end case
                case "2":
                {
                    return "��";
                }// end case
                case "3":
                {
                    return "��";
                }// end case
                case "4":
                {
                    return "��";
                }// end case
                case "5":
                {
                    return "��";
                }// end case
                case "6":
                {
                    return "��";
                }// end case
                case "7":
                {
                    return "��";
                }// end case
                case "8":
                {
                    return "��";
                }// end case
                case "9":
                {
                    return "��";
                }// end case
                default:
                {
                    return "";
                    break;
                }// end default
            }// end switch
        }// end function

        private static function convertTime2Array(param1:Number) : Array
        {
            if (param1 <= 0)
            {
                return null;
            }// end if
            var _loc_2:* = param1 / 1000;
            var _loc_3:* = new Array();
            var _loc_4:* = Math.round(_loc_2 / (24 * 3600));
            _loc_3.push({total:_loc_4});
            var _loc_5:* = _loc_2 / (30 * 24 * 3600);
            _loc_2 = _loc_2 % (30 * 24 * 3600);
            if (_loc_5 > 0)
            {
                _loc_3.push({months:_loc_5});
            }
            else
            {
                _loc_3.push({months:"00"});
            }// end else if
            var _loc_6:* = _loc_2 / (7 * 24 * 3600);
            _loc_2 = _loc_2 % (7 * 24 * 3600);
            if (_loc_6 > 0)
            {
                _loc_3.push({weeks:_loc_6});
            }
            else
            {
                _loc_3.push({weeks:"00"});
            }// end else if
            var _loc_7:* = _loc_2 / (24 * 3600);
            _loc_2 = _loc_2 % (24 * 3600);
            if (_loc_7 > 0)
            {
                _loc_3.push({days:_loc_7});
            }
            else
            {
                _loc_3.push({days:"00"});
            }// end else if
            var _loc_8:* = _loc_2 / 3600;
            _loc_2 = _loc_2 % 3600;
            if (_loc_8 > 0)
            {
                _loc_3.push({hours:_loc_8});
            }
            else
            {
                _loc_3.push({hours:"00"});
            }// end else if
            var _loc_9:* = _loc_2 / 60;
            _loc_2 = _loc_2 % 60;
            if (_loc_9 > 0)
            {
                _loc_3.push({minutes:_loc_9});
            }
            else
            {
                _loc_3.push({minutes:"00"});
            }// end else if
            if (Math.round(_loc_2) > 0)
            {
                _loc_3.push({secs:Math.round(_loc_2)});
            }
            else
            {
                _loc_3.push({secs:"00"});
            }// end else if
            return _loc_3;
        }// end function

        public static function getCountDown(param1:Date) : String
        {
            return convertTime(param1.getTime() - new Date().getTime());
        }// end function

        private static function addZero(param1:Number) : String
        {
            if (param1 <= 9 && param1 >= 0)
            {
                return "0" + param1;
            }// end if
            return param1.toString();
        }// end function

        public static function monthDayCn(param1:Date = null) : String
        {
            var _loc_2:String;
            if (!param1)
            {
                param1 = new Date();
            }// end if
            var _loc_3:* = format(param1, "MM-DD");
            var _loc_4:* = _loc_3.split("-");
            var _loc_5:* = String(_loc_4[0]).substr(0, 1);
            var _loc_6:* = String(_loc_4[0]).substr(1, 1);
            if (_loc_5 == "1")
            {
                _loc_2 = "ʮ";
            }// end if
            _loc_2 = _loc_2 + (num2cn(_loc_6) + "��");
            var _loc_7:* = String(_loc_4[1]).substr(0, 1);
            var _loc_8:* = String(_loc_4[1]).substr(1, 1);
            switch(_loc_7)
            {
                case "0":
                {
                    _loc_2 = _loc_2 + "";
                    break;
                }// end case
                case "1":
                {
                    _loc_2 = _loc_2 + "ʮ";
                    break;
                }// end case
                case "2":
                {
                    _loc_2 = _loc_2 + "��ʮ";
                    break;
                }// end case
                case "3":
                {
                    _loc_2 = _loc_2 + "��ʮ";
                    break;
                }// end case
                default:
                {
                    break;
                }// end default
            }// end switch
            _loc_2 = _loc_2 + (num2cn(_loc_8) + "��");
            return _loc_2;
        }// end function

        public static function getCountDown2Array(param1:Date) : Array
        {
            return convertTime2Array(param1.getTime() - new Date().getTime());
        }// end function

        public static function convert(param1:Number) : String
        {
            var _loc_2:* = param1 / 3600;
            var _loc_3:* = (param1 - _loc_2 * 3600) / 60;
            var _loc_4:* = (param1 - _loc_2 * 3600) % 60;
            return addZero(_loc_2) + ":" + addZero(_loc_3) + ":" + addZero(_loc_4);
        }// end function

        public static function week(param1:Boolean = true, param2:Date = null) : String
        {
            param2 = param2 ? (param2) : (new Date());
            var _loc_3:* = param2.getDay();
            return param1 ? (WEEKS_CN[_loc_3]) : (WEEKS_EN[_loc_3]);
        }// end function

        public static function format(param1:Date, param2:String) : String
        {
            if (param1 == null)
            {
                return "";
            }// end if
            param2 = param2.replace(/YYYY/g, param1.getFullYear());
            param2 = param2.replace(/MM/g, addZero(param1.getMonth() + 1));
            param2 = param2.replace(/DD/g, addZero(param1.getDate()));
            param2 = param2.replace(/HH/g, addZero(param1.getHours()));
            param2 = param2.replace(/MS/g, addZero(param1.getMinutes()));
            param2 = param2.replace(/SS/g, addZero(param1.getSeconds()));
            return param2;
        }// end function

        public static function CompareTime(param1:Date, param2:Date) : String
        {
            var _loc_3:* = param2.getTime() - param1.getTime();
            return convert(_loc_3 / 1000);
        }// end function

        public static function transDate(param1:String) : Date
        {
            var format:String;
            var str:* = param1;
            var add:* = 
function (param1:String) : void
{
    format = format + (param1 + " ");
    return;
}// end function
;
            trace("input: " + str);
            if (str == "" || str == null)
            {
                return null;
            }// end if
            format;
            var array:* = str.split(" ");
            add(array[0]);
            add(array[1]);
            add(array[2]);
            add(array[5]);
            add(array[3]);
            trace("format: " + format);
            return new Date(format);
        }// end function

        public static function compareDay(param1:Date, param2:Date) : int
        {
            var _loc_3:* = param1.getTime();
            var _loc_4:* = param2.getTime();
            return (param2.getTime() - _loc_3) / (24 * 60 * 60 * 1000);
        }// end function

        public static function formatByString(param1:String, param2:String) : String
        {
            var _loc_3:* = transDate(param1);
            return format(_loc_3, param2);
        }// end function

    }
}
