import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import 'package:menu_digital/screens/menu_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'services/notification_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();

  // Verifica se há um payload ao iniciar o app
  NotificationService().getInitialPayload().then((payload) {
    if (payload != null) {
      handleNotificationPayload(payload);
    }
  });

  runApp(const ProviderScope(child: MyApp()));
}

void handleNotificationPayload(String payload) {
  if (payload == "pedido_finalizado") {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthWrapper()), 
      (route) => false,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, 
      theme: theme,
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao verificar login.'));
        } else if (snapshot.hasData) {
          return const MenuScreen(); // Usuário logado, vai para a tela do menu
        } else {
          return LoginScreen(); // Usuário não logado, vai para a tela de login
        }
      },
    );
  }
}