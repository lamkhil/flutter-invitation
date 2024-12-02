import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late Timer _timer;
  Duration _duration = const Duration();

  final ScrollController _scrollController = ScrollController();
  final _pengantinKey = GlobalKey();

  final ucapanController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    final targetDate = DateTime(2024, 9, 20);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _duration = targetDate.difference(now);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    ucapanController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _duration.inDays;
    final hours = _duration.inHours % 24;
    final minutes = _duration.inMinutes % 60;
    final seconds = _duration.inSeconds % 60;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 54, 51, 0).withOpacity(0.5),
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Text("Anda diundang pada pernikahan",
                            style: GoogleFonts.patrickHand(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 195, 195, 195),
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        FadeInUp(
                          globalKey: GlobalKey(),
                          child: Image.asset('assets/pengantin.png',
                              width: 200, height: 200),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        FadeInUp(
                          globalKey: GlobalKey(),
                          child: Text(
                            "Lukman & Yuniar",
                            style: GoogleFonts.greatVibes(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: const Color.fromARGB(255, 195, 195, 195),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FadeInUp(
                          globalKey: GlobalKey(),
                          child: Text(
                            "20 September 2024",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 195, 195, 195),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        AnimatedScale(
                          scale: seconds % 2 == 0 ? 1.0 : 1.7,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                          child: IconButton(
                              onPressed: () {
                                Scrollable.ensureVisible(
                                  _pengantinKey.currentContext!,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              key: _pengantinKey,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 247, 212, 191),
                image: DecorationImage(
                  image: AssetImage('assets/bg-flower-1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 72.0, vertical: 42),
                    child: Text(
                      "Dengan Memohon Rahmat Dan Ridho Dari Allah SWT. Kami Bermaksud Menyelenggarakan Syukuran Pernikahan Kami",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.brown.shade800),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 750),
                    child: Image.asset("assets/pengantin_pria.png",
                        width: 150, height: 150),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Miftachul Huda Lukmanul Qakim",
                      style: GoogleFonts.greatVibes(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Putra dari Bapak Kadar dan Alm Ibu Sriptun",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.brown.shade800),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text("&",
                        style: GoogleFonts.greatVibes(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade800)),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Image.asset("assets/pengantin_wanita.png",
                        width: 150, height: 150),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Yuniar Sofia Rahma",
                      style: GoogleFonts.greatVibes(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Putri dari Bapak Rohman dan Ibu Lilik",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.brown.shade800),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 500,
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 177, 149),
              ),
              child: Column(
                children: [
                  FadeIn(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "“Dan Diantara Tanda-tanda (Kebesaran) -Nya Ialah Dia Menciptakan Pasangan-pasangan Untukmu Dari Jenismu Sendiri, Agar Kamu Cenderung Dan Merasa Teteram Kepadanya, Dan Dia Menjadikan Diantaramu Rasa Kasih Dan Sayang. Sungguh, Pada Yang Demuikian Itu Benar-benar Terdapat Tanda-tanda (Kebesaran Allah) Bagi Kaum Yang Berfikir”\n\n{ Q.S : Ar-Rum (30) : 21 }",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FadeInRight(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: Container(
                            height: 2,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 52,
                      ),
                      FadeIn(
                        globalKey: GlobalKey(),
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 750),
                        child: Text(
                          "SAVE THE DATE",
                          style: GoogleFonts.patrickHand(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 52,
                      ),
                      Expanded(
                        child: FadeInLeft(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: Container(
                            height: 2,
                            color: Colors.brown.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInRight(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: buildTimeContainer(days, 'Hari')),
                      const SizedBox(width: 8),
                      FadeInRight(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: buildTimeContainer(hours, 'Jam')),
                      const SizedBox(width: 8),
                      FadeInLeft(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: buildTimeContainer(minutes, 'Menit')),
                      const SizedBox(width: 8),
                      FadeInLeft(
                          globalKey: GlobalKey(),
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 750),
                          child: buildTimeContainer(seconds, 'Detik')),
                    ],
                  ),
                  const Spacer(),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://calendar.google.com/calendar/render?action=TEMPLATE&text=Wedding+of+Lukman+%26+Yuniar&dates=20240920T020000Z/20240920T060000Z&details=Hari+pernikahan+Miftachul+Huda+Lukmanul+Qakim+dan+Yuniar+Sofia+Rahma&location=Rumah+Bapak+Kadar%2C+Desa+Brumbun%2C+Kecamatan+Wungu%2C+Kabupaten+Madiun"));
                        },
                        child: const Text("Save to Calendar")),
                  ),
                  const Spacer()
                ],
              ),
            ),
            FadeInUp(
              globalKey: GlobalKey(),
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 750),
              child: Container(
                width: double.infinity,
                color: Colors.brown,
                padding: const EdgeInsets.all(24),
                child: FittedBox(
                  child: Text(
                    "Jumat, 20 September 2024",
                    style: GoogleFonts.patrickHand(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 247, 212, 191),
              child: Column(
                children: [
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      width: 250,
                      child: Text("Insya Allah Acara Akan Dilaksanakan Pada :",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.patrickHand(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade800,
                          )),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Image.asset(
                      'assets/calendar_icons.png',
                      width: 100,
                      height: 100,
                      color: Colors.brown.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Akad Nikah",
                      style: GoogleFonts.greatVibes(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 8),
                        Text(
                          "20 September 2024",
                          style: GoogleFonts.patrickHand(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timer),
                        const SizedBox(width: 8),
                        Text(
                          "Pukul 09.00 WIB - Selesai",
                          style: GoogleFonts.patrickHand(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                          "Di kediaman Bapak Kadar\n\nRT 05 RW 01, Brumbun, Wungu, Madiun",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.patrickHand(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade800,
                          )),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.hardEdge,
                    width: 300,
                    height: 300,
                    child: FlutterMap(
                        options: const MapOptions(
                            initialCenter: LatLng(-7.688209, 111.607786),
                            initialZoom: 16),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                            maxNativeZoom:
                                19, // Scale tiles when the server doesn't support higher zoom levels
                            // And many more recommended properties!
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 120,
                                height: 80.0,
                                point: const LatLng(-7.688209, 111.607786),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.home,
                                      color: Colors.yellow,
                                      size: 40,
                                    ),
                                    Text("Kediaman Bapak Kadar",
                                        style: GoogleFonts.patrickHand(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  const SizedBox(height: 24),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://maps.app.goo.gl/sV4h3PEuqF9md3v37"));
                        },
                        child: const Text("Buka Lokasi di Google Maps")),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
            FadeInUp(
              globalKey: GlobalKey(),
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 750),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 177, 149),
                ),
                child: Column(
                  children: [
                    Text(
                      "Wedding Gift",
                      style: GoogleFonts.greatVibes(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Doa Restu Anda merupakan karunia yang sangat berarti bagi kami. Dan jika memberi adalah ungkapan tanda kasih Anda, Anda dapat memberi kado secara cashless.',
                      style: GoogleFonts.patrickHand(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Image.asset(
                        'assets/logo_bri.png',
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Transfer ke rekening BRI a.n.\nYuniar Sofia Rahma\n3184 0103 2558 537',
                      style: GoogleFonts.patrickHand(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Clipboard.setData(
                              const ClipboardData(text: "318401032558537"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Teks berhasil disalin!")),
                          );
                        },
                        child: const Text("Copy Nomor Rekening")),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Anda Juga Bisa Mengirim Kado Fisik Ke Alamat Berikut\n\"Rumah Bapak Kadar, RT 05 RW 01, Brumbun, Wungu, Madiun.\"",
                      style: GoogleFonts.patrickHand(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Clipboard.setData(const ClipboardData(
                              text:
                                  "Rumah Bapak Kadar, RT 05 RW 01, Brumbun, Wungu, Madiun."));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Teks berhasil disalin!")),
                          );
                        },
                        child: const Text("Copy Alamat")),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 2,
                      color: Colors.brown,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          launchUrl(Uri.parse('https://wa.me/6281927824621'));
                        },
                        child: const Text("Konfirmasi Via WA Lukman"))
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 247, 212, 191),
                image: DecorationImage(
                    image: AssetImage('assets/bg-flower-1.jpg'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.bottomCenter),
              ),
              child: Column(
                children: [
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Tiada Yang Dapat Kami Ungkapkan Selain Rasa Terimakasih Dari Hati Yang Tulus Apabila Bapak/ Ibu/ Saudara/i Berkenan Hadir Untuk Memberikan Do’a Restu Kepada Kami",
                        style: GoogleFonts.patrickHand(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FadeInUp(
                      globalKey: GlobalKey(),
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 750),
                      child: Image.asset('assets/pengantin.png',
                          width: 200, height: 200)),
                  const SizedBox(
                    height: 12,
                  ),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "Lukman & Yuniar",
                      style: GoogleFonts.greatVibes(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      "20 September 2024",
                      style: GoogleFonts.patrickHand(fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FadeInUp(
                    globalKey: GlobalKey(),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 750),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      color: Colors.brown,
                      child: Text(
                        "Berikan Ucapan anda disini",
                        style: GoogleFonts.patrickHand(
                            color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('ucapan')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          height: snapshot.hasData ? 750 : null,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Ucapan",
                                    style:
                                        GoogleFonts.patrickHand(fontSize: 32),
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        label: Text("Nama")),
                                  ),
                                  TextFormField(
                                    controller: ucapanController,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                        label: Text("Ucapan")),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.brown,
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        final name = nameController.text;
                                        final ucapan = ucapanController.text;
                                        if (name.isNotEmpty &&
                                            ucapan.isNotEmpty) {
                                          FirebaseFirestore.instance
                                              .collection('ucapan')
                                              .add({
                                            'name': name,
                                            'ucapan': ucapan,
                                            'createdAt': Timestamp.now()
                                          });
                                          nameController.clear();
                                          ucapanController.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Ucapan berhasil dikirim!"),
                                            backgroundColor: Colors.red,
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Nama dan ucapan tidak boleh kosong!"),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Kirim"),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  if (snapshot.hasData)
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: snapshot.data!.size,
                                            itemBuilder: (context, i) {
                                              final data =
                                                  snapshot.data!.docs[i].data();
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'] ?? '',
                                                    style:
                                                        GoogleFonts.patrickHand(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                  ),
                                                  Text(
                                                    data['ucapan'] ?? '',
                                                    style:
                                                        GoogleFonts.patrickHand(
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontSize: 14),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.timer,
                                                          size: 12),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        timeago.format(
                                                            data['createdAt']
                                                                .toDate(),
                                                            locale: 'id'),
                                                        style: GoogleFonts
                                                            .patrickHand(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider()
                                                ],
                                              );
                                            }))
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
            FadeInUp(
              globalKey: GlobalKey(),
              delay: const Duration(milliseconds: 1000),
              duration: const Duration(milliseconds: 750),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.brown,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse("https://www.instagram.com/lamkhil/"));
                      },
                      child: Text(
                        'Created with ❤️ by Lamkhil',
                        style: GoogleFonts.patrickHand(
                            fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeContainer(int value, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 62,
      height: 72,
      decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                spreadRadius: 8,
                blurRadius: 8,
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
