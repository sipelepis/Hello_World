import 'package:flutter/material.dart';
import 'dart:math'; // Required for pow function

void main() {
  runApp(MaterialApp(
    title: 'Radix Sort Visualization',
    home: RadixSortPage(),
  ));
}

class RadixSortPage extends StatefulWidget {
  @override
  _RadixSortPageState createState() => _RadixSortPageState();
}

class _RadixSortPageState extends State<RadixSortPage> {
  final TextEditingController inputController = TextEditingController();
  List<List<TextEditingController>> stepControllers = [];

  void _insertAndSort() {
    if (inputController.text.isEmpty) return;
    List<TextEditingController> newStep = inputController.text
        .split(',')
        .map((e) => TextEditingController(text: e.trim()))
        .toList();
    setState(() {
      stepControllers.add(newStep);
      inputController.clear(); // Clear the input field after insertion
    });
  }

  Widget _buildStep(int index) {
    return Row(
      children: [
        Text('Step ${index + 1}: '),
        SizedBox(width: 10), // Add some spacing
        Expanded(
          child: Container(
            height: 50, // Set a specific height for the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stepControllers[index].length,
              itemBuilder: (context, idx) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(
                      right: 10), // Add some spacing between fields
                  child: TextFormField(
                    controller: stepControllers[index][idx],
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radix Sort Visualization')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: inputController,
              decoration:
                  InputDecoration(labelText: 'Enter numbers (comma-separated)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _insertAndSort,
                  child: Text('Insert'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => stepControllers.clear()),
                  child: Text('Clear Steps'),
                ),
                ElevatedButton(
                  onPressed: () {}, // Placeholder for "Sort" button
                  child: Text('Sort'),
                ),
                ElevatedButton(
                  onPressed: () {}, // Placeholder for "Check" button
                  child: Text('Check'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit Step/s'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Scan Text'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {}, // Placeholder for "How to use" button
              child: Text('How to use'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stepControllers.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildStep(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
