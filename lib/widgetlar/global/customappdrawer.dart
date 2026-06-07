import 'package:flutter/material.dart';
import '../../ekranlar/kategoriekrani.dart';
import '../../servisler/sqliteservice.dart';
import '../../servisler/sharedpreferencesservice.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  final SqliteService _sqliteService = SqliteService();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  
  Map<String, dynamic>? profilBilgisi;
  bool karanlikMod = false;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  Future<void> _verileriYukle() async {
   
    final data = await _sqliteService.getProfil();
    
   
    final tema = await _prefsService.temaGetir();
    
    setState(() {
      profilBilgisi = data;
      karanlikMod = tema;
    });
  }

  void _temaDegistir(bool deger) async {
    setState(() {
      karanlikMod = deger;
    });
    
    await _prefsService.temaKaydet(deger);
    
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            
            child: profilBilgisi == null
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(profilBilgisi!['fotoUrl'] ?? 'https://via.placeholder.com/150'),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      
                      Text(
                        "${profilBilgisi!['ad']} ${profilBilgisi!['soyad']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Text(
                        profilBilgisi!['eposta'],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.blue),
            title: const Text('Ana Sayfa'),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.orange),
            title: const Text('Kategoriler'),
            onTap: () {
              Navigator.pop(context);
            
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.orange),
            title: const Text('Kategoriler'),
            onTap: () {
              Navigator.pop(context); 
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KategoriEkrani()),
              );
            },
          ),
          const Divider(), 
         
          SwitchListTile(
            secondary: Icon(karanlikMod ? Icons.dark_mode : Icons.light_mode, color: karanlikMod ? Colors.deepPurple : Colors.amber),
            title: const Text('Karanlık Mod'),
            value: karanlikMod,
            onChanged: _temaDegistir,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Çıkış Yap'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}