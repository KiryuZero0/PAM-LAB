import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {//Funcția principală
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator TVA',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const CalculatorTVA(),
    );
  }
}

class CalculatorTVA extends StatefulWidget {//Clasa principala 
  const CalculatorTVA({super.key});

  @override
  State<CalculatorTVA> createState() => _CalculatorTVAState();
}

class _CalculatorTVAState extends State<CalculatorTVA>// calculeaza
    with SingleTickerProviderStateMixin {
  final TextEditingController pretController = TextEditingController();
  String rezultat = "";
  bool showResult = false;

  void calculeazaPretFinal(double tva) {
    setState(() {
      double pret = double.tryParse(pretController.text) ?? 0;
      double pretFinal = pret + (pret * tva / 100);
      rezultat =
          "💰 Preț final cu TVA $tva%: ${pretFinal.toStringAsFixed(2)} lei";
      showResult = true; // activează animația
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📱 Calculator TVA"),
        centerTitle: true,
        elevation: 8,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Card pentru input
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: pretController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Introduceți prețul fără TVA",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Butoane cu animații
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  ElevatedButton(
                    onPressed: () => calculeazaPretFinal(5.0),
                    child: const Text("TVA 5%"),
                  ),
                  ElevatedButton(
                    onPressed: () => calculeazaPretFinal(8.0),
                    child: const Text("TVA 8%"),
                  ),
                  ElevatedButton(
                    onPressed: () => calculeazaPretFinal(20.0),
                    child: const Text("TVA 20%"),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Animație pentru rezultat
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
                child: showResult
                    ? Text(
                        rezultat,
                        key: ValueKey(rezultat),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
