import 'package:flutter/material.dart';
import 'package:flutterapp/choiceB/continue_button.dart';
import 'package:flutterapp/simulator.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState(); 
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AL-GO!')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxWidth < constraints.maxHeight;

          return isPortrait
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SAS(),
                    ),
                    Expanded(
                      child: LLS(),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SAS(),
                    ),
                    Expanded(
                      child: LLS(),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////// Mistake (This code below only works for design if the device was in portrait)
// class _StartPageState extends State<StartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('AL-GO!'),),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: SAS(),
//           ),
//           Expanded(
//             child: LLS(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//////////////////////////////////////////////////////////////////

class SAS extends StatefulWidget {
  const SAS({super.key});

  @override
  State<SAS> createState() => _SASState();
}

class _SASState extends State<SAS> {
  String text =
      "Let's embark on a simulation of sorting algorithms, where we can dynamically select from insertion, radix, and merge sort. The goal is to vividly visualize the step-by-step process of each sorting algorithm in action.";

  void click() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => simPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm Simulator",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 65, 65, 71)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 255, 255)),
              ),

              onPressed: this.click,
              child: Container(
                child: Text(
                  'SELECT',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
  }
}

class LLS extends StatefulWidget {
  const LLS({super.key});

  @override
  State<LLS> createState() => _LLSState();
}

class _LLSState extends State<LLS> {
  String text =
      "Let's embark on a simulation of sorting algorithms, where we can dynamically select from insertion, radix, and merge sort. The goal is to vividly visualize the step-by-step process of each sorting algorithm in action.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => L2HOME()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Let's Learn Sorting Algorithm",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent),
              child: Text(
                text,
                style: TextStyle(fontSize: 14),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 65, 65, 71)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 255, 255)),
              ),

              onPressed: this.click,
              child: Container(
                child: Text(
                  'SELECT',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
  }
}
