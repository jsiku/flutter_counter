import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const einPomodoro = 1500;
  static const einPause = 300;
  int totalSeconds = einPomodoro;
  bool isRunning = false;
  bool isPause = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0 && isPause == false) {
      setState(() {
        isPause = true;
        totalPomodoros = totalPomodoros + 1;
        totalSeconds = einPause;
      });
    } else if (totalSeconds == 0 && isPause == true) {
      setState(() {
        isPause = false;
        totalSeconds = einPomodoro;
      });
    } else {
      setState(() {
        totalSeconds += -1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRefreshTimerPressed() {
    if (isPause == false) {
      setState(() {
        totalSeconds = einPomodoro;
      });
    } else {
      setState(() {
        totalSeconds = einPause;
      });
    }
  }

  void onRefreshAllPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = einPomodoro;
      isRunning = false;
      isPause = false;
      totalPomodoros = 0;
    });
  }

  void onNextPressed() {
    setState(() {
      totalSeconds = 0;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isPause ? Colors.green.shade400 : Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isPause
                    ? Text(
                        "Pause",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Text(
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 130,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_filled_outlined
                        : Icons.play_circle_outline),
                  ),
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: onRefreshTimerPressed,
                    icon: const Icon(
                      Icons.restart_alt_outlined,
                    ),
                  ),
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: onNextPressed,
                    icon: const Icon(
                      Icons.skip_next,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalPomodoros',
                                style: TextStyle(
                                  fontSize: 58,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-5, -10),
                                child: IconButton(
                                  iconSize: 20,
                                  color: Colors.grey[700],
                                  onPressed: onRefreshAllPressed,
                                  icon: const Icon(Icons.refresh_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
