import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Column(
        children: [
          Expanded(
            flex: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: const Image(
                          image: AssetImage(
                            "/home/eternity/Pictures/block.jpg",
                          ),
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          width: 380,
                          height: 380,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  color: Colors.pink[200],
                  child: SizedBox(
                    width: 700,
                    height: 100,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: _currentSliderValue,
                                  min: 0,
                                  max: 180,
                                  activeColor: Colors.pink[300],
                                  inactiveColor: Colors.pink[100],
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_previous),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow, size: 32), //
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_next),
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
          ),
        ],
      ),
    );
  }
}

