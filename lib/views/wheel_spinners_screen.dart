import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:kbspinningwheel/kbspinningwheel.dart';

class SpinningWhelePage extends StatefulWidget {
  const SpinningWhelePage({Key? key}) : super(key: key);

  @override
  State<SpinningWhelePage> createState() => _SpinningWhelePageState();
}

class _SpinningWhelePageState extends State<SpinningWhelePage> {
  final StreamController<int> _dividerController = StreamController<int>();

  @override
  void dispose() {
    _dividerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bugün Ne Yesem"),
        centerTitle: true,
        backgroundColor: const Color(0xffDDC3FF),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              image: Image.asset('assets/images/Tantuni.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('assets/images/roulette-center-300.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
            ),
            SizedBox(height: 30),
            StreamBuilder<int>(
              stream: _dividerController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RouletteScore(snapshot.data!);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'Dövme Pilavı',
    2: 'Yüksük Çorbası',
    3: 'Topalak Çorbası',
    4: 'Batırık',
    5: 'Sıkma',
    6: 'İçli Köfte',
    7: 'Tantuni',
    8: 'Tarsus Kebabı',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${labels[selected]}',
      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0, color: Colors.black),
    );
  }
}
