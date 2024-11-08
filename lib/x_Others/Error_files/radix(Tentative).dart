// import 'package:flutter/material.dart';

// class RadixSortPage extends StatefulWidget {
//   const RadixSortPage({Key? key}) : super(key: key);

//   @override
//   State<RadixSortPage> createState() => _RadixSortPageState();
// }

// class _RadixSortPageState extends State<RadixSortPage> {
//   List<int> stack = [];
//   TextEditingController inputController = TextEditingController();
//   int currentIndex = -1;
//   bool isSorting = false;

//   Future<void> sort() async {
//     setState(() {
//       isSorting = true;
//     });

//     int maxDigits = _getMaxDigits();

//     for (int digitPlace = 1; digitPlace <= maxDigits; digitPlace++) {
//       _countingSort(digitPlace);
//       await Future.delayed(
//           Duration(milliseconds: 1500)); // Adjust delay for visualization
//     }

//     setState(() {
//       // Set all numbers to green once sorting is done
//       isSorting = false;
//       currentIndex = -1;
//     });
//   }

//   void _countingSort(int digitPlace) {
//     int n = stack.length;
//     List<int> output = List.filled(n, 0);
//     int maxValue =
//         stack.reduce((value, element) => value > element ? value : element);
//     int exp = 1;

//     for (int i = 0; i < digitPlace - 1; i++) {
//       exp *= 10;
//     }

//     List<int> count = List.filled(10, 0);

//     for (int i = 0; i < n; i++) {
//       int digit = (stack[i] ~/ exp) % 10;
//       count[digit]++;
//     }

//     for (int i = 1; i < 10; i++) {
//       count[i] += count[i - 1];
//     }

//     for (int i = n - 1; i >= 0; i--) {
//       int digit = (stack[i] ~/ exp) % 10;
//       output[count[digit] - 1] = stack[i];
//       count[digit]--;
//     }

//     setState(() {
//       stack = List.from(output);
//     });
//   }

//   int _getMaxDigits() {
//     int maxDigits = 0;
//     for (int num in stack) {
//       int numDigits = num.toString().length;
//       if (numDigits > maxDigits) {
//         maxDigits = numDigits;
//       }
//     }
//     return maxDigits;
//   }

//   void insertNumbers() {
//     List<String> inputNumbers = inputController.text.split(',');
//     for (String numStr in inputNumbers) {
//       int number = int.tryParse(numStr.trim()) ?? 0;
//       if (number != 0) {
//         setState(() {
//           stack.add(number);
//         });
//       }
//     }
//     inputController.clear(); // Clear the input text field
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Radix Sort Visualization'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: inputController,
//                     onChanged: (value) {
//                       setState(() {});
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Enter numbers (comma-separated)',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: insertNumbers,
//                   child: Text('Insert'),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       stack.clear();
//                     });
//                     inputController.clear(); // Clear the input text field
//                   },
//                   child: Text('Clear'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: sort,
//               child: Text('Sort'),
//             ),
//             SizedBox(height: 16),
//             Text('Radix Sort Visualization:'),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     for (int i = 0; i < stack.length; i++)
//                       TweenAnimationBuilder(
//                         duration: Duration(
//                             milliseconds:
//                                 500), // Adjust duration for slower animation
//                         tween: Tween<double>(
//                           begin: i.toDouble(),
//                           end: stack.indexOf(stack[i]).toDouble(),
//                         ),
//                         builder: (context, double value, child) {
//                           return Transform.translate(
//                             offset: Offset(
//                                 value * 30, 0), // Adjust the value for spacing
//                             child: AnimatedContainer(
//                               duration: Duration(
//                                   milliseconds:
//                                       500), // Adjust duration for slower animation
//                               height: 50,
//                               width: 50,
//                               margin: const EdgeInsets.symmetric(horizontal: 5),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: (isSorting && i == currentIndex)
//                                     ? Colors
//                                         .red // Highlight the current element in red
//                                     : Colors.lightBlue, // Numbers being sorted
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 stack[i].toString(),
//                                 style: TextStyle(
//                                     fontSize: 20, color: Colors.white),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: RadixSortPage(),
//   ));
// }
