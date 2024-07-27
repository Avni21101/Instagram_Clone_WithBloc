import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp();
    const FirebaseOptions(
        apiKey: 'AIzaSyBJuzFGC4qjfRoUTjMz1b_-ctHUcYGk0-c',
        appId: '1:794732043390:web:fb4c2f0f5b4af3c1fa0c2f',
        messagingSenderId: '794732043390',
        projectId: 'instagram-clone-76408',
        storageBucket:'instagram-clone-76408.appspot.com'
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const InstagramApp());
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
