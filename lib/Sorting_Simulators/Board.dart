import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart'; // Import audioplayers for audio playback

void main() {
  runApp(SliderGameApp());
}

class SliderGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slider Puzzle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SliderGameScreen(),
    );
  }
}

class SliderGameScreen extends StatefulWidget {
  @override
  _SliderGameScreenState createState() => _SliderGameScreenState();
}

class _SliderGameScreenState extends State<SliderGameScreen> {
  late List<int> _numbers; // The list that holds the numbers
  int _gridSize = 4; // Grid size is 4x4 (16 slots)
  double _tileSize = 100; // Size of each tile for the animation
  Duration _slideDuration =
      Duration(milliseconds: 700); // Slide animation duration
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Create an instance of AudioPlayer

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  // Initialize the game with custom numbers
  void _initGame() {
    // Example array of numbers to be displayed
    List<int> customNumbers = [
      13,
      33,
      42,
      45,
      12,
      46,
      0,
      11,
      21,
      23,
      25,
      19,
      35,
      36,
      41,
      34
    ];

    _numbers = List<int>.from(customNumbers); // Copy the numbers into _numbers
    setState(() {}); // Refresh the UI with new numbers
  }

  // Handle tile tap
  void _onTileTap(int index) async {
    final emptyIndex = _numbers.indexOf(0); // Find the empty tile (0)
    if (_canSwap(index, emptyIndex)) {
      // Play the sound effect
      await _audioPlayer
          .play(AssetSource('assets/block-6839.ogg')); // Play the sound

      setState(() {
        // Swap the tapped tile with the empty tile
        _numbers[emptyIndex] = _numbers[index];
        _numbers[index] = 0;
      });
    }
  }

  // Determine if the tile can be swapped with the empty tile
  bool _canSwap(int currentIndex, int emptyIndex) {
    int row1 = currentIndex ~/ _gridSize;
    int col1 = currentIndex % _gridSize;
    int row2 = emptyIndex ~/ _gridSize;
    int col2 = emptyIndex % _gridSize;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Puzzle Game'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _initGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
        crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
        children: [
          SizedBox(height: 50), // Optional: adds space from the top
          Align(
            alignment: Alignment.topCenter, // Align horizontally to the center
            child: Container(
              width: _tileSize * _gridSize,
              height: _tileSize * _gridSize,
              child: Stack(
                children: List.generate(
                  _gridSize * _gridSize,
                  (index) =>
                      _buildTile(index), // Correctly handle tile positions
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the tile widget for each number
  Widget _buildTile(int index) {
    int number = _numbers[index]; // Get the number for the current tile
    if (number == 0) return SizedBox(); // Don't display the empty tile (0)

    // Calculate the row and column based on the tile's current position (index in _numbers)
    final int targetRow = index ~/ _gridSize;
    final int targetCol = index % _gridSize;

    return AnimatedPositioned(
      duration: _slideDuration,
      curve: Curves.easeInOut, // Animation curve for smooth motion
      top: targetRow * _tileSize, // Position based on row
      left: targetCol * _tileSize, // Position based on column
      child: GestureDetector(
        onTap: () => _onTileTap(index), // Handle tile tap
        child: Container(
          width: _tileSize - 8,
          height: _tileSize - 8,
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              '$number', // Display the number
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
