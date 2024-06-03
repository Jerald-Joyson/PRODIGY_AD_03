import 'dart:async';

import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  static const countDownDuration = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;

  bool isCountDown = false;

  @override
  void initState() {
    super.initState();

    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void toggleCountDown() {
    setState(() {
      isCountDown = !isCountDown;
      final seconds = isCountDown ? duration.inSeconds : 0;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTime(),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds != 0;
    return isRunning || isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: isRunning ? 'STOP' : 'RESUME',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    }else{
                      startTimer(resets: false);
                    }
                  }),
              const SizedBox(width: 8),
              ButtonWidget(text: 'CANCEL', onClicked: stopTimer),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            color: Colors.white,
            backgroundColor: Colors.black,
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SECONDS'),
        const SizedBox(width: 8),
      ],
    );
  }

  ButtonWidget({
    required String text,
    Color color = Colors.white,
    Color backgroundColor = Colors.black,
    required Function() onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
        ),
        onPressed: onClicked,
        child: Text(text),
      );
}

buildTimeCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          header,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
