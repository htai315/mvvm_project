import '../../dtos/usermanagement/managed_user_dto.dart';
import '../../dtos/usermanagement/update_insert_user_request_dto.dart';
import '../../interfaces/api/Imanaged_user_api.dart';
import '../local/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ManagedUserApi implements IMangedUserApi {
  final AppDatabase database;

  ManagedUserApi(this.database);

  @override
  Future<List<ManagedUserDto>> getAll() async {
    final db = await database.db;
    final rows = await db.query('managed_users', orderBy: 'id DESC');
    return rows.map((e) => ManagedUserDto.fromMap(e)).toList();
  }

  @override
  Future<ManagedUserDto?> getById(int id) async {
    final db = await database.db;
    final rows = await db.query('managed_users', where: 'id = ?', whereArgs: [id],limit: 1);
    if(rows.isEmpty) return null;
    return ManagedUserDto.fromMap(rows.first);
  }

  @override
  Future<int> create(UpdateInsertUserRequestDto req)async {
    final db = await database.db;
    return db.insert('managed_users', req.toMapForInsert());
  }

  @override
  Future<int> update(int id, UpdateInsertUserRequestDto req) async{
    final db = await database.db;
    return db.update('managed_users', req.toMapForUpdate(),where: 'id=?',whereArgs: [id],);

  }

  @override
  Future<int> delete(int id) async{
    final db = await database.db;
    return db.delete('managed_users', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> seedDemoIfEmpty() async {
    final db = await database.db;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM managed_users'));
    if ((count ?? 0) > 0) {
      return ;
    }
    await db.insert('managed_users', {
      'full_name': 'Nguyễn Văn A',
      'dob': '01/01/2000',
      'address': 'Hà Nội',
      'created_at': DateTime.now().toIso8601String(),
    });
    await db.insert('managed_users', {
      'full_name': 'Nguyễn Văn b',
      'dob': '01/01/2000',
      'address': 'Hà Nội',
      'created_at': DateTime.now().toIso8601String(),
    });
    await db.insert('managed_users', {
      'full_name': 'Nguyễn Văn ca',
      'dob': '01/01/2000',
      'address': 'Hà Nội',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

}