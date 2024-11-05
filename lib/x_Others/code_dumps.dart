// OLd insertion sort
// import 'package:flutter/material.dart';

// class InsertionSortPage extends StatefulWidget {
//   const InsertionSortPage({Key? key}) : super(key: key);

//   @override
//   State<InsertionSortPage> createState() => _InsertionSortPageState();
// }

// class _InsertionSortPageState extends State<InsertionSortPage> {
//   List<int> stack = [];
//   TextEditingController inputController = TextEditingController();
//   int currentIndex = -1;
//   int movingIndex = -1;
//   bool isSorting = false;

//   Future<void> sort() async {
//     setState(() {
//       isSorting = true;
//     });

//     for (int i = 1; i < stack.length; i++) {
//       int key = stack[i];
//       int j = i - 1;

//       setState(() {
//         currentIndex = i; // Highlight the current element in red
//       });
//       await Future.delayed(Duration(milliseconds: 2800)); // Early highlighting before moving

//       while (j >= 0 && stack[j] > key) {
//         setState(() {
//           stack[j + 1] = stack[j];
//           stack[j] = key; // Swap values for animation
//           movingIndex = j; // Highlight the moving index in red
//         });
//         await Future.delayed(Duration(milliseconds: 600)); // Adjust delay for slower animation
//         setState(() {
//           movingIndex = -1; // Reset the moving index
//           currentIndex = j; // Highlight the current element in red again
//         });
//         await Future.delayed(Duration(milliseconds: 1000)); // Adjust delay for slower animation
//         j--;
//       }

//       setState(() {
//         currentIndex = -1; // Reset the current element index
//       });
//       await Future.delayed(Duration(milliseconds: 1000)); // Additional delay for visualization
//     }

//     setState(() {
//       // Set all numbers to green once sorting is done
//       isSorting = false;
//       currentIndex = -1;
//       movingIndex = -1;
//     });
//   }

//   void insertNumbers() {
//     List<String> inputNumbers = inputController.text.split(',');
//     for (String numStr in inputNumbers) {
//       int number = int.tryParse(numStr.trim()) ?? 0;
//       if (number != 0) {
//         setState(() {
//           stack.add(number);
//         });
//       }
//     }
//     inputController.clear(); // Clear the input text field
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Insertion Sort Visualization'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: inputController,
//                     onChanged: (value) {
//                       setState(() {});
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Enter numbers (comma-separated)',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: insertNumbers,
//                   child: Text('Insert'),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       stack.clear();
//                     });
//                     inputController.clear(); // Clear the input text field
//                   },
//                   child: Text('Clear'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: sort,
//               child: Text('Sort'),
//             ),
//             SizedBox(height: 16),
//             Text('Insertion Sort Visualization:'),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     for (int i = 0; i < stack.length; i++)
//                       TweenAnimationBuilder(
//                         duration: Duration(milliseconds: 500), // Adjust duration for slower animation
//                         tween: Tween<double>(
//                           begin: i.toDouble(),
//                           end: stack.indexOf(stack[i]).toDouble(),
//                         ),
//                         builder: (context, double value, child) {
//                           return Transform.translate(
//                             offset: Offset(value * 30, 0), // Adjust the value for spacing
//                             child: AnimatedContainer(
//                               duration: Duration(milliseconds: 500), // Adjust duration for slower animation
//                               height: 50,
//                               width: 50,
//                               margin: const EdgeInsets.symmetric(horizontal: 5),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: (isSorting && i == currentIndex)
//                                     ? Colors.red // Highlight the current element in red
//                                     : (isSorting && i == movingIndex)
//                                         ? Colors.blue // Highlight the moving element in blue
//                                         : Colors.lightBlue, // Numbers being sorted
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 stack[i].toString(),
//                                 style: TextStyle(fontSize: 20, color: Colors.white),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: InsertionSortPage(),
//   ));
// }




// import 'dart:math';
// import 'package:flutter/material.dart';

// class BinarySearchPage extends StatefulWidget {
//   const BinarySearchPage({Key? key}) : super(key: key);

//   @override
//   _BinarySearchPageState createState() => _BinarySearchPageState();
// }

// class TreeNode {
//   int value;
//   TreeNode? left;
//   TreeNode? right;
//   int index;

//   TreeNode(this.value, this.index);
// }

// class _BinarySearchPageState extends State<BinarySearchPage>
//     with SingleTickerProviderStateMixin {
//   TreeNode? _root;
//   final Map<int, TextEditingController> _controllers = {};
//   late TabController _tabController;
//   bool _isConverted = false;
//   bool _isChecked = false;
//   List<int> sortedValues = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _initializeRootNode();
//   }

//   void _initializeRootNode() {
//     _root = TreeNode(10, 0);
//     _controllers[_root!.index] =
//         TextEditingController(text: _root!.value.toString());
//   }

//   @override
//   void dispose() {
//     _controllers.values.forEach((controller) => controller.dispose());
//     _tabController.dispose();
//     super.dispose();
//   }

//   void addNode(TreeNode parentNode, String position) {
//     int newValue = Random().nextInt(100);
//     int newIndex = (position == "left")
//         ? parentNode.index * 2 + 1
//         : parentNode.index * 2 + 2;
//     TreeNode newNode = TreeNode(newValue, newIndex);
//     _controllers[newIndex] = TextEditingController(text: newValue.toString());

//     setState(() {
//       if (position == "left" && parentNode.left == null) {
//         parentNode.left = newNode;
//       } else if (position == "right" && parentNode.right == null) {
//         parentNode.right = newNode;
//       }
//     });
//   }

//   void deleteNode(TreeNode parentNode, String position) {
//     setState(() {
//       if (position == "left" && parentNode.left != null) {
//         _controllers.remove(parentNode.left?.index);
//         parentNode.left = null;
//       } else if (position == "right" && parentNode.right != null) {
//         _controllers.remove(parentNode.right?.index);
//         parentNode.right = null;
//       }
//     });
//   }

//   void clearTree() {
//     setState(() {
//       _controllers.clear();
//       _initializeRootNode();
//       _isConverted = false;
//       _isChecked = false;
//       sortedValues.clear();
//     });
//   }

//   void convertTree() {
//     setState(() {
//       _isConverted = true;
//     });
//   }

//   void checkTree() {
//     if (_root == null) return;

//     setState(() {
//       _isChecked = true;
//     });
//   }

//   Future<void> sortTree() async {
//     if (_root == null) return;

//     List<int> values = [];
//     _inOrderTraversal(_root?.left, values);
//     _inOrderTraversal(_root?.right, values);

//     values.sort();

//     await _reassignValuesInOrder(_root?.left, values.iterator);
//     await _reassignValuesInOrder(_root?.right, values.iterator);
//   }

//   void updateNodeValue(TreeNode node, String newValue) {
//     int? value = int.tryParse(newValue);
//     if (value != null) {
//       setState(() {
//         node.value = value;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid integer value.')),
//       );
//     }
//   }

//   void _inOrderTraversal(TreeNode? node, List<int> list) {
//     if (node == null) return;
//     _inOrderTraversal(node.left, list);
//     list.add(node.value);
//     _inOrderTraversal(node.right, list);
//   }

//   Future<void> _reassignValuesInOrder(
//       TreeNode? node, Iterator<int> sortedValues) async {
//     if (node == null) return;

//     await _reassignValuesInOrder(node.left, sortedValues);

//     if (sortedValues.moveNext()) {
//       setState(() {
//         node.value = sortedValues.current;
//       });
//       await Future.delayed(const Duration(milliseconds: 500));
//     }

//     await _reassignValuesInOrder(node.right, sortedValues);
//   }

//   Widget buildTree(TreeNode? node) {
//     if (node == null) return const SizedBox();

//     return Column(
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!_isConverted) ...[
//               IconButton(
//                 icon: Icon(
//                   node.left == null
//                       ? Icons.add_circle_outline
//                       : Icons.remove_circle_outline,
//                   color: node.left == null ? Colors.green : Colors.red,
//                 ),
//                 onPressed: () => node.left == null
//                     ? addNode(node, 'left')
//                     : deleteNode(node, 'left'),
//               ),
//             ],
//             SizedBox(
//               width: 60,
//               child: TextField(
//                 controller: _controllers[node.index],
//                 onChanged: (value) => updateNodeValue(node, value),
//                 enabled: !_isConverted,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             if (!_isConverted) ...[
//               IconButton(
//                 icon: Icon(
//                   node.right == null
//                       ? Icons.add_circle_outline
//                       : Icons.remove_circle_outline,
//                   color: node.right == null ? Colors.green : Colors.red,
//                 ),
//                 onPressed: () => node.right == null
//                     ? addNode(node, 'right')
//                     : deleteNode(node, 'right'),
//               ),
//             ],
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: buildTree(node.left),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: buildTree(node.right),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Binary Search Tree',
//             style: TextStyle(color: Colors.black)),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60.0),
//           child: _buildTabBar(),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBinarySearchTab(),
//           _buildInstructionsTab(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: const [
//             BoxShadow(
//                 color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
//           ],
//         ),
//         child: TabBar(
//           controller: _tabController,
//           indicator: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: const [
//               BoxShadow(
//                   color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
//             ],
//           ),
//           tabs: const [
//             Tab(child: Text('Simulate', style: TextStyle(color: Colors.blue))),
//             Tab(
//                 child:
//                     Text('Instructions', style: TextStyle(color: Colors.grey))),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBinarySearchTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ElevatedButton(
//                 onPressed: _isConverted ? null : convertTree,
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(12),
//                   backgroundColor: Colors.blue,
//                 ),
//                 child: const Icon(Icons.transform, color: Colors.white),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: (_isConverted && !_isChecked) ? checkTree : null,
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(12),
//                   backgroundColor: Colors.green,
//                 ),
//                 child:
//                     const Icon(Icons.check_circle_outline, color: Colors.white),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: (_isConverted && _isChecked) ? sortTree : null,
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(12),
//                   backgroundColor: Colors.orange,
//                 ),
//                 child: const Icon(Icons.sort, color: Colors.white),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: clearTree,
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(12),
//                   backgroundColor: Colors.red,
//                 ),
//                 child: const Icon(Icons.clear, color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Center(
//             child: Text(
//               'Binary Search Tree Visualization',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: _isConverted
//                 ? CustomPaint(
//                     painter: TreePainter(_root, _isChecked),
//                     child: Container(),
//                   )
//                 : Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 4,
//                           offset: Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Center(
//                           child: _root != null
//                               ? buildTree(_root)
//                               : const Text('No tree built yet.'),
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructionsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             'How to Use:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             '1. Use the text boxes to edit node values directly.\n'
//             '2. Click the + icons to add left or right children.\n'
//             '3. Click the - icons to delete left or right children.\n'
//             '4. Use the "Convert" button to lock in values and create the tree.\n'
//             '5. Use "Check" to highlight incorrect nodes based on BST rules.\n'
//             '6. Use "Sort" to organize the tree in order after checking.\n'
//             '7. Use "Clear" to reset and start again.\n',
//             style: TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final TreeNode? root;
//   final bool isChecked;

//   TreePainter(this.root, this.isChecked);

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (root == null) return;

//     final double radius = 20.0;
//     final Paint paint = Paint()..style = PaintingStyle.fill;
//     final Paint linePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;

//     _drawNode(canvas, root, size.width / 2, 50, size.width / 4, radius, paint,
//         linePaint);
//   }

//   void _drawNode(Canvas canvas, TreeNode? node, double x, double y,
//       double xOffset, double radius, Paint paint, Paint linePaint) {
//     if (node == null) return;

//     if (node.left != null) {
//       canvas.drawLine(Offset(x, y), Offset(x - xOffset, y + 80), linePaint);
//       _drawNode(canvas, node.left, x - xOffset, y + 80, xOffset / 2, radius,
//           paint, linePaint);
//     }

//     if (node.right != null) {
//       canvas.drawLine(Offset(x, y), Offset(x + xOffset, y + 80), linePaint);
//       _drawNode(canvas, node.right, x + xOffset, y + 80, xOffset / 2, radius,
//           paint, linePaint);
//     }

//     if (isChecked) {
//       paint.color = isBSTCompliant(node, root) ? Colors.lightGreen : Colors.red;
//     } else {
//       paint.color = Colors.blue;
//     }

//     canvas.drawCircle(Offset(x, y), radius, paint);

//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: node.value.toString(),
//         style: const TextStyle(color: Colors.white, fontSize: 14),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(x - textPainter.width / 2, y - textPainter.height / 2),
//     );
//   }

//   bool isBSTCompliant(TreeNode? node, TreeNode? root) {
//     if (node == null) return true;

//     // Skip the root node as it is never wrong
//     if (node == root) return true;

//     // If node is a left child, it should be less than the root
//     if (node == root?.left && node.value >= root!.value) return false;

//     // If node is a right child, it should be greater than the root
//     if (node == root?.right && node.value <= root!.value) return false;

//     // Recursively check for left and right children
//     return isBSTCompliant(node.left, node) && isBSTCompliant(node.right, node);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// void main() {
//   runApp(const MaterialApp(home: BinarySearchPage()));
// }





// import 'dart:collection';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class BinarySearchPage extends StatefulWidget {
//   const BinarySearchPage({Key? key}) : super(key: key);

//   @override
//   _BinarySearchPageState createState() => _BinarySearchPageState();
// }

// class TreeNode {
//   int value;
//   TreeNode? left;
//   TreeNode? right;
//   int index;
//   Color color;

//   TreeNode(this.value, this.index,
//       {this.left, this.right, this.color = Colors.blue});
// }

// class _BinarySearchPageState extends State<BinarySearchPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   TreeNode? _root;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _root = TreeNode(10, 0);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   // Add a child node to a selected parent
//   void addNode(TreeNode parentNode, String position) {
//     int newValue = Random().nextInt(100);
//     int newIndex = (position == "left")
//         ? parentNode.index * 2 + 1
//         : parentNode.index * 2 + 2;
//     TreeNode newNode = TreeNode(newValue, newIndex);

//     setState(() {
//       if (position == "left" && parentNode.left == null) {
//         parentNode.left = newNode;
//       } else if (position == "right" && parentNode.right == null) {
//         parentNode.right = newNode;
//       }
//     });
//   }

//   // Edit a node's value
//   void editNodeValue(TreeNode node) {
//     TextEditingController controller =
//         TextEditingController(text: node.value.toString());
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Edit Node Value',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           content: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: 'Enter new value',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 int? newValue = int.tryParse(controller.text);
//                 if (newValue != null) {
//                   setState(() {
//                     node.value = newValue;
//                   });
//                 }
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Show options for adding a child node or editing a node
//   void showNodeOptions(TreeNode node) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.edit, color: Colors.blue),
//                 title: const Text('Edit Node Value'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   editNodeValue(node);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.arrow_left, color: Colors.green),
//                 title: const Text('Add Left Child'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   addNode(node, 'left');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.arrow_right, color: Colors.green),
//                 title: const Text('Add Right Child'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   addNode(node, 'right');
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void clearTree() {
//     setState(() {
//       _root = TreeNode(10, 0);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Binary Tree Visualization',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60.0),
//           child: _buildTabBar(),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBinarySearchTab(),
//           _buildInstructionsTab(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
//         ],
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: const [
//             BoxShadow(
//                 color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
//           ],
//         ),
//         tabs: const [
//           Tab(child: Text('Binary Tree', style: TextStyle(color: Colors.blue))),
//           Tab(
//               child:
//                   Text('Instructions', style: TextStyle(color: Colors.grey))),
//         ],
//       ),
//     );
//   }

//   Widget _buildBinarySearchTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: clearTree,
//                 child: const Text('Clear Tree'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.only(top: 25),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(2, 2),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: _root != null
//                     ? GestureDetector(
//                         onTap: () => showNodeOptions(_root!),
//                         child: CustomPaint(
//                           painter: TreePainter(_root!, showNodeOptions),
//                           child: Container(),
//                         ),
//                       )
//                     : const Text('No tree built yet.'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructionsTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             'How to Use:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             '1. Tap on a node to edit its value or add left/right children.\n'
//             '2. Tap "Clear Tree" to reset the tree to a single root node.\n',
//             style: TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final TreeNode root;
//   final Function(TreeNode) onNodeTap;
//   static const double nodeSize = 30.0;
//   static const double levelSpacing = 60.0;

//   TreePainter(this.root, this.onNodeTap);

//   @override
//   void paint(Canvas canvas, Size size) {
//     _drawNode(canvas, root, size.width / 2, 40, size.width / 4);
//   }

//   void _drawNode(
//       Canvas canvas, TreeNode node, double x, double y, double xOffset) {
//     final paint = Paint()..color = node.color;
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: node.value.toString(),
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     canvas.drawCircle(Offset(x, y), nodeSize / 2, paint);
//     textPainter.layout();
//     textPainter.paint(
//         canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));

//     if (node.left != null) {
//       double childX = x - xOffset;
//       double childY = y + levelSpacing;
//       _drawLine(canvas, x, y, childX, childY);
//       _drawNode(canvas, node.left!, childX, childY, xOffset / 2);
//     }

//     if (node.right != null) {
//       double childX = x + xOffset;
//       double childY = y + levelSpacing;
//       _drawLine(canvas, x, y, childX, childY);
//       _drawNode(canvas, node.right!, childX, childY, xOffset / 2);
//     }
//   }

//   void _drawLine(
//       Canvas canvas, double startX, double startY, double endX, double endY) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;
//     canvas.drawLine(Offset(startX, startY + nodeSize / 2),
//         Offset(endX, endY - nodeSize / 2), paint);
//   }

//   @override
//   bool shouldRepaint(covariant TreePainter oldDelegate) => true;
// }

// void main() {
//   runApp(const MaterialApp(
//     home: BinarySearchPage(),
//   ));
// }