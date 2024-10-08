import 'package:flutter/material.dart';

import 'navbar.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> itemKeys = {
    'Page Main Dashboard': GlobalKey(),
    'Page Sensor Diagram': GlobalKey(),
    'Page Dispenser': GlobalKey(),
    'Page Catroom': GlobalKey(),
    'Page Kitten': GlobalKey(),
    'Sambungan Listrik': GlobalKey(),
    'Tangki Penyimpanan Makanan': GlobalKey(),
    'Kondisi Ruangan Kucing': GlobalKey(),
    'Memantau Suhu': GlobalKey(),
    'Memantau Kelembaban': GlobalKey(),
    'Mengatur Dispenser Makanan': GlobalKey(),
    'Memantau Lampu dan Kipas': GlobalKey(),
    'Mengatur Mode Kitten': GlobalKey(),
  };

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToItem(String keyword) {
    if (itemKeys.containsKey(keyword)) {
      final context = itemKeys[keyword]!.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(context,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEDEB),
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xffE0CCBE),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
        title: const Center(
          child: Text(
            'SMART CATHOUSE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Paratha',
                color:  Color(0xff3C3633)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff3C3633),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello, Buddy! Can I help u?',
                      style: TextStyle(
                        color: Color(0xffEEEDEB),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for questions or guides...',
                        hintStyle: const TextStyle(color: Color(0xff3C3633)),
                        fillColor: const Color(0xffEEEDEB),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                        const Icon(Icons.search, color: Color(0xff3C3633)),
                      ),
                      onSubmitted: (value) {
                        scrollToItem(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Panduan/Manual Book Aplikasi Sistem Cathouse',
                style: TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              _buildGuideItem(
                'Page Main Dashboard',
                'Fungsi: Memantau suhu dan kelembaban dalam cathouse.\nDeskripsi: Halaman ini menampilkan suhu dan kelembaban ruangan cathouse secara real-time.',
              ),
              _buildGuideItem(
                'Page Sensor Diagram',
                'Fungsi: Memantau suhu dan kelembaban dalam cathouse dalam bentuk grafik.\nDeskripsi: Halaman ini menampilkan tingkat suhu dan  kelembaban ruangan cathouse secara real-time dan dilengkapi dengan grafik diagram untuk memonitoring perubahan kelembaban udara dalam kurun waktu tertentu. serta menampilkan statistik data suhu dan kelembaban dalam waktu sehari.',
              ),
              _buildGuideItem(
                'Page Dispenser',
                'Fungsi: Memantau tingkat ketinggian makanan dalam wadah dan mengatur pengeluaran makanan.\nFitur:\n• Manual Mode: Pemilik dapat mengeluarkan makanan dari dispenser sesuai keinginan.\n• Automatic Mode: Makanan akan keluar dari dispenser berdasarkan jarak tingkat ketinggian makanan pada wadah.\nDeskripsi: Halaman ini memungkinkan pemilik untuk memantau dan mengatur dispenser makanan dengan dua mode: manual dan otomatis.',
              ),
              _buildGuideItem(
                'Page Catroom',
                'Fungsi: Monitoring jarak kucing dan mengatur lampu dan kipas pada ruangan cathouse berdasarkan suhu dan kelembaban.\nDeskripsi: Halaman ini menampilkan nilai deteksi jarak kucing saat memasuki ruangan cathouse, kemudian memantau suhu dan kelembaban lingkungan tidur cathouse untuk menyalakan lampu dan kipas',
              ),
              _buildGuideItem(
                'Page Kitten',
                'Fungsi: Monitoring dan kontroling khusus untuk kucing bayi (kitten).\nFitur:\n• Mode Kitten: Tombol untuk mengaktifkan atau menonaktifkan mode kitten.\n• Aktif Mode Kitten: Lampu dan fan akan selalu menyala agar ruangan kucing tetap hangat dan tidak lembab.\nDeskripsi: Halaman ini memungkinkan pemilik untuk mengaktifkan mode khusus untuk kucing bayi, memastikan kondisi ruangan yang nyaman dan hangat untuk kitten.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Perawatan Fisik Sistem Cathouse',
                style: TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              _buildCareItem(
                'Sambungan Listrik',
                'Pastikan sambungan listrik yang terhubung adalah listrik PLN 220V dan adaptor DC 5V saat menghidupkan sistem.',
              ),
              _buildCareItem(
                'Tangki Penyimpanan Makanan',
                'Selalu cek tangki penyimpanan makanan kucing secara berkala agar ketika habis dapat segera diisi.',
              ),
              _buildCareItem(
                'Kondisi Ruangan Kucing',
                'Cek selalu kondisi ruangan kucing agar tetap ideal, tidak lembab, dan tidak kotor.\n• Sistem sudah dilengkapi dengan fitur kipas yang akan menyala jika kondisi ruangan lembab.\n• Jika ruangan sangat lembab dan kotor, lakukan perawatan manual untuk memastikan kenyamanan kucing.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Penggunaan Aplikasi',
                style: TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              _buildUsageItem(
                'Memantau Suhu dan kelembaban',
                '• Buka Page Main Dashboard untuk memantau suhu dan kelembaban secara realtime.',
              ),
              _buildUsageItem(
                'Memantau Diagram sensor',
                '• Buka Page Diagram Sensor untuk memantau grafik suhu dan kelembaban.\n• Tekan pada grafik diagram untuk melihat keterangan nilai suhu dan kelembaban beserta waktu.',
              ),
              _buildUsageItem(
                'Mengatur Dispenser Makanan',
                '• Buka Page Dispenser.\n• Pilih mode Manual atau Otomatis sesuai kebutuhan.\n• Untuk mode manual, tekan tombol untuk mengeluarkan makanan.\n• Untuk mode otomatis, makanan akan keluar sesuai dengan tingkat ketinggian yang terdeteksi.',
              ),
              _buildUsageItem(
                'Memantau Lampu dan Kipas',
                '• Buka Page Catroom.\n• Lihat jarak yang terdeteksi pada ruangan\n• Jika nilai jarak kurang dari 30 cm maka lampu dan kipas akan menyala sesuai kondisi suhu dan kelembaban.\n• Jika suhu dibawah 35 derajat celcius maka lampu akan menyala, namun jika melebihi itu lampu akan mati.\n• Jika kelembaban diatas 60% maka kipas akan berputar, namun jika kurang dari itu kipas akan mati.',
              ),
              _buildUsageItem(
                'Mengatur Mode Kitten',
                '• Buka Page Kitten.\n• Aktifkan atau nonaktifkan mode kitten sesuai kebutuhan.\n• Saat mode kitten aktif, lampu dan fan akan selalu menyala untuk menjaga kehangatan dan kelembaban yang sesuai.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Catatan:',
                style: TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Pastikan aplikasi selalu dalam keadaan update untuk mendapatkan fitur terbaru dan perbaikan bug.\n• Periksa kondisi perangkat keras (sensor suhu, kelembaban, dispenser, dan lampu) secara berkala untuk memastikan kinerja optimal.',
                style: TextStyle(
                  color: Color(0xff3C3633),
                  fontSize: 15,
                  fontFamily: 'AgencyFB'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideItem(String title, String description) {
    return Padding(
      key: itemKeys[title],
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEEEDEB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE0CCBE), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontSize: 15,
                  fontFamily: 'AgencyFB'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareItem(String title, String description) {
    return Padding(
      key: itemKeys[title],
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEEEDEB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE0CCBE), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontSize: 15,
                  fontFamily: 'AgencyFB'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageItem(String title, String description) {
    return Padding(
      key: itemKeys[title],
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEEEDEB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE0CCBE), width: 2),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UnigeoMedium',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xff3C3633),
                  fontSize: 15,
                  fontFamily: 'AgencyFB'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
