import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RadixSortAnswerPage(),
      '/visualization': (context) => RadixSortPage(),
    },
  ));
}

class RadixSortPage extends StatefulWidget {
  const RadixSortPage({Key? key}) : super(key: key);

  @override
  State<RadixSortPage> createState() => _RadixSortPageState();
}

class _RadixSortPageState extends State<RadixSortPage> {
  List<List<int>> steps = [];
  TextEditingController inputController = TextEditingController();
  bool isSorting = false;
  int currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    inputController.addListener(_onInputTextChanged);
  }

  @override
  void dispose() {
    inputController.removeListener(_onInputTextChanged);
    super.dispose();
  }

  void _onInputTextChanged() {
    setState(() {
      // Reset the sorting process when input changes
      steps.clear();
      currentStepIndex = 0;
    });
  }

  Future<void> _sort() async {
    setState(() {
      isSorting = true;
      steps.clear();
    });

    int maxDigits = _getMaxDigits();
    List<int> currentStep =
        List.from(inputController.text.split(',').map((e) => int.parse(e.trim())));

    // Add the initial step (input)
    steps.add(List.from(currentStep));

    for (int digitPlace = 1; digitPlace <= maxDigits; digitPlace++) {
      List<int> sortedStep = await _countingSort(List.from(currentStep), digitPlace);
      setState(() {
        steps.add(List.from(sortedStep));
        currentStep = List.from(sortedStep);
        currentStepIndex++; // Move to the next step
      });
    }

    setState(() {
      isSorting = false;
    });
  }

  Future<List<int>> _countingSort(List<int> inputList, int digitPlace) async {
    int n = inputList.length;
    List<int> output = List.filled(n, 0);
    int exp = 1;

    for (int i = 0; i < digitPlace - 1; i++) {
      exp *= 10;
    }

    List<int> count = List.filled(10, 0);

    for (int i = 0; i < n; i++) {
      int digit = (inputList[i] ~/ exp) % 10;
      count[digit]++;
    }

    for (int i = 1; i < 10; i++) {
      count[i] += count[i - 1];
    }

    for (int i = n - 1; i >= 0; i--) {
      int digit = (inputList[i] ~/ exp) % 10;
      output[count[digit] - 1] = inputList[i];
      count[digit]--;
    }

    return output;
  }

  int _getMaxDigits() {
    int maxDigits = 0;
    List<int> inputList =
        inputController.text.split(',').map((e) => int.parse(e.trim())).toList();
    for (int num in inputList) {
      int numDigits = num.toString().length;
      if (numDigits > maxDigits) {
        maxDigits = numDigits;
      }
    }
    return maxDigits;
  }

  void _insertAndSort() {
    _sort(); // Start sorting process
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radix Sort Visualization'),
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
                      // Remove any non-numeric characters from the input
                      setState(() {
                        // Filter out non-numeric characters
                        final newValue = value.replaceAll(RegExp(r'[^0-9,]'), '');
                        // If the new value is different, set it to the controller
                        if (newValue != value) {
                          inputController.value = TextEditingValue(
                            text: newValue,
                            selection: TextSelection.collapsed(offset: newValue.length),
                          );
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter numbers (comma-separated)',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      inputController.clear();
                    });
                  },
                  child: Text('Clear'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _insertAndSort,
                  child: Text('Insert'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/visualization',
                  arguments: {'steps': steps},
                );
              },
              child: Text('Answer'),
            ),
            SizedBox(height: 16),
            Text('Radix Sort Visualization:'),
            Text(' '),
            if (steps.isNotEmpty && currentStepIndex < steps.length)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${currentStepIndex + 1}:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < steps[currentStepIndex].length; i++)
                                Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    steps[currentStepIndex][i].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RadixSortAnswerPage extends StatefulWidget {
  const RadixSortAnswerPage({Key? key}) : super(key: key);

  @override
  State<RadixSortAnswerPage> createState() => _RadixSortAnswerPageState();
}

class _RadixSortAnswerPageState extends State<RadixSortAnswerPage> {
  List<int> filledSteps = [];
  List<int> sortedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radix Sort Answer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Radix Sort Answer:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < sortedList.length; i++)
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: sortedList[i] == filledSteps[i] ? Colors.green : Colors.red,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        sortedList[i].toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement logic to check the answer
              },
              child: Text('Check'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Clear answer and go back
                Navigator.pop(context);
              },
              child: Text('Clear Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
