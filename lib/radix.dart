import 'package:flutter/material.dart';
import 'dart:math';

class radixPage extends StatefulWidget {
  const radixPage({super.key});

  @override
  State<radixPage> createState() => _radixPageState();
}

class _radixPageState extends State<radixPage> {
  List<int> numbers = [];
  String input = '';

  void radixSort() {
    List<List<int>> buckets = List.generate(10, (index) => []);

    int maxDigits = getMaxDigits(); // Move this line outside the radixSort function

    for (int digit = 0; digit < maxDigits; digit++) {
      for (int number in numbers) {
        int bucketIndex = (number ~/ pow(10, digit)) % 10;
        buckets[bucketIndex].add(number);
      }

      numbers.clear();
      for (List<int> bucket in buckets) {
        numbers.addAll(bucket);
      }

      buckets = List.generate(10, (index) => []);
      print('Step ${digit + 1}: $numbers');
    }
  }

  int getMaxDigits() {
    int maxDigits = 0;
    for (int number in numbers) {
      int digits = number.toString().length;
      if (digits > maxDigits) {
        maxDigits = digits;
      }
    }
    return maxDigits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radix Sort Demo'),
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
                  radixSort();
                });
              },
              child: Text('Sort'),
            ),
          ],
        ),
      ),
    );
  }
}
