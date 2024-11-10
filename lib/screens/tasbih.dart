import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taqwalife/providers/tasbih.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:confetti/confetti.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasbihProvider = Provider.of<TasbihProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المسبحة",
          style: GoogleFonts.cairo(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 5,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade900, Colors.teal.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tasbihProvider.selectedPhrase,
                      style: GoogleFonts.cairo(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            blurRadius: 10.0,
                            color: Colors.black38,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ': ${tasbihProvider.count}',
                      style: GoogleFonts.cairo(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Counter Display with Centered Increment Button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        size: 250,
                        customColors: CustomSliderColors(
                          trackColor: Colors.teal.shade100,
                          progressBarColor: Colors.amber,
                          shadowColor: Colors.black45,
                          dotColor: Colors.white,
                        ),
                        customWidths: CustomSliderWidths(
                          trackWidth: 12,
                          progressBarWidth: 20,
                          handlerSize: 12,
                        ),
                      ),
                      initialValue: tasbihProvider.count.toDouble(),
                      min: 0,
                      max: tasbihProvider.targetCount.toDouble(),
                      innerWidget: (value) => const SizedBox(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        tasbihProvider.incrementCount();
                        if (tasbihProvider.count >= tasbihProvider.targetCount) {
                          _confettiController.play();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(50),
                        backgroundColor: Colors.amber,
                        elevation: 10,
                        shadowColor: Colors.black45,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Dropdown to select phrase
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: tasbihProvider.selectedPhrase,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.teal.shade700),
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: tasbihProvider.phrases.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.cairo(fontSize: 22, color: Colors.teal.shade800),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      tasbihProvider.changePhrase(newValue!);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Target Count Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "العدد المطلوب:",
                      style: GoogleFonts.cairo(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        tasbihProvider.setTargetCount(33);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tasbihProvider.targetCount == 33
                            ? Colors.amber
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("33", style: GoogleFonts.cairo(fontSize: 20, color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        tasbihProvider.setTargetCount(100);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tasbihProvider.targetCount == 100
                            ? Colors.amber
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("100", style: GoogleFonts.cairo(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Reset Button
                ElevatedButton(
                  onPressed: () {
                    tasbihProvider.resetCount();
                    _confettiController.stop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black45,
                  ),
                  child: Text(
                    "إعادة",
                    style: GoogleFonts.cairo(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [Colors.amber, Colors.teal, Colors.green, Colors.orange],
            ),
          ),
        ],
      ),
    );
  }
}
