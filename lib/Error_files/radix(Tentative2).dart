import 'package:flutter/material.dart';

class RadixSortPage extends StatefulWidget {
  const RadixSortPage({Key? key}) : super(key: key);

  @override
  State<RadixSortPage> createState() => _RadixSortPageState();
}

class _RadixSortPageState extends State<RadixSortPage> {
  List<List<int>> steps = [];
  TextEditingController inputController = TextEditingController();
  bool isSorting = false;
  bool showVisualization = false; // Set visualization to false initially

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
    _sort();
  }

  Future<void> _sort() async {
    setState(() {
      isSorting = true;
      steps.clear();
      // Commented out the line below to ensure visualization remains hidden until the "Sort" button is clicked
      // showVisualization = true;
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
      });
    }

    setState(() {
      isSorting = false;
      // showVisualization = true; // Set visualization to true when sorting is complete
    });
  }

  Future<void> _sortvisibletrue() async {
    setState(() {
      // Commented out the line below to ensure visualization remains hidden until the "Sort" button is clicked
      showVisualization = true;
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
                      steps.clear();
                      showVisualization = false; // Set visualization to false when clearing
                    });
                    inputController.clear();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sortvisibletrue,
              child: Text('Sort'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RadixSortAnswerPage(steps: steps)),
                );
              },
              child: Text('Answer'),
            ),
            SizedBox(height: 16),
            Text('Radix Sort Visualization:'),
            Text(' '),
            if (showVisualization && !isSorting) // Show visualization only when isSorting is false
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int index = 0; index < steps.length; index++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step ${index + 1}:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < steps[index].length; i++)
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (index == 0 && i < steps[0].length)
                                          ? Colors.grey
                                          : ((i + 1 >= steps[index].length || steps[index][i] != steps[index][i + 1]) && (i == 0 || steps[index][i] != steps[index][i - 1]))
                                              ? Color(0xFF9FE1FF)
                                              : Color(0xFF9FE1FF), // Change to grey if the same as previous
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      steps[index][i].toString(),
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
  final List<List<int>> steps;

  const RadixSortAnswerPage({Key? key, required this.steps}) : super(key: key);

  @override
  _RadixSortAnswerPageState createState() => _RadixSortAnswerPageState();
}

class _RadixSortAnswerPageState extends State<RadixSortAnswerPage> {
  List<List<int?>> filledSteps = [];
  List<bool> isCorrectStep = [];

  @override
  void initState() {
    super.initState();
    _fillSteps();
  }

  void _fillSteps() {
    filledSteps.add(widget.steps[0].map((e) => e as int?).toList());
    isCorrectStep.add(true); // Assume correct initially for the first step
    for (int i = 1; i < widget.steps.length; i++) {
      List<int?> step = List.filled(widget.steps[i].length, null);
      filledSteps.add(step);
      isCorrectStep.add(true); // Assume correct initially for other steps
    }
  }

  void _checkAnswer() {
    for (int i = 0; i < widget.steps.length; i++) {
      isCorrectStep[i] = _isCorrectStep(i);
    }
    setState(() {});
  }

  bool _isCorrectStep(int stepIndex) {
    List<int?> currentStep = filledSteps[stepIndex];
    List<int> visualizationStep = widget.steps[stepIndex];

    if (currentStep.length != visualizationStep.length) {
      return false;
    }

    for (int j = 0; j < currentStep.length; j++) {
      if (currentStep[j] != visualizationStep[j]) {
        return false;
      }
    }

    return true;
  }

  void _clearAnswer() {
  setState(() {
    filledSteps.clear();
    isCorrectStep.clear();
    _fillSteps();
  });
}



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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < filledSteps.length; index++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${index + 1}:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < filledSteps[index].length; i++)
                                Draggable<int>(
                                  data: filledSteps[index][i],
                                  child: DragTarget<int>(
                                    builder: (BuildContext context, List<int?> candidateData, List<dynamic> rejectedData) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isCorrectStep[index] ? Colors.grey : (filledSteps[index][i] != widget.steps[index][i] ? Colors.red : Colors.transparent), // Change color based on correctness
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          filledSteps[index][i]?.toString() ?? '',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    },
                                    onAccept: (int? data) {
                                      if (index != 0) {
                                        setState(() {
                                          filledSteps[index][i] = data;
                                        });
                                      }
                                    },
                                  ),
                                  feedback: Material(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isCorrectStep[index] ? Colors.grey.withOpacity(0.5) : (filledSteps[index][i] != widget.steps[index][i] ? Colors.red.withOpacity(0.5) : Colors.transparent), // Change color based on correctness
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        filledSteps[index][i]?.toString() ?? '',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  childWhenDragging: (index == 0) // Disable dragging for the first step
                                      ? Container(
                                          width: 50,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isCorrectStep[index] ? Colors.grey : (filledSteps[index][i] != widget.steps[index][i] ? Colors.red : Colors.transparent), // Change color based on correctness
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            filledSteps[index][i]?.toString() ?? '',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      : null, // For other steps, allow dragging
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Check'),
            ),
            SizedBox(height: 16),
            isCorrectStep.every((element) => element)
                ? Text(
                    'Correct',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'Wrong answer',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _clearAnswer,
              child: Text('Clear Answer'),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: RadixSortPage(),
  ));
}
