import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/tasks/data/models/task_model.dart';
import '../../features/tasks/domain/entities/task_entity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE tasks (
      id INTEGER PRIMARY KEY,
      description TEXT NOT NULL,
      address TEXT NOT NULL,
      lat TEXT NOT NULL,
      lng TEXT NOT NULL,
      governorateId TEXT NOT NULL,
      date TEXT NOT NULL,
      media TEXT NOT NULL,
      statusId INTEGER NOT NULL,
      uploadStatus TEXT NOT NULL
    )''');
  }

  Future<int> insertTask(
    TaskEntity task,
    String uploadStatus,
  ) async {
    final db = await database;
    return await db.insert(
      'tasks',
      {
        'id': task.id,
        'description': task.description,
        'address': task.address,
        'lat': task.lat,
        'lng': task.lng,
        'governorateId': task.governorateId,
        'date': task.date,
        'media': task.media.join(','),
        'statusId': task.statusId,
        'uploadStatus': uploadStatus,
      },
    );
  }

  Future<List<TaskModel>> getWaitingTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'uploadStatus = ?',
      whereArgs: ['waiting'],
    );

    return List.generate(
      maps.length,
      (i) {
        return TaskModel(
          id: maps[i]['id'],
          description: maps[i]['description'],
          address: maps[i]['address'],
          lat: maps[i]['lat'],
          lng: maps[i]['lng'],
          governorateId: maps[i]['governorateId'],
          date: maps[i]['date'],
          media: maps[i]['media'].split(','),
          statusId: maps[i]['statusId'],
        );
      },
    );
  }

  Future<int> markTaskAsDeleted(int id) async {
    final db = await database;
    return await db.update(
      'tasks',
      {'uploadStatus': 'deleted'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskModel>> getDeletedTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'uploadStatus = ?',
      whereArgs: ['deleted'],
    );

    return List.generate(
      maps.length,
      (i) {
        return TaskModel(
          id: maps[i]['id'],
          description: maps[i]['description'],
          address: maps[i]['address'],
          lat: maps[i]['lat'],
          lng: maps[i]['lng'],
          governorateId: maps[i]['governorateId'],
          date: maps[i]['date'],
          media: maps[i]['media'].split(','),
          statusId: maps[i]['statusId'],
        );
      },
    );
  }

  Future<List<TaskEntity>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'uploadStatus != ?',
      whereArgs: ['deleted'],
    );

    return List.generate(
      maps.length,
      (i) {
        return TaskEntity(
          id: maps[i]['id'],
          description: maps[i]['description'],
          address: maps[i]['address'],
          lat: maps[i]['lat'],
          lng: maps[i]['lng'],
          governorateId: maps[i]['governorateId'],
          date: maps[i]['date'],
          media: maps[i]['media'].split(','),
          statusId: maps[i]['statusId'],
        );
      },
    );
  }

  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks');
  }

  Future<void> deleteAllWaitingTasks() async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'statusId = ?',
      whereArgs: ['waiting'],
    );
  }

  Future<void> deleteAllDeletedTasks() async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'statusId = ?',
      whereArgs: ['deleted'],
    );
  }

  Future<void> printAllTasks() async {
    // final List<TaskEntity> tasks = await getAllTasks();
    // print('I am printing the database contents');
    // for (var task in tasks) {
    //   print('-----------------------------------');
    //   print('task ID: ${task.id}');
    //   print('Description: ${task.description}');
    //   print('Address: ${task.address}');
    //   print('Latitude: ${task.lat}');
    //   print('Longitude: ${task.lng}');
    //   print('Governorate ID: ${task.governorateId}');
    //   print('Date: ${task.date}');
    //   print('Media: ${task.media.join(', ')}');
    //   print('Status ID: ${task.statusId}');
    //   print('-----------------------------------');
    // }
  }
}
