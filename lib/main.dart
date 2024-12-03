import 'package:flutter/material.dart';
import 'package:google_sheets_api/api/sheets/inv_sheets_api.dart';
import 'package:google_sheets_api/screens/create_sheets_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InvSheetsApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheets Api Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CreateSheetsScreen(),
    );
  }
}
