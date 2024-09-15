import 'dart:async';
import 'package:flutter/material.dart';

class TreeNode {
  final int value;
  TreeNode? left;
  TreeNode? right;
  int index; // Unique index for each node

  TreeNode(this.value, this.index);
}

class DepthFirstPage extends StatefulWidget {
  const DepthFirstPage({Key? key}) : super(key: key);

  @override
  _DepthFirstPageState createState() => _DepthFirstPageState();
}

class _DepthFirstPageState extends State<DepthFirstPage> with SingleTickerProviderStateMixin {
  TreeNode? _root;
  String input = '';
  List<int> dfsTraversal = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, int>> animatedTraversal = []; // List of maps containing both index and value
  List<int> highlightedNodes = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust animation duration as needed
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void buildTree() {
    _controller.reset();
    _controller.forward();
    setState(() {
      _root = _buildBinaryTreeFromInput(input);
      if (_root == null) {
        // Display error message when the tree is not valid
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Binary Tree'),
            content: Text('The input does not form a valid binary search tree.'),
          ),
        );
      }
    });
  }

  void dfsTraversalFunction() {
    if (_root == null) return;

    dfsTraversal = [];
    animatedTraversal = []; // Clear the list before adding new traversal data

    // Perform Depth First Search traversal
    _dfsTraversalRecursive(_root!);

    // Animate the traversal values
    animateTraversal();
  }

  void _dfsTraversalRecursive(TreeNode? node) {
    if (node == null) return;

    dfsTraversal.add(node.index); // Store the index of the node
    animatedTraversal.add({'index': node.index, 'value': node.value}); // Store both index and value

    if (node.left != null) {
      _dfsTraversalRecursive(node.left!); // Recursively traverse left subtree
    }
    if (node.right != null) {
      _dfsTraversalRecursive(node.right!); // Recursively traverse right subtree
    }
  }

  Future<void> animateTraversal() async {
    highlightedNodes.clear(); // Clear highlighted nodes
    for (int i = 0; i < dfsTraversal.length; i++) {
      setState(() {
        highlightedNodes.add(dfsTraversal[i]); // Highlight the current node by index
      });
      await Future.delayed(Duration(milliseconds: 1000)); // Adjust delay as needed
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          highlightedNodes.remove(dfsTraversal[i]); // Remove highlight after delay
        });
      });
    }
    // Highlight the last node after traversal
    setState(() {
      highlightedNodes.add(dfsTraversal.last);
    });
  }

  TreeNode? _buildBinaryTreeFromInput(String input) {
    if (input.isEmpty) return null;

    List<String> nodeValues = input.split(',').map((e) => e.trim()).toList();
    TreeNode? root;

    // Create the root node
    if (nodeValues.isNotEmpty) {
      root = TreeNode(int.parse(nodeValues.removeAt(0)), 1); // Root index is 1
    } else {
      // If the input is empty after trimming, return null
      return null;
    }

    // Process remaining values as child nodes
    int index = 2; // Start indexing from 2
    for (String valueStr in nodeValues) {
      int value = int.tryParse(valueStr) ?? 0; // Handle null or non-integer values
      insertNode(root, value, index++);
    }

    return root;
  }

  // Function to recursively insert a node into the binary search tree
  void insertNode(TreeNode node, int value, int index) {
    if (value < node.value) {
      if (node.left == null) {
        // Add as left child if no left child exists
        node.left = TreeNode(value, index);
      } else {
        // If there's already a left child, recursively insert into the left subtree
        insertNode(node.left!, value, index);
      }
    } else {
      if (node.right == null) {
        // Add as right child if no right child exists
        node.right = TreeNode(value, index);
      } else {
        // If there's already a right child, recursively insert into the right subtree
        insertNode(node.right!, value, index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Depth First Search'),
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
                    onChanged: (value) {
                      setState(() {
                        input = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter comma-separated numbers for the tree',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: buildTree,
                  child: Text('Build Tree'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Binary Tree Visualization', // Added text here
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16), // Added space here
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _root != null
                    ? AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _animation.value,
                            child: CustomPaint(
                              size: Size(300, 300), // Adjust size as needed
                              painter: TreePainter(_root!, highlightedNodes: highlightedNodes),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('No tree built yet'),
                      ),
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Traversal Values',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: animatedTraversal.map((map) { // Use the list of maps containing both index and value
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            map['value'].toString(), // Display the value from the map
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: highlightedNodes.contains(map['index']) ? Colors.orange : Colors.black, // Highlight by index
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: dfsTraversalFunction,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50), // Adjust width and height as needed
                  ),
                  child: Text('Run DFS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  final TreeNode _root;
  final List<int> highlightedNodes;
  static const double nodeSize = 30.0;
  static const double spacing = 30.0;
  static const double levelSpacing = 60.0;

  TreePainter(this._root, {required this.highlightedNodes});

  @override
  void paint(Canvas canvas, Size size) {
    _paintNode(canvas, _root, size.width / 2, 0, size.width);
  }

  void _paintNode(Canvas canvas, TreeNode node, double x, double y, double width) {
    // Draw node
    if (highlightedNodes.contains(node.index)) { // Use node index
      canvas.drawCircle(Offset(x, y), nodeSize / 2, Paint()..color = Colors.orange); // Highlighted color
    } else {
      canvas.drawCircle(Offset(x, y), nodeSize / 2, Paint()..color = Colors.lightGreen);
    }
    canvas.drawCircle(Offset(x, y), nodeSize / 2, Paint()..style = PaintingStyle.stroke ..color = Colors.black);
    TextSpan span = TextSpan(style: TextStyle(color: Colors.black), text: node.value.toString());
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));

    // Draw edges
    if (node.left != null) {
      double childX = x - width / 4;
      double childY = y + levelSpacing;
      canvas.drawLine(Offset(x, y + nodeSize / 2), Offset(childX, childY - nodeSize / 2), Paint()..color = Colors.black);
      _paintNode(canvas, node.left!, childX, childY, width / 2);
    }
    if (node.right != null) {
      double childX = x + width / 4;
      double childY = y + levelSpacing;
      canvas.drawLine(Offset(x, y + nodeSize / 2), Offset(childX, childY - nodeSize / 2), Paint()..color = Colors.black);
      _paintNode(canvas, node.right!, childX, childY, width / 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    home: DepthFirstPage(),
  ));
}
