import 'package:flutter/material.dart';

class QueuesPage extends StatefulWidget {
  const QueuesPage({Key? key}) : super(key: key);

  @override
  State<QueuesPage> createState() => _QueuesPageState();
}

class _QueuesPageState extends State<QueuesPage> {
  List<int> queue = [];
  String input = '';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void enqueue(int number) {
    int index = queue.length;
    queue.add(number);
    _listKey.currentState?.insertItem(index, duration: Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('The $number has been enqueued.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void dequeue() {
    if (queue.isNotEmpty) {
      int dequeuedNumber = queue.removeAt(0);
      _listKey.currentState?.removeItem(
        0,
        (context, animation) => _buildItem(dequeuedNumber, animation, dequeuing: true),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The $dequeuedNumber has been dequeued.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void dequeueNumber(int number) {
    if (queue.contains(number)) {
      queue.remove(number);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The $number has been dequeued.'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The number $number does not exist in the queue.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Operations'),
      ),
      body: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(bottom: 30), // Adjust the bottom padding as needed
            child: Text(
              'Queue Visualization:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 100, // Add a fixed height here or use MediaQuery to get the screen height and adjust accordingly
            child: AnimatedList(
              key: _listKey,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index, animation) {
                int number = queue[index];
                return _buildItem(number, animation);
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Enqueue'),
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
                            enqueue(number);
                            Navigator.pop(context);
                          },
                          child: Text('Enqueue'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Enqueue'),
              ),
              ElevatedButton.icon(
                onPressed: dequeue,
                icon: Icon(Icons.remove),
                label: Text('Dequeue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int number, Animation<double> animation, {bool dequeuing = false}) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(dequeuing ? 0 : 1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: dequeuing ? Colors.red : Colors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number.toString(),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QueuesPage(),
  ));
}
