import 'package:flutter/material.dart';

class MergeSortPage extends StatefulWidget {
  const MergeSortPage({Key? key}) : super(key: key);

  @override
  State<MergeSortPage> createState() => _MergeSortPageState();
}

class _MergeSortPageState extends State<MergeSortPage> {
  List<int> stack = [];
  TextEditingController inputController = TextEditingController();
  bool isSorting = false;

  Future<void> sort() async {
    setState(() {
      isSorting = true;
    });

    await mergeSort(0, stack.length - 1);

    setState(() {
      isSorting = false;
    });
  }

  Future<void> mergeSort(int low, int high) async {
    if (low < high) {
      int mid = (low + high) ~/ 2;
      await mergeSort(low, mid);
      await mergeSort(mid + 1, high);
      await merge(low, mid, high);
    }
  }

  Future<void> merge(int low, int mid, int high) async {
    List<int> temp = List.filled(stack.length, 0);

    int i = low;
    int j = mid + 1;
    int k = low;

    while (i <= mid && j <= high) {
      setState(() {
        if (stack[i] <= stack[j]) {
          temp[k++] = stack[i++];
        } else {
          temp[k++] = stack[j++];
        }
      });
      await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
    }

    while (i <= mid) {
      setState(() {
        temp[k++] = stack[i++];
      });
      await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
    }

    while (j <= high) {
      setState(() {
        temp[k++] = stack[j++];
      });
      await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
    }

    for (i = low; i <= high; i++) {
      setState(() {
        stack[i] = temp[i];
      });
      await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
    }
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
        title: Text('Merge Sort Visualization'),
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
            Text('Merge Sort Visualization:'),
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
                                color: isSorting ? Colors.blue : Colors.lightBlue, // Numbers being sorted
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
    home: MergeSortPage(),
  ));
}
