import 'package:flutter/material.dart';
import 'package:pacego/provider/dropprovider.dart';
import 'package:pacego/provider/pickprovider.dart';
import 'package:pacego/screensfolder/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:pacego/provider/userprovider.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider
    (providers: [
      // user provider
      ChangeNotifierProvider(create: (_) => UserProvider(),
      ),

      ChangeNotifierProvider(create: (_)=> PickupProvider(),
      ),

      ChangeNotifierProvider(create: (_) => DropOffProvider(),
      ),




    ], child: const MyApp(),
  
    ),
  
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );

  }
}
