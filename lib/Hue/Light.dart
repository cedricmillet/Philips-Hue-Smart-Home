
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

  //  Setters
  void set_on(bool s)             { _on = s; }
  void set_type(String s)         { _type = s; }
  void set_name(String s)         { _name = s; }
  void set_modelid(String s)      { _modelid = s; }
  void set_productname(String s)  { _productname = s; }
  void set_productid(String s)    { _productid = s; }
  void set_uniqueid(String s)     { _uniqueid = s; }
  
  //  Getters
  bool get_on()             => _on;
  String get_type()         => _type;
  String get_name()         => _name;
  String get_modelid()      => _modelid;
  String get_productname()  => _productname; 
  String get_productid()    => _productid;
  String get_uniqueid()     => _uniqueid;


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

  Future<bool> off() async {
    print(">> OFF()");
    return await this.toggleState(false);
  }

  Future<bool> on() async {
    print(">> ON()");
    return await this.toggleState(true);
  }

  Future<bool> toggleState(bool state) async {
    if(this.username==null) throw 'Cannot toggleState() without valid username.';

    final url = 'http://${ip}/api/${username}/lights/${_uid.toString()}/state';
    print(url + " - " + state.toString());
    var res = await http.put(url, body: '{"on": ${state == false ? "false" : "true"}}');
    if( res.statusCode != 200 
        || res.body.contains('error')
        || !res.body.contains('success')  ) {
      print( "Light.toggleState(flag) ERROR : " + res.toString() );
      return false;
    }
    return true;
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


