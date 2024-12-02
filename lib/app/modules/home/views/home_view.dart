import 'package:flutter/material.dart';
import 'package:invitation/app/modules/home/views/content_page.dart';
import 'package:invitation/app/modules/home/views/landing_page.dart';
import 'package:just_audio/just_audio.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeView> {
  int _counter = 0;
  int _startCounter = 0;

  final player = AudioPlayer();

  Duration? _duration;

  Future<void> setupMusic() async {
    player.setAsset('assets/bg_music.mp3', preload: false).then((duration) {
      setState(() {
        _duration = duration;
      });
    });
  }

  @override
  void initState() {
    setupMusic();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      return const Scaffold(
        body: Center(
          child: Text('Please open in portrait mode'),
        ),
      );
    }
    return Scaffold(
      body: IndexedStack(
        index: _counter,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _startCounter == 0 ? 1 : 0,
            child: LandingPage(
              onNavigate: () {
                player.play();
                setState(() {
                  _startCounter = 1;
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _counter = 1;
                    });
                  });
                });
              },
            ),
          ),
          AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _counter == 1 ? 1 : 0,
              child: const ContentPage())
        ],
      ),
    );
  }
}
