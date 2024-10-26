import 'package:chimeup/Responsive/webscreen.dart';
import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'Providers/userProvider.dart';
import 'Responsive/responsive_layout.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyDscDijHBwMYvf7MyQi_GfNf5jEVAKdXDM",
            authDomain: "chimeup-8b7c7.firebaseapp.com",
            projectId: "chimeup-8b7c7",
            storageBucket: "chimeup-8b7c7.appspot.com",
            messagingSenderId: "549272076745",
            appId: "1:549272076745:web:fed886b866e80907cbe818",
            measurementId: "G-BS8GZYX9RY",
          )
        : null,
  );

  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chime',
          theme: ThemeData(
            fontFamily: "Poppins",
            scaffoldBackgroundColor: const Color(0xFF0F1523),
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ResponsiveLayouts(
                    mobileScreenLayout: const HomePage(),
                    webScreenLayout: Webscreen(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const SigninScreen();
            },
          ),
        );
      },
    );
  }
}
