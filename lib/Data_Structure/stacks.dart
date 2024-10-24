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


// import 'package:flutter/material.dart';

// class QueuesPage extends StatefulWidget {
//   const QueuesPage({Key? key}) : super(key: key);

//   @override
//   State<QueuesPage> createState() => _QueuesPageState();
// }

// class _QueuesPageState extends State<QueuesPage> with SingleTickerProviderStateMixin {
//   List<int> queue = [];
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   final TextEditingController _inputController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final ScrollController _scrollController = ScrollController(); // Added scroll controller

//   late TabController _tabController;
//   Color _visualizationBorderColor = Colors.grey;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);

//     _focusNode.addListener(() {
//       setState(() {}); // Refresh state on focus change
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _focusNode.dispose();
//     _inputController.dispose();
//     _scrollController.dispose(); // Dispose the scroll controller
//     super.dispose();
//   }

//   void enqueue() {
//     String inputText = _inputController.text.trim();
//     if (inputText.isEmpty) {
//       setState(() {
//         _visualizationBorderColor = Colors.black;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Input field is empty!')),
//       );
//       return;
//     }

//     int? number = int.tryParse(inputText);
//     if (number == null) {
//       setState(() {
//         _visualizationBorderColor = Colors.black;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid input! Please enter a valid number.')),
//       );
//       return;
//     }

//     setState(() {
//       queue.add(number);
//       _listKey.currentState?.insertItem(
//         queue.length - 1,
//         duration: const Duration(milliseconds: 500),
//       );
//       _visualizationBorderColor = Colors.blueAccent;
//     });

//     _inputController.clear();

//     // Scroll to the last item after enqueue
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   void dequeue() {
//   if (queue.isEmpty) {
//     setState(() {
//       _visualizationBorderColor = Colors.black;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Nothing to dequeue!')),
//     );
//     return;
//   }

//   // Get the item to be removed and remove it from the list.
//     int dequeuedNumber = queue.removeAt(0);

//     // Scroll to the item being removed before it disappears (2 sec delay).
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         0.0, // Scroll to the top (first item)
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeOut,
//       );
//     });

//     // Delay the removal for 2 seconds to allow the user to see the item.
//     Future.delayed(const Duration(seconds: 1), () {
//       _listKey.currentState?.removeItem(
//         0,
//         (context, animation) =>
//             _buildItem(dequeuedNumber, animation, dequeuing: true),
//         duration: const Duration(milliseconds: 500), // Fade-out animation duration
//       );

//       setState(() {
//         _visualizationBorderColor = Colors.redAccent;
//       });
//     });
//   }


//   Widget _buildItem(int number, Animation<double> animation, {bool dequeuing = false}) {
//     return SizeTransition(
//       sizeFactor: animation,
//       axis: Axis.horizontal,
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: Offset(dequeuing ? 0 : 1, 0),
//           end: Offset.zero,
//         ).animate(animation),
//         child: FadeTransition(
//           opacity: animation,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//             child: Container(
//               width: 50,
//               height: 50,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: dequeuing ? Colors.red : Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(2, 2),
//                   ),
//                 ],
//               ),
//               child: Text(
//                 number.toString(),
//                 style: const TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Queues',
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 2,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 tabs: [
//                   Tab(
//                     child: Text(
//                       'Simulate',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   Tab(
//                     child: Text(
//                       'I\'ll Take a Shot',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildSimulateTab(),
//           const Center(
//             child: Text(
//               'This feature is under construction.',
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSimulateTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           TextField(
//             controller: _inputController,
//             focusNode: _focusNode,
//             decoration: InputDecoration(
//               labelText: 'Input',
//               labelStyle: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//               focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blue, width: 2),
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Queue Visualization:',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 250),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: _visualizationBorderColor, width: 2),
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.white,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: queue.isEmpty
//                         ? const Text(
//                             'No items in the queue',
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           )
//                         : AnimatedList(
//                             key: _listKey,
//                             controller: _scrollController, // Attach scroll controller
//                             initialItemCount: queue.length,
//                             itemBuilder: (context, index, animation) {
//                               return _buildItem(queue[index], animation);
//                             },
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: enqueue,
//                 icon: const Icon(Icons.add, color: Colors.white), // Icon color white
//                 label: const Text('Enqueue', style: TextStyle(color: Colors.white)), // Text color white
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // Blue background for Enqueue button
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               ),
//               ElevatedButton.icon(
//                 onPressed: dequeue,
//                 icon: const Icon(Icons.remove, color: Colors.white), // Icon color white
//                 label: const Text('Dequeue', style: TextStyle(color: Colors.white)), // Text color white
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red, // Red background for Dequeue button
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               ),
//             ],
//           ),

//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: QueuesPage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
