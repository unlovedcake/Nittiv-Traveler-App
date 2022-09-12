import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Pages/Login-Page/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Core/Router/route-generator.dart';
import 'Core/Router/routesname.dart';
import 'Core/Utils/nittive-theme.dart';
import 'ENV/env.dart';
import 'Provider/auth-provider.dart';
import 'Provider/comment-provider.dart';
import 'Provider/posts-provider.dart';
// import 'Router/route-generator.dart';
// import 'Router/routesname.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {



  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      authDomain: authDomain,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PostsProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nittiv',
      debugShowCheckedModeBanner: false,
      theme: NittivTheme().lightTheme,
      home: Login(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RoutesName.LOGIN_URL,
    );
  }
}
