import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    title: 'Radix Sort Visualization',
    home: RadixSortPage(),
  ));
}

class RadixSortPage extends StatefulWidget {
  @override
  _RadixSortPageState createState() => _RadixSortPageState();
}

class _RadixSortPageState extends State<RadixSortPage> {
  final TextEditingController inputController = TextEditingController();
  List<List<TextEditingController>> stepControllers = [];
  List<int> SortedNumbers = [];

  void _insertAndSort() {
    if (inputController.text.isEmpty) return;
    setState(() {
      stepControllers.clear(); // Clear previous steps
    });
    _sort();
  }

  void _insertit() {
    if (inputController.text.isEmpty) return;
    List<TextEditingController> newStep = inputController.text
        .split(',')
        .map((e) => TextEditingController(text: e.trim()))
        .toList();
    setState(() {
      stepControllers.add(newStep);
      inputController.clear(); // Clear the input field after insertion
    });
  }

  void _checkAnswer() {
  if (stepControllers.isNotEmpty) {
    List<int> numbers = stepControllers[0]
        .map((controller) => int.tryParse(controller.text) ?? 0)
        .toList();
    _performRadixSortAndPrint(numbers, stepControllers);
  } else {
    print("No steps available.");
  }
}

Future<void> _performRadixSortAndPrint(List<int> numbers, List<List<TextEditingController>> stepControllers) async {
  int maxDigits = _getMaxDigits(numbers);
  int totalDigits = maxDigits; // Adjust the totalDigits to maxDigits initially

  List<List<int>> steps = [];

  for (int digitPlace = 1; digitPlace <= totalDigits; digitPlace++) {
    steps.add(List.from(numbers));
    numbers = await _radixSortStep(numbers, digitPlace);

    // If any number has more digits than currently considered, update totalDigits
    int newMaxDigits = _getMaxDigits(numbers);
    if (newMaxDigits > totalDigits) {
      totalDigits = newMaxDigits;
    }
  }

  // Add the final sorted list to the steps
  steps.add(List.from(numbers));

  // Check if the total count of steps is equal to the count of stepControllers
  if (steps.length != stepControllers.length) {
    _showResultDialog("Total count of steps is not equal to the count of stepControllers.", true);
    return;
  }

  // Print all steps with their respective step numbers
  for (int i = 0; i < steps.length; i++) {
    print("Step ${i + 1}: ${steps[i]}");
  }

  // Check if all steps are equal to a given list
  _compareSteps(steps, stepControllers);
}


  void _compareSteps(List<List<int>> steps, List<List<TextEditingController>> stepControllers) {
    bool allEqual = true;
    for (int i = 0; i < steps.length; i++) {
      List<int> step = steps[i];
      List<TextEditingController> controllerStep = stepControllers[i];
      if (step.length != controllerStep.length) {
        allEqual = false;
        break;
      }
      for (int j = 0; j < step.length; j++) {
        int stepValue = step[j];
        int controllerValue = int.tryParse(controllerStep[j].text) ?? 0;
        if (stepValue != controllerValue) {
          allEqual = false;
          break;
        }
      }
      if (!allEqual) {
        break;
      }
    }

    if (allEqual) {
      _showResultDialog("All steps are equal to the comparison list.", false);
    } else {
      _showResultDialog("Not all steps are equal to the comparison list.", true);
    }

    // Print the numbers collected from all steps values
    print("Numbers collected from all steps:");
    for (List<int> step in steps) {
      print(step);
    }
  }

  void _showResultDialog(String message, bool isError) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Comparison Result"),
        content: Text(
          message,
          style: TextStyle(
            color: isError ? Colors.red : Colors.black, // Set text color to red if isError is true
          ),
        ),
        backgroundColor: Colors.white, // Set background color to white
        shape: isError
            ? RoundedRectangleBorder(
                side: BorderSide(color: Colors.red), // Add red border if isError is true
                borderRadius: BorderRadius.circular(10.0),
              )
            : null,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}



  Future<void> _sort() async {
    List<int> numbers = inputController.text
        .split(',')
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();

    int maxDigits = _getMaxDigits(numbers);
    int totalDigits = maxDigits; // Adjust the totalDigits to maxDigits initially

    List<List<int>> steps = [];

    for (int digitPlace = 1; digitPlace <= totalDigits; digitPlace++) {
      steps.add(List.from(numbers));
      numbers = await _radixSortStep(numbers, digitPlace);

      // If any number has more digits than currently considered, update totalDigits
      int newMaxDigits = _getMaxDigits(numbers);
      if (newMaxDigits > totalDigits) {
        totalDigits = newMaxDigits;
      }
    }

    // Add the final sorted list to the steps and store it in SortedNumbers
    SortedNumbers = List.from(numbers);
    steps.add(List.from(numbers));

    setState(() {
      stepControllers = steps.map((step) {
        return step
            .map((number) => TextEditingController(text: number.toString()))
            .toList();
      }).toList();
    });
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
    int maxDigits = 0;
    for (int num in numbers) {
      int numDigits = num.toString().length;
      if (numDigits > maxDigits) {
        maxDigits = numDigits;
      }
    }
    return maxDigits;
  }

  Widget _buildStep(int index, bool isErrorStep) {
    return Row(
      children: [
        Text('Step ${index + 1}: '),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stepControllers[index].length,
              itemBuilder: (context, idx) {
                return Container(
                  width: 60,
                  margin: EdgeInsets.only(right: 10),
                  child: TextFormField(
                    controller: stepControllers[index][idx],
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isErrorStep ? Colors.red : Colors.grey, // Apply red border if isErrorStep is true
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radix Sort Visualization')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: inputController,
              decoration:
                  InputDecoration(labelText: 'Enter numbers (comma-separated)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _insertit,
                  child: Text('Insert'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => stepControllers.clear()),
                  child: Text('Clear Steps'),
                ),
                ElevatedButton(
                  onPressed: _insertAndSort, // Placeholder for "Sort" button
                  child: Text('Sort'),
                ),
                ElevatedButton(
                  onPressed: _checkAnswer, // Placeholder for "Check" button
                  child: Text('Check'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit Step/s'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Scan Text'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {}, // Placeholder for "How to use" button
              child: Text('How to use'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stepControllers.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildStep(index, index != stepControllers.length - 1), // Pass true to indicate error for the last step
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
