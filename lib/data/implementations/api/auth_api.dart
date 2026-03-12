import 'package:mvvm_project/data/dtos/login/user_dto.dart';
import 'package:mvvm_project/data/implementations/local/app_database.dart';
import 'package:mvvm_project/data/interfaces/api/iauth_api.dart';
import 'package:sqflite/sqflite.dart';

import '../../dtos/login/login_request_dto.dart';
import '../../dtos/login/login_response_dto.dart';
import '../local/password_hasher.dart';

class AuthApi implements IAuthApi {
  final AppDatabase database;

  AuthApi(this.database);
  @override
  Future<LoginResponseDto> login(LoginRequestDto req) async{
    final db = await database.db;

    final rows = await db.query(
      'users',
      where: 'user_name = ? ',
      whereArgs: [req.userName],
      limit: 1,
    );
    if(rows.isEmpty){
      throw Exception('Sai tài khoản hoặc mật khẩu');
    }

    final userRow = rows.first;
    final storedHash = (userRow['password_hash'] ?? '').toString();
    final inputHash = PasswordHasher.sha256Hash(req.password);

    if(storedHash != inputHash){
      throw Exception('Sai tài khoản hoặc mật khẩu');
    }

    // insert DB
    final userId = userRow['id'] as int;
    final token = 'token_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now().toIso8601String();
    await db.insert(
      'session',
      {
        'id' : 1,
        'user_id': userId,
        'token': token,
        'created_at': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final userDto = UserDto.fromMap(userRow); // user_name -> userName
    return LoginResponseDto(token: token, user: userDto);
  }

  @override
  Future<LoginResponseDto?> getCurrentSession() async{
    final db = await database.db;
    final s = await db.query('session', where: 'id=1', limit: 1);
    if(s.isEmpty) return null;

    final sessionRow = s.first;
    final userId = sessionRow['user_id'] as int;
    final token = (sessionRow['token'] ?? '').toString();

    final users = await db.query(
      'users',
      where: 'id=?',
      whereArgs: [userId],
      limit: 1,
    );
    if(users.isEmpty) return null;

    final userDto = UserDto.fromMap(users.first);
    return LoginResponseDto(token: token, user: userDto);
  }

  @override
  Future<void> logout() async {
    final db = await database.db;
    await db.delete('session', where: 'id=1');
  }
}
