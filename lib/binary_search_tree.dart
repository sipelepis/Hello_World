import 'package:flutter/material.dart';

class TreeNode {
  final int value;
  TreeNode? left;
  TreeNode? right;
  int index; // Unique index for each node

  TreeNode(this.value, this.index);
}

class BinarySearchPage extends StatefulWidget {
  const BinarySearchPage({Key? key}) : super(key: key);

  @override
  _BinarySearchPageState createState() => _BinarySearchPageState();
}

class _BinarySearchPageState extends State<BinarySearchPage> {
  TreeNode? _root;
  TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Search Algorithm'),
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
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter a number',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: insertNode,
                  child: Text('Insert'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: clearTree,
                  child: Text('Clear Tree'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Binary Tree Visualization', // Added text here
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16), // Added space here
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: 25), // Added margin below the visualization
                  child: _root != null
                      ? CustomPaint(
                          size: Size(300, 300), // Adjust size as needed
                          painter: TreePainter(_root!),
                        )
                      : Center(
                          child: Text('No tree built yet'),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertNode() {
    final input = _numberController.text.trim();
    if (input.isNotEmpty) {
      final number = int.tryParse(input);
      if (number != null) {
        if (_root == null) {
          _root = TreeNode(number, 1);
        } else {
          _insertNodeHelper(_root!, number);
        }
        setState(() {
          _numberController.clear(); // Clear the text field after insertion
        });
      }
    }
  }

  void _insertNodeHelper(TreeNode node, int value) {
    if (value < node.value) {
      if (node.left == null) {
        // Add as left child if no left child exists
        node.left = TreeNode(value, node.index * 2);
      } else {
        // If there's already a left child, recursively insert into the left subtree
        _insertNodeHelper(node.left!, value);
      }
    } else {
      if (node.right == null) {
        // Add as right child if no right child exists
        node.right = TreeNode(value, node.index * 2 + 1);
      } else {
        // If there's already a right child, recursively insert into the right subtree
        _insertNodeHelper(node.right!, value);
      }
    }
  }

  void clearTree() {
    setState(() {
      _root = null;
    });
  }
}

class TreePainter extends CustomPainter {
  final TreeNode _root;
  static const double nodeSize = 30.0;
  static const double levelSpacing = 60.0;

  TreePainter(this._root);

  @override
  void paint(Canvas canvas, Size size) {
    _paintNode(canvas, _root, size.width / 2, 0, size.width);
  }

  void _paintNode(Canvas canvas, TreeNode node, double x, double y, double width) {
    // Draw node
    canvas.drawCircle(Offset(x, y), nodeSize / 2, Paint()..color = Colors.lightGreen);
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
    home: BinarySearchPage(),
  ));
}
