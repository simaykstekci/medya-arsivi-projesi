import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'firebase_options.dart'; 

import 'widgetlar/global/custombottomnavbar.dart'; 


final supabase = Supabase.instance.client;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  await Supabase.initialize(
    url: 'https://qjcyinexdhmyrcnpgojh.supabase.co',
    anonKey: 'sb_publishable_f-rXqtrWi_OZeC6-I22guQ_zO-6mu56',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medya ve İçerik Arşivleme',
      home: CustomBottomNavBar(),
    );
  }
}