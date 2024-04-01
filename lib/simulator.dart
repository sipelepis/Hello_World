import 'package:flutter/material.dart';
import 'package:flutterapp/radix.dart';
import 'package:flutterapp/insertion.dart';
import 'package:flutterapp/merge.dart';
import 'package:flutterapp/binary.dart';
import 'package:flutterapp/binary_search_tree.dart';


class simPage extends StatefulWidget {
  const simPage({super.key});

  @override
  State<simPage> createState() => _simPageState();
}

class _simPageState extends State<simPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AL-GO!')),
      body: Column(
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
          Expanded(
            child: radix(),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: merge(),
                ),
                Expanded(
                  child: insertion(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: binary_search(),
                ),
                Expanded(
                  child: binary_tree(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
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
                  'Enter',
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
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
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

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
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
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
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

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
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
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
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

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
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
              padding: EdgeInsets.fromLTRB(
                  0, 10, 0, 0), // Adjust the value as needed
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

              // Text('START', style: TextStyle(fontSize: 30),),
            ),
          ],
        ));
  }
}