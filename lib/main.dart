import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:palm/controller/palmreader_provider.dart';
import 'package:palm/view/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This is the main widget that runs the app.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The MultiProvider widget is used to provide instances of ChangeNotifier
    // classes to the widget tree.
    return MultiProvider(
      providers: [
        // The ChangeNotifierProvider widget is used to create and provide an
        // instance of the PalmReadingProvider class to the widget tree.
        ChangeNotifierProvider(create: (_) => PalmReadingProvider()),
        // Add other providers here if needed
      ],
      // The MaterialApp widget is the root of the app widget tree.
      child: const MaterialApp(
        // The PalmReadingScreen widget is the home screen of the app.
        home: PalmReadingScreen(),
      ),
    );
  }
}
