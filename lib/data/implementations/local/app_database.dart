import 'package:mvvm_project/data/implementations/local/password_hasher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final doPath = await getDatabasesPath();
    final path = join(doPath, 'mvvm_project.db');

    return openDatabase(
      path,
      version: 2, // nâng version để thêm bảng user namagement
      onCreate: (Database db, int version) async {
        // users: lưu username +  password_hash
        await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              user_name TEXT NOT NULL UNIQUE,
              password_hash TEXT NOT NULL
          );
          ''');

        // session : chỉ lưu 1 session đang đăng nhập (id=1)
        await db.execute('''
          CREATE TABLE session (
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id INTEGER NOT NULL,
            token TEXT NOT NULL,
            created_at TEXT NOT NULL
            );
            ''');

        // tạo bảng usermanagement
        await db.execute('''
          CREATE TABLE managed_users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            dob TEXT NOT NULL,
            address TEXT NOT NULL,
            created_at TEXT NOT NULL
            );
            ''');

        // migrate cho máy đã chạy version 1 trước đó
        onUpgrade:
        (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < 2) {
            await db.execute('''
          CREATE TABLE managed_users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            dob TEXT NOT NULL,
            address TEXT NOT NULL,
            created_at TEXT NOT NULL
            );
            ''');
          }
        };

        await db.insert('users', {
          'user_name': 'admin',
          'password_hash': PasswordHasher.sha256Hash('123456'),
        });
      },
    );
  }
}