import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/entities/bookmarks_dua.dart';

class DuaBookmarksAdapter extends TypeAdapter<BookmarksDua> {
  @override
  final int typeId = 9;

  @override
  BookmarksDua read(BinaryReader reader) {
    final duaId = reader.read();
    final duaNo = reader.read();
    final categoryId = reader.read();
    final categoryName = reader.read();
    final duaTitle = reader.read();
    final duaRef = reader.read();
    final ayahCount = reader.read();
    final duaText = reader.read();
    final duaTranslation = reader.read();
    final bookmarkPosition = reader.read();
    final duaUrl = reader.read();

    return BookmarksDua(
        duaId: duaId,
        duaNo: duaNo,
        categoryId: categoryId,
        categoryName: categoryName,
        duaTitle: duaTitle,
        duaRef: duaRef,
        ayahCount: ayahCount,
        duaText: duaText,
        duaTranslation: duaTranslation,
        bookmarkPosition: bookmarkPosition,
        duaUrl: duaUrl);
  }

  @override
  void write(BinaryWriter writer, BookmarksDua obj) {
    writer.write(obj.duaId);
    writer.write(obj.duaNo);
    writer.write(obj.categoryId);
    writer.write(obj.categoryName);
    writer.write(obj.duaTitle);
    writer.write(obj.duaRef);
    writer.write(obj.ayahCount);
    writer.write(obj.duaText);
    writer.write(obj.duaTranslation);
    writer.write(obj.bookmarkPosition);
    writer.write(obj.duaUrl);
  }
}
