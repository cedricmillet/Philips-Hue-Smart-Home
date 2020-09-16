
/**
 * Hue Package
 */
class Hue {      //  https://developers.meethue.com/develop/hue-api/
  
  /**
   * Debug
   */
  String toString() {
    String res = '';
    res += 'A simple Hue instance.';
    return res;
  }

  /**
   * usefull functions for childrens
   */
  static bool stringIsBoolean(String s) { s = s.toLowerCase();  return s=="true"||s=="false" ? true : false; }
  static bool string2Bool(String s) { return s.toLowerCase()=="true" ? true : false;  }
}


