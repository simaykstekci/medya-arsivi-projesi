import 'package:flutter/material.dart';
import '../modeller/icerikmodeli.dart';

class DetayEkrani extends StatelessWidget {
  final IcerikModeli icerik;

  const DetayEkrani({super.key, required this.icerik});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(icerik.baslik)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(icerik.resim),
            const SizedBox(height: 10),
            Text(
              icerik.tur,
              style: const TextStyle(fontSize: 18),
            ),
            Text("⭐ ${icerik.puan}"),
            const SizedBox(height: 10),
            Text(icerik.aciklama),
          ],
        ),
      ),
    );
  }
}