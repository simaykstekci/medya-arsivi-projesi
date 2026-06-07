import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'profil.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE profil (
            id INTEGER PRIMARY KEY,
            ad TEXT,
            soyad TEXT,
            eposta TEXT,
            fotoUrl TEXT
          )
        ''');
        
        await db.insert('profil', {
          'id': 1,
          'ad': 'Simay',
          'soyad': 'Köstekci', 
          'eposta': '030724074@std.izu.edu.tr',
         
          'fotoUrl': 'https://qjcyinexdhmyrcnpgojh.supabase.co/storage/v1/object/public/medya_resimleri/IMG_6562.jpg' 
        });
      },
    );
  }

  Future<Map<String, dynamic>?> getProfil() async {
    final veritabani = await db;
    final List<Map<String, dynamic>> maps = await veritabani.query('profil', limit: 1);
    if (maps.isNotEmpty) return maps.first;
    return null;
  }
}