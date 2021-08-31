import 'dart:io';
import 'package:flutsql/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final dbname = "notes.db";
  static final dbversion = 1;
  static final noteTable = "note_table";
  String colId = 'id';
	String colTitle = 'title';
	String colDescription = 'description';
	String colPriority = 'priority';
	String colDate = 'date';

  DatabaseHelper._privateConstructor();
  static DatabaseHelper instance = DatabaseHelper._privateConstructor();


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (instance == null) {
			instance = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return instance;
	}


  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbname);
    return await openDatabase(path, version: dbversion, onCreate: onCreate);
  }

  Future onCreate(Database db, int dbversion) async {
    return await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  Future<int> insertNote(Note note) async {
    Database? db = await instance.database;
    var result = await db!.insert(noteTable, note.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(noteTable);
  }

  Future<int> updateNote(Note note) async {
    Database? db = await instance.database;
    var result = await db!.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database? db = await instance.database;
    return await db!.delete(noteTable, where: '$colId=?', whereArgs: [id]);
  }

  Future<int?> getCount() async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }
  // Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getNoteMapList() async {
		Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db!.query(noteTable, orderBy: '$colPriority ASC');
		return result;
	}

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Note>> getNoteList() async {

		var noteMapList = await getNoteMapList(); // Get 'Map List' from database
		int count = noteMapList.length;         // Count the number of map entries in db table

		List<Note> noteList = <Note>[];
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			noteList.add(Note.fromMapObject(noteMapList[i]));
		}

		return noteList;
	}


}