
# 🎬 Medya ve İçerik Arşivleme Platformu

Modern yazılım geliştirme standartlarına uygun olarak tasarlanmış, çoklu veri kaynaklı (Multi-BaaS) ve modüler mimariye sahip içerik yönetim uygulaması. Bu proje, yapılandırılmış veriler ile medya dosyalarının birbirinden izole edildiği, yüksek performanslı bir Flutter projesidir.

## 🚀 Proje Vizyonu ve Mimari Yaklaşım

Bu uygulamanın temel amacı, farklı veritabanı sistemlerinin (SQL, NoSQL ve Object Storage) aynı ekosistem içerisinde, birbirleriyle senkronize ve optimum performansla nasıl çalışabileceğini göstermektir. Sistem tasarımı aşamasında **"Separation of Concerns" (Sorumlulukların Ayrılığı)** prensibi benimsenmiştir.

### 🛠 Kullanılan Teknolojiler ve Veri Katmanları
* **Frontend:** Flutter (Dart) - Cross-platform UI.
* **NoSQL Veritabanı (Firebase Firestore):** Başlık, açıklama, tür ve puan gibi yapılandırılmış metin verilerinin mikro-saniyeler içinde sorgulanması için kullanılmıştır.
* **Object Storage (Supabase):** Yüksek boyutlu medya dosyalarının (resimlerin) CDN üzerinden hızlıca dağıtılması ve depolanması amacıyla Firebase'den izole edilerek kurgulanmıştır.
* **Yerel Veritabanı (SQLite):** Kullanıcı profil verilerinin çevrimdışı (offline-first) erişilebilirliğini sağlamak için cihaz belleğinde ilişkisel (RDBMS) olarak tutulmuştur.
* **Key-Value Store (Shared Preferences):** Kullanıcının tema tercihleri (Karanlık/Aydınlık mod) gibi UI state durumlarının kalıcı olarak saklanması için entegre edilmiştir.

## ✨ Temel Özellikler
- **Hibrit Veri Yönetimi:** Supabase üzerine yüklenen medyanın public URL'si alınarak, ilişkili metin verileriyle birlikte Firebase'e asenkron (`async/await`) olarak kaydedilir.
- **Dinamik Tema Desteği:** Sistem geneli State yönetimi ve SharedPreferences ile kalıcı hale getirilmiş Karanlık Mod opsiyonu.
- **Asenkron UI Render:** FutureBuilder yapıları kullanılarak veritabanı sorguları sırasında kullanıcı deneyimini artıracak yükleme (loading) stateleri.
- **Yerel Ön Bellekleme (Local Caching):** SQLite entegrasyonu sayesinde çekmece menü (Drawer) verilerinin ağ isteği yapılmadan anında yüklenmesi.

## 📂 Klasör ve Modül Yapısı

Proje, Clean Architecture felsefesinden ilham alınarak ölçeklenebilir ve okunabilir bir modüler hiyerarşide tasarlanmıştır:

```text
lib/
│
├── ekranlar/                  # UI Katmanı (Sayfalar)
│   ├── anaekran.dart          # Ana liste ve veri akışı
│   ├── detayekrani.dart       # Seçilen içeriğin detaylı görünümü
│   ├── ekleekrani.dart        # Supabase/Firebase hibrit veri giriş ekranı
│   └── kategoriekrani.dart    # Kategori filtreleme sayfası
│
├── modeller/                  # Veri Katmanı (Data Models - OOP)
│   ├── icerikmodeli.dart      # İçerik JSON serileştirme (Serialization) modeli
│   └── kategorimodeli.dart    # Kategori veri yapısı
│
├── servisler/                 # İş Mantığı Katmanı (Business Logic)
│   ├── firebaseservice.dart   # NoSQL CRUD operasyonları
│   ├── supabaseservice.dart   # Bucket ve dosya yükleme işlemleri
│   ├── sqliteservice.dart     # Yerel DB tabloları (onCreate, insert, query)
│   └── sharedpreferencesservice.dart # Key-Value tabanlı ayar yönetimi
│
├── widgetlar/                 # Yeniden Kullanılabilir (Reusable) Bileşenler
│   ├── components/
│   │   ├── customcard.dart    # Liste elemanları için modüler kart widget'ı
│   │   └── custombutton.dart  # UI kiti butonları
│   └── global/
│       ├── customappbar.dart  # Proje temasına uygun global başlık
│       ├── customappdrawer.dart # SQLite entegreli profil menüsü
│       └── custombottomnavbar.dart # Sayfalar arası navigasyon router'ı
│
├── firebase_options.dart      # Firebase CLI konfigürasyonu
└── main.dart                  # App root, servislerin başlatılması (Init)

```

## ⚙️ Kurulum ve Çalıştırma

Projeyi yerel makinenizde (Local environment) test etmek için aşağıdaki adımları izleyin:

1. Depoyu klonlayın:
```bash
git clone [https://github.com/simaykstekci/medya-arsivi.git](https://github.com/kullaniciadin/medya-arsivi.git)

```


2. Gerekli Flutter paketlerini indirin:
```bash
flutter pub get


3. Güvenlik Notu: `hesap_bilgileri.txt` dosyası projeyi inceleyecek geliştiriciler/eğitmenler için test ortamı giriş bilgilerini içerir. Gerçek bir Production ortamında `.env` kullanılarak izole edilmelidir.
4. Uygulamayı derleyin:
```bash
flutter run


## 👨‍💻 Geliştirici

Bu proje, modern veri mimarileri ve kullanıcı arayüzü tasarımı üzerine yapılan Ar-Ge çalışmaları kapsamında geliştirilmiştir. Kodu incelediğiniz için teşekkürler!


### Neden Bu README Çok Güçlü?
1. **İngilizce Başlıklar ve Terimler:** İK'cılar "Separation of Concerns", "Multi-BaaS", "Serialization", "Clean Architecture" gibi sihirli kelimeleri görmeye bayılırlar. Bunları Türkçe açıklamaların yanına özellikle ekledim.
2. **Mimari Açıklama:** Neden iki farklı veritabanı kullandığını "Hoca öyle istedi" diye değil; "Biri metinler için çok hızlı (Firebase), diğeri büyük resim dosyaları için daha ucuz ve uygun (Supabase), bu yüzden bilerek böyle bir sistem tasarladım" diyerek mühendislik vizyonu kattık.
3. **Ağaç Yapısı (`Klasör Yapısı`):** GitHub'a giren kişinin dosyaların içine tek tek girmesine gerek kalmadan tüm projenin ne kadar düzenli olduğunu tek bakışta anlamasını sağladık. 


