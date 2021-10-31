import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/list_etudiants.dart';
import 'models/scol_list.dart';

class dbuse {
  /*# This will make it easier to update the database*/
  final int version = 1;
  Database db;
  static final dbuse _dbHelper = dbuse._internal();
  dbuse._internal();
  factory dbuse() {
    return _dbHelper;
  }

Future<Database> openDb() async {
 if (db == null) {
 db = await openDatabase(join(await getDatabasesPath(), 'scol.db'),
 onCreate: (database, version) {
 database.execute( 'CREATE TABLE classes(codClass INTEGER PRIMARY KEY, nomClass TEXT, nbreEtud INTEGER)');
 database.execute( 'CREATE TABLE etudiants(id INTEGER PRIMARY KEY, codClass INTEGER,nom TEXT, prenom TEXT, datNais TEXT, ' + 'FOREIGN KEY(codClass) REFERENCES classes(codClass))');
 }, version: version);
 }
 return db;
}

  Future testDb() async {
 db = await openDb();
 await db.execute('INSERT INTO classes VALUES (0, "DSI23", 20)');
 await db.execute('INSERT INTO etudiants VALUES (0, 0, "haouet", "amira", "30/12/1998")');
  await db.execute('INSERT INTO etudiants VALUES (1, 0, "haxxxouet", "xxx", "30/12/1998")');

 List classes = await db.rawQuery('select * from classes');
 List etudiants = await db.rawQuery('select * from etudiants');
 print(classes[0].toString());
 print(etudiants[0].toString());
}
Future<List<ScolList>> getClasses() async {
 final List<Map<String, dynamic>> maps = await db.query('classes');
 return List.generate(maps.length, (i) {
 return ScolList(
 maps[i]['codClass'],
 maps[i]['nomClass'],
 maps[i]['nbreEtud'],
 );
 });
}
Future<List<ListEtudiants>> getEtudiants(code) async {
 final List<Map<String, dynamic>> maps =

 await db.query('etudiants', where: 'codClass = ?', whereArgs:[code]);
 return List.generate(maps.length, (i) {
 return ListEtudiants(
 maps[i]['id'],
 maps[i]['codClass'],
 maps[i]['nom'],
 maps[i]['prenom'],
 maps[i]['datNais'],
 );
 });
}

}
