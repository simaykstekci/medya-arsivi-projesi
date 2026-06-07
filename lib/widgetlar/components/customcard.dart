import 'package:flutter/material.dart';
import '../../modeller/icerikmodeli.dart';

class CustomCard extends StatelessWidget {
  final IcerikModeli icerik;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CustomCard({
    super.key,
    required this.icerik,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Image.network(
          icerik.resim,
          width: 60,
          fit: BoxFit.cover,
        ),
        title: Text(icerik.baslik),
        subtitle: Text("${icerik.tur} - ⭐ ${icerik.puan}"),
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}