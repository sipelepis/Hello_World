import 'package:flutter/material.dart';

class RadixQuiz extends StatefulWidget {
  const RadixQuiz({super.key});

  @override
  _RadixQuizState createState() => _RadixQuizState();
}

class _RadixQuizState extends State<RadixQuiz> {
  final int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the worst-case time complexity of Radix Sort?',
      'answers': [
        {'text': 'O(n)', 'correct': false},
        {'text': 'O(n log n)', 'correct': false},
        {'text': 'O(nk)', 'correct': true},
        {'text': 'O(log n)', 'correct': false},
      ],
    },
    // Add more questions as needed
  ];

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Correct!'),
          content: const Text('You selected the right answer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
                Navigator.of(ctx).pop(); // Return to the previous screen
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Incorrect'),
          content: const Text('You selected the wrong answer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // This will distribute space evenly
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                question['question'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3,
              children: List.generate(question['answers'].length, (index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () =>
                        _answerQuestion(question['answers'][index]['correct']),
                    child: Center(
                      child: Text(
                        question['answers'][index]['text'],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
