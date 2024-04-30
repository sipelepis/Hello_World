import 'package:flutter/material.dart';

void main() {
  runApp(RadixSortPage());
}

class RadixSortPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radix Sort Visualization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RadixSortScreen(),
    );
  }
}

class RadixSortScreen extends StatefulWidget {
  @override
  _RadixSortScreenState createState() => _RadixSortScreenState();
}

class _RadixSortScreenState extends State<RadixSortScreen> {
  List<int> unsortedList = [170, 45, 75, 90, 802, 24, 2, 66];

  void radixSort() {
    // Implementation of Radix Sort algorithm
    // Sort the unsortedList
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radix Sort Visualization'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Radix Sort',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Radix Sort is a non-comparative sorting algorithm. It avoids comparison by creating and distributing elements into buckets according to their radix. Each bucket is then sorted individually, either using a different sorting algorithm, or by recursively applying the radix sorting algorithm.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: radixSort,
            child: Text('Sort'),
          ),
          SizedBox(height: 20),
          Text(
            'Unsorted List: $unsortedList',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Here you can display visualization of the sorting process
          // You can use custom widgets or packages like fl_chart to visualize the sorting process
        ],
      ),
    );
  }
}
