import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';

class breadth_first_Page extends StatefulWidget {
  const breadth_first_Page({Key? key}) : super(key: key);

  @override
  State<breadth_first_Page> createState() => _breadth_first_PageState();
}

class _breadth_first_PageState extends State<breadth_first_Page> {
  List<int> numbers = [];
  String input = '';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void bfsVisualization() {
    final Queue<int> bfsQueue = Queue<int>();
    final Set<int> visited = Set<int>();

    // Start BFS from the first number in the list
    bfsQueue.add(numbers.first);
    visited.add(numbers.first);

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (bfsQueue.isNotEmpty) {
        int current = bfsQueue.removeFirst();
        enqueue(current);

        // Simulate exploring neighbors of the current node
        for (int neighbor in getNeighbors(current)) {
          if (!visited.contains(neighbor)) {
            bfsQueue.add(neighbor);
            visited.add(neighbor);
          }
        }
      } else {
        timer.cancel();
      }
    });
  }

  List<int> getNeighbors(int node) {
    // Simulated function to get neighbors of a node
    // You can modify this function based on your requirements
    List<int> neighbors = [];
    for (int i = node * 2; i <= node * 2 + 1; i++) {
      neighbors.add(i);
    }
    return neighbors;
  }

  void enqueue(int number) {
    int index = numbers.indexOf(number);
    _listKey.currentState?.insertItem(index, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breadth-First Search Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  input = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter comma-separated numbers',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  numbers = input
                      .split(',')
                      .map((e) => int.tryParse(e.trim()) ?? 0)
                      .toList();
                  bfsVisualization();
                });
              },
              child: Text('Run BFS'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                itemBuilder: (context, index, animation) {
                  int number = numbers[index];
                  return _buildItem(number, animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int number, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: ListTile(
        title: Text('Node: $number'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: breadth_first_Page(),
  ));
}
