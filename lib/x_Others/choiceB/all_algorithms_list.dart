import 'package:flutter/material.dart';
import 'package:flutterapp/x_Others/choiceB/radix_Learn.dart';

// Ensure this is at the top if RadixSortPage is in the same file

void main() {
  runApp(const CL2HOME());
}

// Define the algorithm categories
enum AlgorithmCategory { sorting, graph, tree, dataStructure, other }

// Algorithm data class with category
class Algorithm {
  final String name;
  final AlgorithmCategory category;

  Algorithm(this.name, this.category);
}

class CL2HOME extends StatefulWidget {
  const CL2HOME({super.key});

  @override
  State<CL2HOME> createState() => _CL2HOMEState();
}

class _CL2HOMEState extends State<CL2HOME> {
  // List of all algorithms and data structures
  final List<Algorithm> algorithms = [
    Algorithm("Radix Sort", AlgorithmCategory.sorting),
    Algorithm("Bubble Sort", AlgorithmCategory.sorting),
    Algorithm("Merge Sort", AlgorithmCategory.sorting),
    Algorithm("Insertion Sort", AlgorithmCategory.sorting),
    Algorithm("Dijkstra's Algorithm", AlgorithmCategory.graph),
    Algorithm("Bellman-Ford Algorithm", AlgorithmCategory.graph),
    Algorithm("Binary Search Tree", AlgorithmCategory.tree),
    Algorithm("AVL Tree", AlgorithmCategory.tree),
    Algorithm("Stack", AlgorithmCategory.dataStructure),
    Algorithm("Queue", AlgorithmCategory.dataStructure),
    // Add more items and categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 65, 65, 71),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 111, 2),
          title: const Text(
            "Let's Learn Algorithm",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: ListView(
          children: AlgorithmCategory.values
              .map((category) => _buildCategorySection(category))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildCategorySection(AlgorithmCategory category) {
    List<Algorithm> categoryAlgorithms =
        algorithms.where((a) => a.category == category).toList();
    String categoryName = category.toString().split('.').last;
    categoryName =
        '${categoryName[0].toUpperCase()}${categoryName.substring(1)}';

    return ExpansionTile(
      title: Text('$categoryName Algorithms'),
      initiallyExpanded: category == AlgorithmCategory.sorting,
      children: categoryAlgorithms
          .map((algo) => ListTile(
                title: Text(algo.name),
                onTap: () {
                  if (algo.name == "Radix Sort") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RadixSortScreen()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Want to continue?'),
                        content: Text('${algo.name} has been selected.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Here you might navigate to a generic detail page for other algorithms
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 65, 65, 71)),
                              foregroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: const Text('Continue'),
                          )
                        ],
                      ),
                    );
                  }
                },
              ))
          .toList(),
    );
  }
}
