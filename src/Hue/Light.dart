
import 'package:http/http.dart' as http;
import 'Hue.dart';

/**
 * Appareil Philips HUE : Ampoule connectée
 */
class Light extends Hue {
  Light(String id, String ip, String username) : super(id, ip, username: username);
  //  Numéro pour les appels api --> /lights/${uid}/state
  int _uid;
    void setUID(int i) {
    _uid = i;
  }

  //  Attributs des ampoules
  bool _on;
  String _type;
  String _name;
  String _modelid;
  String _productname;
  String _productid;
  String _uniqueid;


  void set_on(bool s)             { this._on = s; }
  void set_type(String s)         { this._type = s; }
  void set_name(String s)         { this._name = s; }
  void set_modelid(String s)      { this._modelid = s; }
  void set_productname(String s)  { this._productname = s; }
  void set_productid(String s)    { this._productid = s; }
  void set_uniqueid(String s)     { this._uniqueid = s; }
  
  
  /*
  Light._builder(LightBuilder builder) : 
    on = builder.on,
    type = builder.type,
    name = builder.name,
    modelid = builder.modelid;

  Light getLightByString(String str, Hue device) {
    Light l = ( new LightBuilder(device.id, device.ip, device.username)
                ..set_name('')
              ).build();
  }*/

  String toString() {
    return '''
      --- LIGHT (uid=${this._uid}) ---
      ON:\t\t${this._on.toString()}
      TYPE:\t\t${this._type}
      NAME:\t\t${this._name}
      MODELID:\t\t${this._modelid}
      PRODUCT_NAME:\t${this._productname}
      PRODUCT_ID:\t${this._productid}
      UNIQUE_ID:\t${this._uniqueid}
    ''';
  }

  void off() async {
    print(">> OFF()");
    await this.toggleState(false);
  }

  void on() async {
    print(">> ON()");
    await this.toggleState(true);
  }

  void toggleState(bool state) async {
    var url = 'http://${ip}/api/${username}/lights/${_uid.toString()}/state';
    var res = await http.put(url, body: '{"on": ${state == false ? "false" : "true"}}');
    if(res.statusCode != 200 || res.body.contains('error')) throw 'ERREUR toggleState() !';
  }





  
}

/**
 * Builder Pattern --> build with Java extension
 */
class LightBuilder extends Hue {
  LightBuilder(String id, String ip, String username) : super(id, ip, username: username);

  bool on;
  String type;
  String name;
  String modelid;
  String productname;
  String productid;
  String uniqueid;

  void set_on(bool state) {   this.on = state;    }
  void set_type(String type) {   this.type = type;    }
  void set_name(String name) {   this.name = name;    }
  void set_modelid(String modelid) {   this.modelid = modelid;    }

  Light build() {
    //return Light._builder(this);
  }
}


