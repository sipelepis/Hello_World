import 'package:flutter/material.dart';

class InsertionSortPage extends StatefulWidget {
  const InsertionSortPage({Key? key}) : super(key: key);

  @override
  State<InsertionSortPage> createState() => _InsertionSortPageState();
}

class _InsertionSortPageState extends State<InsertionSortPage> {
  List<int> stack = [];
  TextEditingController inputController = TextEditingController();
  int currentIndex = -1;
  int movingIndex = -1;
  bool isSorting = false;

  Future<void> sort() async {
    setState(() {
      isSorting = true;
    });

    for (int i = 1; i < stack.length; i++) {
      int key = stack[i];
      int j = i - 1;

      setState(() {
        currentIndex = i; // Highlight the current element in red
      });
      await Future.delayed(Duration(milliseconds: 2800)); // Early highlighting before moving

      while (j >= 0 && stack[j] > key) {
        setState(() {
          stack[j + 1] = stack[j];
          stack[j] = key; // Swap values for animation
          movingIndex = j; // Highlight the moving index in red
        });
        await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
        setState(() {
          movingIndex = -1; // Reset the moving index
          currentIndex = j; // Highlight the current element in red again
        });
        await Future.delayed(Duration(milliseconds: 1000)); // Adjust delay for slower animation
        j--;
      }

      setState(() {
        currentIndex = -1; // Reset the current element index
      });
      await Future.delayed(Duration(milliseconds: 1000)); // Additional delay for visualization
    }

    setState(() {
      // Set all numbers to green once sorting is done
      isSorting = false;
      currentIndex = -1;
      movingIndex = -1;
    });
  }

  void insertNumbers() {
    List<String> inputNumbers = inputController.text.split(',');
    for (String numStr in inputNumbers) {
      int number = int.tryParse(numStr.trim()) ?? 0;
      if (number != 0) {
        setState(() {
          stack.add(number);
        });
      }
    }
    inputController.clear(); // Clear the input text field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertion Sort Visualization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter numbers (comma-separated)',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: insertNumbers,
                  child: Text('Insert'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      stack.clear();
                    });
                    inputController.clear(); // Clear the input text field
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sort,
              child: Text('Sort'),
            ),
            SizedBox(height: 16),
            Text('Insertion Sort Visualization:'),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < stack.length; i++)
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 500), // Adjust duration for slower animation
                        tween: Tween<double>(
                          begin: i.toDouble(),
                          end: stack.indexOf(stack[i]).toDouble(),
                        ),
                        builder: (context, double value, child) {
                          return Transform.translate(
                            offset: Offset(value * 30, 0), // Adjust the value for spacing
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500), // Adjust duration for slower animation
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (isSorting && i == currentIndex)
                                    ? Colors.red // Highlight the current element in red
                                    : (isSorting && i == movingIndex)
                                        ? Colors.blue // Highlight the moving element in blue
                                        : Colors.lightBlue, // Numbers being sorted
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                stack[i].toString(),
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InsertionSortPage(),
  ));
}
