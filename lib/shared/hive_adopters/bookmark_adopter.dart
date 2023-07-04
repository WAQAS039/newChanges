import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/entities/bookmarks.dart';

class BookmarksAdapter extends TypeAdapter<Bookmarks> {
  @override
  final int typeId = 3;

  @override
  Bookmarks read(BinaryReader reader) {
    final surahId = reader.read();
    final verseId = reader.read();
    final surahName = reader.read();
    final surahArabic = reader.read();
    final juzId = reader.read();
    final juzName = reader.read();
    final isFromJuz = reader.read();
    final bookmarkPosition = reader.read();

    return Bookmarks(
        surahId: surahId,
        verseId: verseId,
        surahName: surahName,
        surahArabic: surahArabic,
        juzId: juzId,
        juzName: juzName,
        isFromJuz: isFromJuz,
        bookmarkPosition: bookmarkPosition);
  }

  @override
  void write(BinaryWriter writer, Bookmarks obj) {
    writer.write(obj.surahId);
    writer.write(obj.verseId);
    writer.write(obj.surahName);
    writer.write(obj.surahArabic);
    writer.write(obj.juzId);
    writer.write(obj.juzName);
    writer.write(obj.isFromJuz);
    writer.write(obj.bookmarkPosition);
  }
}
