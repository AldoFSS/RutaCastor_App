import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/lista_edificios_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCVU3sQI50xTFxGLAB0l2hFehhCwC8pzlY",
      appId: "1:315666306022:web:595384c2f58f32d294fc27",
      messagingSenderId: "315666306022",
      projectId: "rutacastorbd",
    ),
  );

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RutaCastorBD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ListaEdificiosScreen(),
    );
  }
}