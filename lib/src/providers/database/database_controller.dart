import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sjw_v1/src/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends ChangeNotifier {
  //==========================================
  var database;

  //==========================================

  //==========================================
  //User 테이블의 row 값들을 저장할 변수듫
  int _nNo = -1;

  int get nNo => _nNo;
  String _strId = '';

  String get strId => _strId;
  String _strName = '';

  String get strName => _strName;
  String _strPw = '';

  String get strPw => _strPw;

  //==========================================

  //==========================================
  //데이터 베이스를 생성하고 테이블을 만든다
  openDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'sjw.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(no INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, id TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  //==========================================

  //==========================================
  //user 테이블에 데이터 값 입력
  Future<void> insertUser(User user) async {
    final db = await database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  //==========================================

  //==========================================
  //user 테이블의 레코드 모두 출력
  Future<void> showUserList() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    for (int i = 0; i < maps.length; i++) {
      print('name : ${maps[i]['id']}');
    }
  }

  //==========================================

  //==========================================
  //user 테이블의 레코드 중 id 값으로 비교하여 하나의 레코드를 가져와 변수에 저장
  getUser(String id) async {
    final db = await database;

    List<Map> res = await db.rawQuery('SELECT * FROM users WHERE id = ?', [id]);

    if (res != null) {
      res.forEach((row) {
        _nNo = row['no'];
        _strName = row['name'];
        _strId = row['id'];
        _strPw = row['password'];

        notifyListeners();
      });
    } else {
      return null;
    }
  }

  //==========================================

  //==========================================
  //user 테이블의 레코드 값 변경
  Future<void> updateUser(User user) async {
    final db = await database;

    await db.update(
      'users',
      user.toMap(),
      where: 'no = ?',
      whereArgs: [user.no],
    );

    notifyListeners();
  }

  //==========================================

  //==========================================
  //user 테이블의 레코드 삭제
  Future<void> deleteUser(int no) async {
    final db = await database;

    await db.delete(
      'users',
      where: 'no = ?',
      whereArgs: [no],
    );
  }
//==========================================
}
