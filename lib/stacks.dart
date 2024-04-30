import 'package:flutter/material.dart';

class StacksPage extends StatefulWidget {
  const StacksPage({Key? key}) : super(key: key);

  @override
  State<StacksPage> createState() => _StacksPageState();
}

class _StacksPageState extends State<StacksPage> {
  List<int> stack = [];
  String input = '';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void push(int number) {
    setState(() {
      int index = stack.length;
      stack.add(number);
      _listKey.currentState
          ?.insertItem(index, duration: Duration(milliseconds: 500));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The $number has been pushed.'),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  void pop() {
    // setState(() {
    //   if (stack.isNotEmpty) {
    //     int poppedNumber = stack.removeLast();
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: Text('Pop'),
    //         content: Text('The $poppedNumber has been popped.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // });
    setState(() {
      if (stack.isNotEmpty) {
        int poppedNumber = stack.removeLast();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The $poppedNumber has been popped.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void popNumber(int number) {
    setState(() {
      if (stack.contains(number)) {
        stack.remove(number);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The $number has been popped.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The number $number does not exist in the stack.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Push'),
                        content: TextField(
                          onChanged: (value) {
                            setState(() {
                              input = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter a number',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              int number = int.tryParse(input.trim()) ?? 0;
                              push(number);
                              Navigator.pop(context);
                            },
                            child: Text('Push'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Push (Input)'),
                ),
                ElevatedButton(
                  onPressed: pop,
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.red,
                  ),
                  child: Text('Pop()'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Pop()'),
                        content: TextField(
                          onChanged: (value) {
                            setState(() {
                              input = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter a number to pop',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              int number = int.tryParse(input.trim()) ?? 0;
                              popNumber(number);
                              Navigator.pop(context);
                            },
                            child: Text('Pop Number'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Pop (Input)'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Stack Visualization:'),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Stack'),
                      SizedBox(height: 8),
                      for (int i = stack.length - 1; i >= 0; i--)
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // border: Border.all(),
                            color: Colors
                                .lightBlue, // Set background color to light blue
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            stack[i].toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: StacksPage(),
//   ));
// }
