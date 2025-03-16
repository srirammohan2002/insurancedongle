import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Stream<DatabaseEvent> getSensorData() {
    return _database.child("MPU6050").onValue..listen((event) {
      log("Data received: ${event.snapshot.value}");
    });
  }
}
