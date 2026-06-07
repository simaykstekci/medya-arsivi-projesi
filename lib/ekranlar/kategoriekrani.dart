import 'package:flutter/material.dart';
import '../widgetlar/global/customappbar.dart';

class KategoriEkrani extends StatelessWidget {
  const KategoriEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Medya ve İçerik Arşivleme - Kategoriler"),
      body: Center(
        child: Text(
          "Kategoriler yakında eklenecek...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}