import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionHandlerWidget(),
    );
  }
}

class PermissionHandlerWidget extends StatefulWidget {
  @override
  _PermissionHandlerWidgetState createState() =>
      _PermissionHandlerWidgetState();
}

class _PermissionHandlerWidgetState extends State<PermissionHandlerWidget> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _questionController = TextEditingController();
  File? selectedMedia;
  String? extractedNumbers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Enter radix sort numbers (e.g., 5 2 8 3)',
              ),
            ),
          ),
          Expanded(
            child: selectedMedia == null
                ? Center(child: Text("Pick an image for text recognition."))
                : _buildUI(),
          ),
          if (extractedNumbers != null)
            Text(
              'Extracted numbers: $extractedNumbers',
              style: TextStyle(fontSize: 18),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _getImageFromGallery();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _imageView(),
        _extractTextView(),
      ],
    );
  }

  Widget _imageView() {
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
      ),
    );
  }

  Widget _extractTextView() {
    return FutureBuilder(
      future: _extractText(selectedMedia!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String? extractedText = snapshot.data as String?;
          bool isCorrect = checkAnswer(extractedText, _questionController.text);
          if (isCorrect) {
            extractedNumbers = extractedText;
          } else {
            extractedNumbers = null;
          }
          return Text(
            isCorrect ? "Correct answer!" : "Incorrect answer.",
            style: TextStyle(
              fontSize: 25,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          );
        }
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    List<MediaFile>? media =
        await GalleryPicker.pickMedia(context: context, singleMedia: true);
    if (media != null && media.isNotEmpty) {
      var data = await media.first.getFile();
      setState(() {
        selectedMedia = data;
      });
    }
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }

  bool checkAnswer(String? extractedText, String? inputQuestion) {
    // Dummy implementation of checking answers
    if (extractedText == null || inputQuestion == null) return false;
    List<String> numbers = inputQuestion.split(' ');
    numbers.removeWhere((element) => element.isEmpty);
    numbers.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    String sortedNumbers = numbers.join(' ');
    return extractedText.contains(sortedNumbers);
  }
}
