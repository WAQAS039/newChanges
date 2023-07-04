// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class UserDatabase{
//   //SQLite db
//   Database? _database;
//   static const String _databaseName = "userDatabase";
//   static const int _version = 1;
//
//   // tables
//   static const String _bookmarkTb = "bookmarks";
//   static const String _favReciterTb = "reciters";
//
//   // bookmark table fields
//   static const String _bookmarkId = "Id";
//   static const String _surahId = "surahId";
//   static const String _paraId = "paraId";
//   static const String _verseId = "verseId";
//   static const String _surahName = "surahName";
//   static const String _surahEnglish = "surahEng";
//   static const String _lastPosition = "lastPosition";
//
//   // favReciter table fields
//   static const String _reciterId = "reciterId";
//   static const String _reciterName = "reciterName";
//   static const String _recitationCount = "recitationCount";
//   static const String _downloadSurahList = "downloadSurahList";
//   static const String _imageUrl = "imageUrl";
//   static const String _audioUrl = "audioUrl";
//
//   Future<void> initDb() async {
//     String createTableBookmark = "Create Table $_bookmarkTb("
//         "$_bookmarkId integer primary key,"
//         "$_surahId integer,"
//         "$_paraId integer,"
//         "$_verseId integer,"
//         "$_surahName text,"
//         "$_surahEnglish text,"
//         "$_lastPosition integer);";
//     String createReciterTable = "create table $_favReciterTb("
//         "$_reciterId integer,"
//         "$_reciterName text,"
//         "$_recitationCount text default [114],"
//         "$_downloadSurahList text default [],"
//         "$_imageUrl text,"
//         "$_audioUrl text";
//     var userDb = await openDatabase(
//       join(await getDatabasesPath(),_databaseName),
//       version: _version,
//       onCreate: (db,dbVersion) async{
//         await db.execute(createTableBookmark);
//       }
//     );
//   }
// }