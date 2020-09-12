import 'Hue.dart';

/**
 * Appareil Philips HUE : Ampoule connectée
 */
class Light {
  //Light(String id, String ip) : super(id, ip);

  bool on;
  String type;
  String name;
  String modelid;
  String productname;
  String productid;
  String uniqueid;
  String id;
  
  Light._builder(LightBuilder builder) : 
    type = builder.type,
    name = builder.name,
    modelid = builder.modelid;

  Light getLightByString(String str, Hue device) {
    Light l = ( new LightBuilder(device.id, device.ip)
                ..set_name('')
              ).build();
  }
}

/**
 * Builder Pattern
 */
class LightBuilder extends Hue {
  LightBuilder(String id, String ip) : super(id, ip);

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
    return Light._builder(this);
  }
}