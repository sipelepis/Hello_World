import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DepthFirstPage()));
}

class DepthFirstPage extends StatefulWidget {
  const DepthFirstPage({super.key});

  @override
  _DepthFirstPageState createState() => _DepthFirstPageState();
}

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  int index;
  bool isMoving = false;
  bool isCorrectPosition = true;

  TreeNode(this.value, this.index);
}

class _DepthFirstPageState extends State<DepthFirstPage>
    with SingleTickerProviderStateMixin {
  TreeNode? _root;
  final Map<int, TextEditingController> _controllers = {};
  late TabController _tabController;
  bool _isConverted = false;
  bool _isChecked = false;
  List<int> _userNodeValues = [];
  final List<int> _dfsTraversal = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeRootNode();
  }

  void _initializeRootNode() {
    _userNodeValues = [10];
    _root = TreeNode(_userNodeValues[0], 0);
    _controllers[_root!.index] =
        TextEditingController(text: _root!.value.toString());
  }

  void addNode(TreeNode parentNode, String position, int value) {
    int newIndex = (position == "left")
        ? parentNode.index * 2 + 1
        : parentNode.index * 2 + 2;
    TreeNode newNode = TreeNode(value, newIndex);
    _controllers[newIndex] = TextEditingController(text: value.toString());

    setState(() {
      if (position == "left" && parentNode.left == null) {
        parentNode.left = newNode;
      } else if (position == "right" && parentNode.right == null) {
        parentNode.right = newNode;
      }
      _userNodeValues.add(value);
    });
  }

  void deleteNode(TreeNode parentNode, String position) {
    setState(() {
      if (position == "left" && parentNode.left != null) {
        _removeSubtree(parentNode.left!);
        parentNode.left = null;
      } else if (position == "right" && parentNode.right != null) {
        _removeSubtree(parentNode.right!);
        parentNode.right = null;
      }
    });
  }

  void _removeSubtree(TreeNode node) {
    if (node.left != null) {
      _removeSubtree(node.left!);
    }
    if (node.right != null) {
      _removeSubtree(node.right!);
    }
    _userNodeValues.remove(node.value);
    _controllers.remove(node.index);
  }

  void clearTree() {
    setState(() {
      _controllers.clear();
      _initializeRootNode();
      _isConverted = false;
      _isChecked = false;
      _userNodeValues = [_root!.value];
      _dfsTraversal.clear();
    });
  }

  void convertTree() {
    setState(() {
      _isConverted = true;
    });
  }

  void checkTree() {
    if (_root == null) return;

    _resetCorrectness(_root);
    setState(() {
      _isChecked = true;
      _validateBST(_root, null, null);
    });
  }

  void _resetCorrectness(TreeNode? node) {
    if (node == null) return;
    node.isCorrectPosition = true;
    _resetCorrectness(node.left);
    _resetCorrectness(node.right);
  }

  bool _validateBST(TreeNode? node, int? min, int? max) {
    if (node == null) return true;

    bool isCorrect = true;
    if ((min != null && node.value <= min) ||
        (max != null && node.value >= max)) {
      node.isCorrectPosition = false;
      isCorrect = false;
    }

    return _validateBST(node.left, min, node.value) &
        _validateBST(node.right, node.value, max) &
        isCorrect;
  }

  void sortTree() async {
    if (_userNodeValues.isEmpty) return;

    setState(() {
      _root = TreeNode(_userNodeValues[0], 0);
      _controllers.clear();
      _controllers[_root!.index] =
          TextEditingController(text: _root!.value.toString());
      _root!.left = null;
      _root!.right = null;
    });

    for (int i = 1; i < _userNodeValues.length; i++) {
      setState(() {
        _root!.isMoving = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _insertIntoBST(_root!, _userNodeValues[i]);
        _root!.isMoving = false;
      });
    }
  }

  void _insertIntoBST(TreeNode node, int value) {
    if (value < node.value) {
      if (node.left == null) {
        setState(() {
          node.left = TreeNode(value, node.index * 2 + 1)..isMoving = true;
          _controllers[node.left!.index] =
              TextEditingController(text: value.toString());
        });
      } else {
        _insertIntoBST(node.left!, value);
      }
    } else {
      if (node.right == null) {
        setState(() {
          node.right = TreeNode(value, node.index * 2 + 2)..isMoving = true;
          _controllers[node.right!.index] =
              TextEditingController(text: value.toString());
        });
      } else {
        _insertIntoBST(node.right!, value);
      }
    }
  }

  void depthFirstTraversal() {
    _dfsTraversal.clear();
    _dfs(_root);
    setState(() {});
  }

  void _dfs(TreeNode? node) {
    if (node == null) return;
    _dfsTraversal.add(node.value); // Pre-order traversal
    _dfs(node.left);
    _dfs(node.right);
  }

  String _getNodeListAsString() {
    return _userNodeValues.join(', ');
  }

  Widget buildTree(TreeNode? node) {
    if (node == null) return const SizedBox();

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isConverted) ...[
              IconButton(
                icon: Icon(
                  node.left == null
                      ? Icons.add_circle_outline
                      : Icons.remove_circle_outline,
                  color: node.left == null ? Colors.green : Colors.red,
                ),
                onPressed: () => node.left == null
                    ? addNode(node, 'left', Random().nextInt(100))
                    : deleteNode(node, 'left'),
              ),
            ],
            SizedBox(
              width: 60,
              child: TextField(
                controller: _controllers[node.index],
                onChanged: (value) => updateNodeValue(node, value),
                enabled: !_isConverted,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (!_isConverted) ...[
              IconButton(
                icon: Icon(
                  node.right == null
                      ? Icons.add_circle_outline
                      : Icons.remove_circle_outline,
                  color: node.right == null ? Colors.green : Colors.red,
                ),
                onPressed: () => node.right == null
                    ? addNode(node, 'right', Random().nextInt(100))
                    : deleteNode(node, 'right'),
              ),
            ],
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: buildTree(node.left),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: buildTree(node.right),
            ),
          ],
        ),
      ],
    );
  }

  void updateNodeValue(TreeNode node, String newValue) {
    int? value = int.tryParse(newValue);
    if (value != null) {
      setState(() {
        int oldValueIndex = _userNodeValues.indexOf(node.value);
        if (oldValueIndex != -1) {
          _userNodeValues[oldValueIndex] = value;
        }
        node.value = value;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid integer value.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Depth First Search',
            style: TextStyle(color: Colors.black)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: _buildTabBar(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBinarySearchTab(),
                _buildInstructionsTab(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Node List: ${_getNodeListAsString()}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'DFS Traversal: ${_dfsTraversal.join(', ')}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
            ],
          ),
          tabs: const [
            Tab(child: Text('Simulate', style: TextStyle(color: Colors.blue))),
            Tab(
                child:
                    Text('Instructions', style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _buildBinarySearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _isConverted ? null : convertTree,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.blue,
                ),
                child: const Icon(Icons.transform, color: Colors.white),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: (_isConverted && !_isChecked) ? checkTree : null,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.green,
                ),
                child:
                    const Icon(Icons.check_circle_outline, color: Colors.white),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: (_isConverted && _isChecked) ? sortTree : null,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.orange,
                ),
                child: const Icon(Icons.sort, color: Colors.white),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: depthFirstTraversal,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.purple,
                ),
                child: const Icon(Icons.arrow_downward, color: Colors.white),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: clearTree,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.red,
                ),
                child: const Icon(Icons.clear, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Depth First Search Visualization',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _isConverted
                ? CustomPaint(
                    painter: TreePainter(_root, _isChecked),
                    child: Container(),
                  )
                : Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: _root != null
                              ? buildTree(_root)
                              : const Text('No tree built yet.'),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsTab() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How to Use:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '1. Use the text boxes to edit node values directly.\n'
            '2. Click the + icons to add nodes.\n'
            '3. Click the - icons to delete nodes.\n'
            '4. Use the "Convert" button to lock in values and create the tree.\n'
            '5. Use "Check" to highlight incorrect nodes based on BST rules.\n'
            '6. Use "Sort" to organize the tree in order after checking.\n'
            '7. Use "DFS Traversal" to perform a depth-first traversal.\n'
            '8. Use "Clear" to reset and start again.\n',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  final TreeNode? root;
  final bool isChecked;

  TreePainter(this.root, this.isChecked);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    const double radius = 20.0;
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    _drawNode(canvas, root, size.width / 2, 50, size.width / 4, radius, paint,
        linePaint);
  }

  void _drawNode(Canvas canvas, TreeNode? node, double x, double y,
      double xOffset, double radius, Paint paint, Paint linePaint) {
    if (node == null) return;

    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - xOffset, y + 80), linePaint);
      _drawNode(canvas, node.left, x - xOffset, y + 80, xOffset / 2, radius,
          paint, linePaint);
    }

    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + xOffset, y + 80), linePaint);
      _drawNode(canvas, node.right, x + xOffset, y + 80, xOffset / 2, radius,
          paint, linePaint);
    }

    paint.color = node.isMoving
        ? Colors.blue
        : isChecked && node.isCorrectPosition
            ? Colors.lightGreen
            : isChecked && !node.isCorrectPosition
                ? Colors.red
                : Colors.blue;

    canvas.drawCircle(Offset(x, y), radius, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
