import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref("MPU6050");

  String accelX = "0";
  String accelY = "0";
  String accelZ = "0";
  String speed = "0";

  @override
  void initState() {
    super.initState();
    _listenToSensorData();
  }

  void _listenToSensorData() {
    _database.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          accelX = data['AccelX'].toString();
          accelY = data['AccelY'].toString();
          accelZ = data['AccelZ'].toString();
          speed = data['Speed'].toString();
        });
      }
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      Dashboard(accelX: accelX, accelY: accelY, accelZ: accelZ, speed: speed),
      TripHistoryScreen(),
      VehiclesScreen(),
      ProfileScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "Trips"),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: "Vehicles",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final String accelX, accelY, accelZ, speed;

  Dashboard({
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Company Logo at the top center
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              'assets/company_logo.png', // Provide your logo path
              height: 80, // Adjust the height
            ),
          ),
          CircularProgressIndicator(value: 0.0, strokeWidth: 6),
          SizedBox(height: 10),
          Text(
            "0%",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("2-Week Driving Score"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              infoCard("Total Trips", "0", Icons.directions_car),
              infoCard("Total Miles", "0.0", Icons.speed),
              infoCard("Speed (km/h)", speed, Icons.speed),
            ],
          ),
          SizedBox(height: 20),
          systemStatus(),
        ],
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget systemStatus() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "System Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("GPS Tracking"),
                Text("Active", style: TextStyle(color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sensor Connection"),
                Text("Disconnected", style: TextStyle(color: Colors.red)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Vehicle VIN"), Text("1HGCM82633A123456")],
            ),
          ],
        ),
      ),
    );
  }
}

class TripHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Trip History Coming Soon", style: TextStyle(fontSize: 20)),
    );
  }
}

class VehiclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Vehicle Details Coming Soon",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile Details Coming Soon",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
