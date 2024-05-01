// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gallery_picker/gallery_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:collection/collection.dart'; // Import the collection package

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? selectedMedia;
//   TextEditingController _textEditingController = TextEditingController();
//   String _result = '';

//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "Text Recognition",
//         ),
//       ),
//       body: _buildUI(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           List<MediaFile>? media = await GalleryPicker.pickMedia(
//             context: context,
//             singleMedia: true,
//           );
//           if (media != null && media.isNotEmpty) {
//             var data = await media.first.getFile();
//             setState(() {
//               selectedMedia = data;
//             });
//             String? text = await _extractText(data);
//             if (text != null) {
//               _compareText(text);
//             }
//           }
//         },
//         child: const Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }

//   Widget _buildUI() {
//   return Column(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       // Remove the _inputField() widget
//       _imageView(),
//       _extractTextView(),
//       _showResult(),
//     ],
//   );
// }


//   Widget _inputField() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Enter numbers separated by commas',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 // You can handle the input value here
//               },
//             ),
//           ),
//           SizedBox(width: 8.0),
//           ElevatedButton(
//             onPressed: () {
//               _performRadixSort();
//             },
//             child: Text('Sort'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _imageView() {
//   if (selectedMedia == null) {
//     return const Center(
//       child: Text("Pick an image for text recognition."),
//     );
//   }
//   return Center(
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color.fromARGB(255, 136, 134, 134), width: 2.0), // Set border properties here
//       ),
//       child: Image.file(
//         selectedMedia!,
//         width: 400,
//       ),
//     ),
//   );
// }


//   Widget _extractTextView() {
//   if (selectedMedia == null) {
//     return const Center(
//       child: Text("No result."),
//     );
//   }
//   return Container(
//     color: Colors.grey[200], // Set the background color here
//     padding: EdgeInsets.all(8.0), // Optional: Adjust padding as needed
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: FutureBuilder(
//         future: _extractText(selectedMedia!),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Show loading indicator while waiting for text extraction
//           } else if (snapshot.hasError) {
//             return Text("Error: ${snapshot.error}");
//           } else if (snapshot.hasData) {
//             String extractedText = snapshot.data as String;
//             List<int> extractedNumbers = extractedText
//                 .split(',')
//                 .map((number) => int.tryParse(number.trim()) ?? 0)
//                 .toList();

//             return Wrap(
//               spacing: 10,
//               children: extractedNumbers.map((number) {
//                 return Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     number.toString(),
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 );
//               }).toList(),
//             );
//           } else {
//             return Text("No data available");
//           }
//         },
//       ),
//     ),
//   );
// }


//   Widget _showResult() {
//     return Text(
//       _result,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: _result == 'Correct' ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   Future<String?> _extractText(File file) async {
//     final textRecognizer = TextRecognizer(
//       script: TextRecognitionScript.latin,
//     );
//     final InputImage inputImage = InputImage.fromFile(file);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);
//     String text = recognizedText.text;
//     textRecognizer.close();
//     // Format the text to display numbers separated by commas
//     List<String> numbers = text.split(RegExp(r'\D+')).where((element) => element.isNotEmpty).toList();
//     text = numbers.join(', ');
//     return text;
//   }

//   void _performRadixSort() {
//     String input = _textEditingController.text;
//     List<String> numbers = input.split(',').map((e) => e.trim()).toList();
//     List<int> sortedNumbers = radixSort(numbers.map(int.parse).toList());
//     // Show the sorted numbers or perform any other action
//     print(sortedNumbers);
//     _compareText(sortedNumbers.join(', '));
//   }

//   List<int> radixSort(List<int> list) {
//     // Implement radix sort logic here
//     return list..sort();
//   }

//   void _compareText(String capturedText) {
//     String inputText = _textEditingController.text;
//     List<int> inputNumbers = inputText.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
//     List<int> capturedNumbers = capturedText.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();

//     inputNumbers.sort();
//     capturedNumbers.sort();

//     var listEquals = DeepCollectionEquality().equals; // Using DeepCollectionEquality to compare lists

//     if (listEquals(inputNumbers, capturedNumbers)) {
//       setState(() {
//         _result = 'Correct';
//       });
//     } else {
//       setState(() {
//         _result = 'Wrong answer';
//       });
//     }
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
