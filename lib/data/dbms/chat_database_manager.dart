import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/conversation.dart';

class ChatDatabaseManager {
  static final ChatDatabaseManager _instance = ChatDatabaseManager._internal();
  static ChatDatabaseManager get instance => _instance;
  ChatDatabaseManager._internal();
  static var _database;
  final String databaseName = "chat.db";
  int _timestamp = DateTime.now().millisecondsSinceEpoch;
  Future<void> init() async {
    if (_database != null) {
      return;
    } else {
      try {
        String path = join(await getDatabasesPath(), databaseName);
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
          CREATE TABLE conversation$_timestamp (
            prompt TEXT,
            number INTEGER,
            date TEXT
          )
        ''');
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }
  Future<void> close() async {
    if (_database != null) {
      await _database.close();
      _database = null;
    }
  }
  Future<void> add(Conversation conversation, String tableName) async {
    await _database.insert(
      tableName,
      conversation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<dynamic>> getAllTableNames() async {
    // get a list of the tables in the database
    List<Map<String, dynamic>> tables =
    await _database.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    // extract the table names from the list of maps
    List<dynamic> tableNames = tables.map((table) => table['name']).toList();
    tableNames.removeWhere((name) => name == 'android_metadata');
    return tableNames;
  }
  Future<List<Conversation>> getAllFromTable(String tableName) async {
    // get the contents of the table
    final List<Map<String, dynamic>> maps = await _database.query(tableName);
    // convert the list of maps to a list of conversations
    return List.generate(maps.length, (i) => Conversation.fromMap(maps[i]));
  }


  Future<void> dropTable(String tableName) async {
    await _database.execute('''
      DROP TABLE $tableName
    ''');
  }


  Future<void> createTableWithTimestamp() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String tableName = 'conversation$timestamp';
    await _database.execute('''
      CREATE TABLE $tableName (
            prompt TEXT,
            number INTEGER,
            date TEXT
      )
    ''');
  }


}