import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/user_profile.dart';

class DevicesAdapter extends TypeAdapter<Devices> {
  @override
  final int typeId = 8; // or whatever free id you have
  @override
  Devices read(BinaryReader reader) {
    String name = reader.read();
    DateTime datetime = reader.read();
    return Devices(name: name,datetime: datetime);
  }

  @override
  void write(BinaryWriter writer, Devices obj){
    writer.write(obj.name);
    writer.write(obj.datetime);
  }
}
