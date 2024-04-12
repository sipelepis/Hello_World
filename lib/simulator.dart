import 'package:flutter/material.dart';
import 'package:flutterapp/radix.dart';
import 'package:flutterapp/insertion.dart';
import 'package:flutterapp/merge.dart';
import 'package:flutterapp/binary.dart';
import 'package:flutterapp/binary_search_tree.dart';
import 'package:flutterapp/stacks.dart';


class simPage extends StatefulWidget {
  const simPage({super.key});

  @override
  State<simPage> createState() => _simPageState();
}

class _simPageState extends State<simPage> {
  // Constants for the heights of the first ListView in portrait and landscape orientations
  static const double _portraitListViewHeight = 600;
  static const double _landscapeListViewHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AL-GO!')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Simulators',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: _getFirstListViewHeight(orientation),
                  child: ListView.builder(
                    scrollDirection: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    itemCount: 6, // Adjust the item count as needed
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _buildSimulatorWidget(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _getFirstListViewHeight(Orientation orientation) {
    // Return different height based on orientation
    return orientation == Orientation.portrait
        ? _portraitListViewHeight
        : _landscapeListViewHeight;
  }

  Widget _buildSimulatorWidget(int index) {
    // Define your simulator widgets here
    List<Widget> simulators = [
      radix(),
      merge(),
      insertion(),
      binary_search(),
      binary_tree(),
      stacks(),
    ];

    return simulators[index];
  }
}




class radix extends StatefulWidget {
  const radix({super.key});

  @override
  State<radix> createState() => _radixState();
}

class _radixState extends State<radix> {
  String text =
      "Palagay ng explanation ni radix.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => radixPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: Radix",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}

class merge extends StatefulWidget {
  const merge({super.key});

  @override
  State<merge> createState() => _mergeState();
}

class _mergeState extends State<merge> {
  String text =
      "Palagay ng explanation ni merge.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => mergePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: Merge",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}

class insertion extends StatefulWidget {
  const insertion({super.key});

  @override
  State<insertion> createState() => _insertionState();
}

class _insertionState extends State<insertion> {
  String text =
      "Palagay ng explanation ni insertion.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => insertionPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: Insertion",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}

class binary_search extends StatefulWidget {
  const binary_search({super.key});

  @override
  State<binary_search> createState() => _binary_searchState();
}

class _binary_searchState extends State<binary_search> {
  String text =
      "Palagay ng explanation ni binary search tree.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => binary_searchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: Binary search tree",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}

class binary_tree extends StatefulWidget {
  const binary_tree({super.key});

  @override
  State<binary_tree> createState() => _binary_treeState();
}

class _binary_treeState extends State<binary_tree> {
  String text =
      "Palagay ng explanation ni binary tree.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => binaryPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: Binary tree",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}


class stacks extends StatefulWidget {
  const stacks({super.key});

  @override
  State<stacks> createState() => _stacksState();
}

class _stacksState extends State<stacks> {
  String text =
      "Palagay ng explanation ni stacks.";

  void click() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StacksPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // Adjust the value as needed
              child: Text(
                "Sorting Algorithm: stacks",
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
                  'Enter',
                  style: TextStyle(fontSize: 15),
                ),
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      );
  }
}