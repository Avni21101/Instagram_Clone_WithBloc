import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/blocs/user-authentication-bloc/app_bloc.dart';
import 'package:instagram_clone/repository/authentication_repository/authentication_repository.dart';
import 'package:instagram_clone/responsive_layouts/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive_layouts/responsive_layout.dart';
import 'package:instagram_clone/responsive_layouts/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp();
    const FirebaseOptions(
        apiKey: 'AIzaSyBJuzFGC4qjfRoUTjMz1b_-ctHUcYGk0-c',
        appId: '1:794732043390:web:fb4c2f0f5b4af3c1fa0c2f',
        messagingSenderId: '794732043390',
        projectId: 'instagram-clone-76408',
        storageBucket: 'instagram-clone-76408.appspot.com');
  } else {
    await Firebase.initializeApp();
  }
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(InstagramApp(authenticationRepository: authenticationRepository));
}

class InstagramApp extends StatelessWidget {
  const InstagramApp(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (context) => AppBloc(authenticationRepository: _authenticationRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      ),
    );
  }
}
