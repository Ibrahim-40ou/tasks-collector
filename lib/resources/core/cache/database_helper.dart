import 'dart:async';
import 'package:abm/resources/features/complaints/data/models/complaint_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/complaints/domain/entities/complaint_entity.dart';

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
    String path = join(await getDatabasesPath(), 'complaints.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE complaints (
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

  Future<int> insertComplaint(
    ComplaintEntity complaint,
    String uploadStatus,
  ) async {
    final db = await database;
    return await db.insert(
      'complaints',
      {
        'id': complaint.id,
        'description': complaint.description,
        'address': complaint.address,
        'lat': complaint.lat,
        'lng': complaint.lng,
        'governorateId': complaint.governorateId,
        'date': complaint.date,
        'media': complaint.media.join(','),
        'statusId': complaint.statusId,
        'uploadStatus': uploadStatus,
      },
    );
  }

  Future<List<ComplaintModel>> getWaitingComplaints() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'complaints',
      where: 'uploadStatus = ?',
      whereArgs: ['waiting'],
    );

    return List.generate(
      maps.length,
      (i) {
        return ComplaintModel(
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

  Future<int> markComplaintAsDeleted(int id) async {
    final db = await database;
    return await db.update(
      'complaints',
      {'uploadStatus': 'deleted'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<List<ComplaintModel>> getDeletedComplaints() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'complaints',
      where: 'uploadStatus = ?',
      whereArgs: ['deleted'],
    );

    return List.generate(
      maps.length,
      (i) {
        return ComplaintModel(
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

  Future<List<ComplaintEntity>> getAllComplaints() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'complaints',
      where: 'uploadStatus != ?',
      whereArgs: ['deleted'],
    );

    return List.generate(
      maps.length,
      (i) {
        return ComplaintEntity(
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

  Future<int> deleteAllComplaints() async {
    final db = await database;
    return await db.delete('complaints');
  }

  Future<void> deleteAllWaitingComplaints() async {
    final db = await database;
    await db.delete(
      'complaints',
      where: 'statusId = ?',
      whereArgs: ['waiting'],
    );
  }

  Future<void> deleteAllDeletedComplaints() async {
    final db = await database;
    await db.delete(
      'complaints',
      where: 'statusId = ?',
      whereArgs: ['deleted'],
    );
  }

  Future<void> printAllComplaints() async {
    final List<ComplaintEntity> complaints = await getAllComplaints();
    print('I am printing the database contents');
    for (var complaint in complaints) {
      print('-----------------------------------');
      print('Complaint ID: ${complaint.id}');
      print('Description: ${complaint.description}');
      print('Address: ${complaint.address}');
      print('Latitude: ${complaint.lat}');
      print('Longitude: ${complaint.lng}');
      print('Governorate ID: ${complaint.governorateId}');
      print('Date: ${complaint.date}');
      print('Media: ${complaint.media.join(', ')}');
      print('Status ID: ${complaint.statusId}');
      print('-----------------------------------');
    }
  }
}
