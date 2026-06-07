import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 

import '../widgetlar/global/customappbar.dart';
import '../modeller/icerikmodeli.dart';
import '../servisler/firebaseservice.dart';
import '../servisler/supabaseservice.dart';

class EkleEkrani extends StatefulWidget {
  const EkleEkrani({super.key});

  @override
  State<EkleEkrani> createState() => _EkleEkraniState();
}

class _EkleEkraniState extends State<EkleEkrani> {

  final FirebaseService firebaseService = FirebaseService();
  final SupabaseService supabaseService = SupabaseService();

  final baslikController = TextEditingController();
  final turController = TextEditingController();
  final aciklamaController = TextEditingController();
  final puanController = TextEditingController();

  File? secilenResim;
  bool yukleniyor = false; 

  
  Future<void> resimSec() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        secilenResim = File(pickedFile.path);
      });
    }
  }

  void kaydet() async {
   
    if (baslikController.text.isEmpty || secilenResim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen bir başlık girin ve resim seçin!")),
      );
      return;
    }

    setState(() {
      yukleniyor = true;
    });

    try {
   
      final dosyaAdi = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final resimUrl = await supabaseService.resimYukle(secilenResim!, dosyaAdi);

      if (resimUrl != null) {
  
        final yeniIcerik = IcerikModeli(
          baslik: baslikController.text,
          tur: turController.text,
          aciklama: aciklamaController.text,
          puan: double.tryParse(puanController.text) ?? 0.0,
          resim: resimUrl, 
        );

        
        await firebaseService.ekleIcerik(yeniIcerik);

      
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kaydedilirken bir hata oluştu.")),
      );
    } finally {
      setState(() {
        yukleniyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: const CustomAppBar(title: "Medya ve İçerik Arşivleme - Yeni Ekle"),
      
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
           
            GestureDetector(
              onTap: resimSec,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: secilenResim != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(secilenResim!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 50, color: Colors.blueAccent),
                          SizedBox(height: 10),
                          Text("Galeriden Resim Seç"),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(controller: baslikController, decoration: const InputDecoration(labelText: "Başlık", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: turController, decoration: const InputDecoration(labelText: "Tür (Örn: Film, Dizi, Kitap)", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: aciklamaController, decoration: const InputDecoration(labelText: "Açıklama", border: OutlineInputBorder()), maxLines: 3),
            const SizedBox(height: 10),
            TextField(controller: puanController, decoration: const InputDecoration(labelText: "Puan (Örn: 8.5)", border: OutlineInputBorder()), keyboardType: TextInputType.number),
            
            const SizedBox(height: 30),

          
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: yukleniyor ? null : kaydet,
                child: yukleniyor
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("İçeriği Kaydet", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}