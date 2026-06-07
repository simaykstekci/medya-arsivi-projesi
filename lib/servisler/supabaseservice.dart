import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;
  
  final String bucketAdi = 'medya_resimleri'; 

  Future<String?> resimYukle(File resimDosyasi, String dosyaAdi) async {
    try {
     
      final imagePath = '/$dosyaAdi';
      await _supabase.storage.from(bucketAdi).upload(imagePath, resimDosyasi);
      
      
      final imageUrl = _supabase.storage.from(bucketAdi).getPublicUrl(imagePath);
      
      debugPrint("Resim başarıyla Supabase'e yüklendi: $imageUrl");
      return imageUrl;
      
    } catch (e) {
      debugPrint("Resim yüklenirken hata oluştu: $e");
      return null;
    }
  }
}