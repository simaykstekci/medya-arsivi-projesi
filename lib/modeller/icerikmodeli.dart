class IcerikModeli {
  String? id; 
  String baslik;
  String tur;
  String aciklama;
  double puan;
  String resim;

  IcerikModeli({
    this.id,
    required this.baslik,
    required this.tur,
    required this.aciklama,
    required this.puan,
    required this.resim,
  });

  factory IcerikModeli.fromJson(Map<String, dynamic> json) {
    return IcerikModeli(
      id: json['id'],
      baslik: json['baslik'],
      tur: json['tur'],
      aciklama: json['aciklama'],
      puan: (json['puan'] as num).toDouble(),
      resim: json['resim'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baslik': baslik,
      'tur': tur,
      'aciklama': aciklama,
      'puan': puan,
      'resim': resim,
    };
  }
}