import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://ndwibjmqdxpraepsqvlo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5kd2liam1xZHhwcmFlcHNxdmxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI3MTY2NjgsImV4cCI6MjA4ODI5MjY2OH0.U_JMqLa63Ce272yRNFQrSlqRTsr96DpqnrBAcN8RpKo',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pet Breed AI",
      theme: ThemeData(
        primaryColor: const Color(0xFF6366F1),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const MySplash(),
    );
  }
}