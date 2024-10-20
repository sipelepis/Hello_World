import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(HangmanGame());
}

class HangmanGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HangmanScreen(),
    );
  }
}

class HangmanScreen extends StatefulWidget {
  @override
  _HangmanScreenState createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  final List<String> words = [
    'FLUTTER',
    'DEVELOPER',
    'HANGMAN',
    'WIDGET',
    'STATEFUL'
  ];
  String selectedWord = '';
  List<String> guessedLetters = [];
  int incorrectGuesses = 0;
  final int maxIncorrectGuesses = 6;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      selectedWord = words[Random().nextInt(words.length)];
      guessedLetters = [];
      incorrectGuesses = 0;
    });
  }

  void guessLetter(String letter) {
    setState(() {
      if (selectedWord.contains(letter)) {
        guessedLetters.add(letter);
      } else {
        incorrectGuesses++;
      }
    });
  }

  bool isGameWon() {
    for (int i = 0; i < selectedWord.length; i++) {
      if (!guessedLetters.contains(selectedWord[i])) {
        return false;
      }
    }
    return true;
  }

  bool isGameOver() {
    return incorrectGuesses >= maxIncorrectGuesses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hangman drawing (stick figure representation)
          HangmanDrawing(incorrectGuesses: incorrectGuesses),
          SizedBox(height: 20),

          // Display hidden word with blanks
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedWord.split('').map((letter) {
              return Text(
                guessedLetters.contains(letter) ? letter : '_',
                style: TextStyle(fontSize: 30),
              );
            }).toList(),
          ),
          SizedBox(height: 20),

          // Display alphabet letters for guessing
          Wrap(
            spacing: 10,
            children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
              return ElevatedButton(
                onPressed: guessedLetters.contains(letter) || isGameOver()
                    ? null
                    : () => guessLetter(letter),
                child: Text(letter),
              );
            }).toList(),
          ),
          SizedBox(height: 20),

          // Display win or lose message
          if (isGameWon())
            Text(
              'Congratulations! You Won!',
              style: TextStyle(fontSize: 24, color: Colors.green),
            )
          else if (isGameOver())
            Column(
              children: [
                Text(
                  'Game Over! The word was $selectedWord',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: resetGame,
                  child: Text('Play Again'),
                )
              ],
            )
        ],
      ),
    );
  }
}

// Widget to draw the hangman stick figure based on incorrect guesses
class HangmanDrawing extends StatelessWidget {
  final int incorrectGuesses;

  HangmanDrawing({required this.incorrectGuesses});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(150, 250),
        painter: HangmanPainter(incorrectGuesses),
      ),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Drawing the gallows
    canvas.drawLine(Offset(size.width * 0.25, size.height * 0.9),
        Offset(size.width * 0.75, size.height * 0.9), paint); // Base
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.5, size.height * 0.9), paint); // Pole
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.75, size.height * 0.1), paint); // Top bar
    canvas.drawLine(Offset(size.width * 0.75, size.height * 0.1),
        Offset(size.width * 0.75, size.height * 0.2), paint); // Rope

    // Drawing the hangman based on incorrect guesses
    if (incorrectGuesses > 0) {
      canvas.drawCircle(
          Offset(size.width * 0.75, size.height * 0.3), 20, paint); // Head
    }
    if (incorrectGuesses > 1) {
      canvas.drawLine(Offset(size.width * 0.75, size.height * 0.35),
          Offset(size.width * 0.75, size.height * 0.55), paint); // Body
    }
    if (incorrectGuesses > 2) {
      canvas.drawLine(Offset(size.width * 0.75, size.height * 0.4),
          Offset(size.width * 0.70, size.height * 0.45), paint); // Left arm
    }
    if (incorrectGuesses > 3) {
      canvas.drawLine(Offset(size.width * 0.75, size.height * 0.4),
          Offset(size.width * 0.80, size.height * 0.45), paint); // Right arm
    }
    if (incorrectGuesses > 4) {
      canvas.drawLine(Offset(size.width * 0.75, size.height * 0.55),
          Offset(size.width * 0.70, size.height * 0.65), paint); // Left leg
    }
    if (incorrectGuesses > 5) {
      canvas.drawLine(Offset(size.width * 0.75, size.height * 0.55),
          Offset(size.width * 0.80, size.height * 0.65), paint); // Right leg
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
