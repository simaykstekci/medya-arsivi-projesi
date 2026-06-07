import 'package:flutter/material.dart';

import '../widgetlar/global/customappbar.dart';
import '../widgetlar/global/customappdrawer.dart'; 
import '../servisler/firebaseservice.dart';
import '../modeller/icerikmodeli.dart';
import '../widgetlar/components/customcard.dart';
import 'detayekrani.dart'; 

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  
  final service = FirebaseService();

  late Future<List<IcerikModeli>> liste;

  @override
  void initState() {
    super.initState();
    _listeyiYenile();
  }

  void _listeyiYenile() {
    setState(() {
      liste = service.getIcerikler();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Medya ve İçerik Arşivleme"),
      drawer: const CustomAppDrawer(),
      
      body: FutureBuilder<List<IcerikModeli>>(
        future: liste,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Henüz bir içerik eklenmedi."));
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              return CustomCard(
                icerik: items[i], 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetayEkrani(icerik: items[i]),
                    ),
                  );
                },
                onDelete: () async {
                  if (items[i].id != null) {
                  
                    await service.silIcerik(items[i].id!);
                    _listeyiYenile(); 
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}