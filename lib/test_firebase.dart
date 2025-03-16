import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseReference testRef = FirebaseDatabase.instance.ref("test");

  @override
  void initState() {
    super.initState();
    testConnection();
  }

  void testConnection() async {
    try {
      await testRef.set({"message": "Hello Firebase"});
      print("✅ Firebase connection successful!");
    } catch (e) {
      print("❌ Firebase connection failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Firebase Test")),
        body: Center(child: Text("Check Debug Console")),
      ),
    );
  }
}
