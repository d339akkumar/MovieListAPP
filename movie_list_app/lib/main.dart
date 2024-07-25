import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDucvpFklPzcJwJpKvUar-1r2_eLMx5L0E",
            authDomain: "movielist-d7fa2.firebaseapp.com",
            projectId: "movielist-d7fa2",
            storageBucket: "movielist-d7fa2.appspot.com",
            messagingSenderId: "779050851164",
            appId: "1:779050851164:web:a07e672b80287f2160bf99",
            measurementId: "G-5K6065Z1TC"));
  } else {
    await Firebase.initializeApp();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveService.initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
