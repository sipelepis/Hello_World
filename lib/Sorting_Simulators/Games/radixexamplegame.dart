import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(RadixSortApp());
}

class RadixSortApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radix Sort Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RadixSortScreen(),
    );
  }
}

class RadixSortScreen extends StatefulWidget {
  @override
  _RadixSortScreenState createState() => _RadixSortScreenState();
}

class _RadixSortScreenState extends State<RadixSortScreen> {
  List<int> randomNumbers = [];
  List<List<TextEditingController>> stepControllers = [];
  List<int> sortedNumbers = [];
  List<List<bool>> numberVisibility = [];
  Stopwatch stopwatch = Stopwatch();
  String elapsedTime = "03:20";
  Timer? timer;
  int? targetNumber;
  bool gameOver = false;
  bool gameWon = false;
  int currentLevel = 1; // Track the current level (1-5)
  int maxTimeInSeconds = 200; // 3 minutes in seconds

  @override
  void initState() {
    super.initState();
    _generateRandomNumbers();
  }

  void _generateRandomNumbers() {
    Random random = Random();
    int numberOfDigits =
        currentLevel + 2; // Increase difficulty by adding more digits
    randomNumbers = List.generate(
        5,
        (_) =>
            pow(10, numberOfDigits - 1).toInt() +
            random.nextInt(pow(10, numberOfDigits).toInt() -
                pow(10, numberOfDigits - 1).toInt()));
    _startSorting();
    _pickTargetNumber();
  }

  void _pickTargetNumber() {
    Random random = Random();
    targetNumber = randomNumbers[random.nextInt(randomNumbers.length)];
  }

  @override
  void dispose() {
    for (var step in stepControllers) {
      for (var controller in step) {
        controller.dispose();
      }
    }
    timer?.cancel();
    super.dispose();
  }

  Future<void> _startSorting() async {
    // Reset and start the stopwatch
    stopwatch.reset();
    stopwatch.start();

    // Ensure the timer is started only once
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      _updateElapsedTime(); // Update time every second
    });

    // Sorting logic remains unchanged
    List<int> numbers = List.from(randomNumbers);
    int maxDigits = _getMaxDigits(numbers);
    List<List<int>> steps = [];

    for (int digitPlace = 1; digitPlace <= maxDigits; digitPlace++) {
      steps.add(List.from(numbers));
      numbers = await _radixSortStep(numbers, digitPlace);
    }

    sortedNumbers = List.from(numbers);
    steps.add(List.from(sortedNumbers));

    setState(() {
      stepControllers = steps.map((step) {
        return step
            .map((number) => TextEditingController(text: number.toString()))
            .toList();
      }).toList();

      numberVisibility = List.generate(stepControllers.length,
          (_) => List.generate(stepControllers[0].length, (_) => false));
    });

    // Do not stop the stopwatch immediately, let it continue for the countdown
  }

  void _updateElapsedTime() {
    // Get the total elapsed time in seconds
    final elapsedSeconds = stopwatch.elapsed.inSeconds;

    // Calculate the remaining time
    final remainingTime = maxTimeInSeconds - elapsedSeconds;

    // If the remaining time is 0 or less, stop the game
    if (remainingTime <= 0) {
      timer?.cancel(); // Cancel the timer to stop updates
      stopwatch.stop(); // Stop the stopwatch

      setState(() {
        elapsedTime = "00:00"; // Display time as 00:00
        gameOver = true; // Set gameOver to true to end the game
      });

      // Show "Times Up" dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Times Up!",
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            content: Text("You ran out of time!"),
            actions: [
              TextButton(
                child: Text("Try Again"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _resetGame(); // Reset all relevant variables to refresh the screen
                },
              ),
            ],
          );
        },
      );
    } else {
      // Calculate remaining minutes and seconds
      final minutes = (remainingTime ~/ 60).toString().padLeft(2, '0');
      final seconds = (remainingTime % 60).toString().padLeft(2, '0');

      // Update the UI with the countdown timer
      setState(() {
        elapsedTime = "$minutes:$seconds";
      });
    }
  }

  void _resetGame() {
    setState(() {
      currentLevel = 1; // Reset to level 1
      randomNumbers = [];
      stepControllers = [];
      sortedNumbers = [];
      numberVisibility = [];
      gameOver = false; // Reset game state
      gameWon = false;
      elapsedTime = "05:00"; // Reset timer to 5 minutes
      stopwatch.reset(); // Reset stopwatch
      timer?.cancel(); // Cancel any existing timer
    });
    _generateRandomNumbers(); // Generate new numbers and start a new game
  }

  Future<List<int>> _radixSortStep(List<int> numbers, int digitPlace) async {
    int radix = 10;
    List<List<int>> buckets = List.generate(radix, (_) => []);

    for (int num in numbers) {
      int digit = (num ~/ pow(radix, digitPlace - 1)) % radix;
      buckets[digit].add(num);
    }

    return buckets.expand((bucket) => bucket).toList();
  }

  int _getMaxDigits(List<int> numbers) {
    return numbers
        .map((num) => num.toString().length)
        .reduce((a, b) => a > b ? a : b);
  }

  void _handleSelection(int number, int index, int idx) {
    if (gameOver || gameWon) return;

    if (number == targetNumber) {
      setState(() {
        numberVisibility[index][idx] = true; // Reveal the number
      });

      // Check if the game is won after updating the state
      Future.delayed(Duration(milliseconds: 100), () {
        checkGameWin(); // Check for win condition
      });
    } else {
      setState(() {
        gameOver = true;
      });

      // Show "You Lose" dialog when the player selects the wrong number
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Game Over",
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            content: Text("You Lose!"),
            actions: [
              TextButton(
                child: Text("Try Again"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    // Reset all relevant variables to refresh the screen
                    currentLevel = 1; // Reset to level 1
                    randomNumbers = [];
                    stepControllers = [];
                    sortedNumbers = [];
                    numberVisibility = [];
                    gameOver = false;
                    gameWon = false;
                    elapsedTime = "00:00"; // Reset the timer display
                  });
                  _generateRandomNumbers(); // Generate new numbers and start a new game
                },
              ),
            ],
          );
        },
      );
    }
  }

  void checkGameWin() {
    // Check if all occurrences of the target number are revealed
    bool allTargetNumbersRevealed = true;

    for (int i = 0; i < stepControllers.length; i++) {
      for (int j = 0; j < stepControllers[i].length; j++) {
        if (int.parse(stepControllers[i][j].text) == targetNumber &&
            !numberVisibility[i][j]) {
          allTargetNumbersRevealed = false; // Target number not fully revealed
          break;
        }
      }
    }

    if (allTargetNumbersRevealed) {
      setState(() {
        gameWon = true;
      });

      // Show "You Win" dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Congratulations! You completed Level $currentLevel",
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            content: Text(currentLevel < 5
                ? "Proceed to the next level?"
                : "You have completed all levels!"),
            actions: [
              if (currentLevel < 5)
                TextButton(
                  child: Text("Next Level"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      // Move to the next level
                      currentLevel++;
                      // Reset game state for the next level
                      randomNumbers = [];
                      stepControllers = [];
                      sortedNumbers = [];
                      numberVisibility = [];
                      gameOver = false;
                      gameWon = false;
                      elapsedTime = "00:00"; // Reset timer
                    });
                    _generateRandomNumbers(); // Start the next level
                  },
                ),
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    // Reset game state for a new game
                    currentLevel = 1; // Reset to Level 1
                    randomNumbers = [];
                    stepControllers = [];
                    sortedNumbers = [];
                    numberVisibility = [];
                    gameOver = false;
                    gameWon = false;
                    elapsedTime = "00:00"; // Reset timer
                  });
                  _generateRandomNumbers(); // Start a new game
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radix Sort Game'),
        backgroundColor: Color.fromARGB(255, 26, 77, 100),
      ),
      backgroundColor: const Color.fromARGB(255, 44, 82, 107),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        330.0, // Max width based on the approximate width of 3 digits
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 82, 82, 82),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 82, 82, 82),
                      width: 3.0,
                    ),
                  ),
                  child: AutoSizeText(
                    ' ${randomNumbers.join(", ")}',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    maxLines: 1, // Ensure text remains in a single line
                    minFontSize: 10, // Minimum font size for shrinkage
                    overflow:
                        TextOverflow.ellipsis, // Ellipsis if it still overflows
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 82, 82, 82),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 82, 82, 82),
                      width: 3.0,
                    ),
                  ),
                  child: Text(
                    'Level $currentLevel',
                    style: TextStyle(
                      fontSize: 23,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            // Text(
            //   'Find the number: ',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            Text(
              'Find the number: $targetNumber',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 51, 167, 109), // Text color
              ),
            ),
            //   ],
            // ),
            SizedBox(height: 16.0),

            // Expanded placed here to handle the flexible space
            Expanded(
              // Container for all the number boxes with a border
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100], // Set the background color here
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 161, 64),
                    width: 8.0, // Outer border
                  ),
                  borderRadius: BorderRadius.circular(
                      12.0), // Rounded corners for the container
                ),
                child: ListView.builder(
                  itemCount: stepControllers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Enable horizontal scrolling
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: stepControllers[index]
                                .asMap()
                                .entries
                                .map((entry) {
                              int idx = entry.key;
                              TextEditingController controller = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  if (!numberVisibility[index][idx]) {
                                    _handleSelection(
                                        int.parse(controller.text), index, idx);
                                  }
                                },
                                child: _buildNumberBox(
                                    controller, numberVisibility[index][idx]),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 16.0),
            if (gameWon)
              Text(
                'You Win!',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            SizedBox(height: 16.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Spacer(),
              Spacer(),
              Text(
                'Time: $elapsedTime',
                style: TextStyle(
                    fontSize: 30, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              Spacer(),
            ])
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBox(TextEditingController controller, bool isVisible) {
    return Container(
      margin: EdgeInsets.all(9.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        border: Border.all(
          color: const Color.fromARGB(255, 29, 96, 128), // White border
          width: 5.0, // Thicker border
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        isVisible ? controller.text : '?',
        style: TextStyle(
          fontSize: 33.0,
          color: Colors.black, // Set the font color to black
          fontWeight: FontWeight.bold, // Make the font bold
        ),
      ),
    );
  }
}
