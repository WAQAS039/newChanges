import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/entities/last_seen.dart';



class LastSeenAdapter extends TypeAdapter<LastSeen> {
  @override
  final int typeId = 1;

  @override
  LastSeen read(BinaryReader reader) {
    final surahNameArabic = reader.read();
    final surahName = reader.read();
    final surahEnglish = reader.read();
    final juzArabic = reader.read();
    final surahId = reader.read();
    final ayahId = reader.read();
    final lastSeen = reader.read();
    final isJuz = reader.read();
    final juzId = reader.read();
    return LastSeen(surahNameArabic: surahNameArabic,
        surahName: surahName,surahEnglish: surahEnglish,
        juzName: juzArabic,surahId: surahId,
        ayahId: ayahId,lastSeen: lastSeen,isJuz: isJuz,juzId: juzId);
  }

  @override
  void write(BinaryWriter writer, LastSeen obj) {
    writer.write(obj.surahNameArabic);
    writer.write(obj.surahName);
    writer.write(obj.surahEnglish);
    writer.write(obj.juzArabic);
    writer.write(obj.surahId);
    writer.write(obj.ayahId);
    writer.write(obj.lastSeen);
    writer.write(obj.isJuz);
    writer.write(obj.juzId);
  }
}
