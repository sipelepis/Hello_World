import 'package:flutter/material.dart';

// Define the algorithm categories
enum AlgorithmCategory {
  sorting,
  graph,
  tree,
  dataStructure,
  other
}

// Algorithm data class with category
class Algorithm {
  final String name;
  final AlgorithmCategory category;

  Algorithm(this.name, this.category);
}

class CL2HOME extends StatefulWidget {
  const CL2HOME({Key? key}) : super(key: key);

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
      primaryColor: const Color.fromARGB(255, 65, 65, 71), // Gray color for primary theme
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 111, 2), // Gray background color for AppBar
        title: const Text(
          "Let's Learn Algorithm",
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set icon color to white
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        children: AlgorithmCategory.values.map((category) => _buildCategorySection(category)).toList(),
      ),
    ),
  );
}


  // Builds a section for each category with its respective algorithms
  Widget _buildCategorySection(AlgorithmCategory category) {
    List<Algorithm> categoryAlgorithms = algorithms.where((a) => a.category == category).toList();
    String categoryName = category.toString().split('.').last;
    categoryName = '${categoryName[0].toUpperCase()}${categoryName.substring(1)}';

    return ExpansionTile(
      title: Text('$categoryName Algorithms'),
      initiallyExpanded: category == AlgorithmCategory.sorting, // Automatically expand the sorting category
      children: categoryAlgorithms.map((algo) => ListTile(
        title: Text(algo.name),
        onTap: () {
          // Implement navigation or further action here
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Want to continue?'),
              content: Text('${algo.name} has been selected.'),
              actions: [
                ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 65, 65, 71)), // Button color as gray
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255)), // Text color as white
                  ),
                )
              ],
            ),
          );
        },
      )).toList(),
    );
  }
}

void main() {
  runApp(const CL2HOME());
}
