import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/models/favorite/favorite_provider.dart';
import 'package:wallpaper/models/theme/theme_provider.dart';
import 'package:wallpaper/view/wallpaper.dart';
import 'package:get/get.dart';


final mediaStorePlugin = MediaStore();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyBbHOC04QM7K1OZP3BZ9W5SQONlu4TZwO4',
    appId: '1:168857943149:android:3ab6da39f74e79cc9b5364',
    messagingSenderId: 'sendid',
    projectId: 'wallpaper-bea3c',
    storageBucket: 'wallpaper-bea3c.appspot.com',
  )
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );

  List<Permission> permissions = [
    Permission.storage,
  ];

  if ((await mediaStorePlugin.getPlatformSDKInt()) >= 33) {
    permissions.add(Permission.photos);
    // permissions.add(Permission.audio);
    // permissions.add(Permission.videos);
  }
  await permissions.request();
  MediaStore.appFolder = "MediaStorePlugin";
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: Wallpaper(),
    );
  }
}
