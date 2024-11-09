import 'package:flutter/material.dart';

class StacksPage extends StatefulWidget {
  const StacksPage({super.key});

  @override
  State<StacksPage> createState() => _StacksPageState();
}

class _StacksPageState extends State<StacksPage>
    with SingleTickerProviderStateMixin {
  List<int> stack = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  Color _visualizationBorderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void push() {
    String inputText = _inputController.text.trim();
    if (inputText.isEmpty) {
      setState(() => _visualizationBorderColor = Colors.black);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input field is empty!')),
      );
      return;
    }

    int? number = int.tryParse(inputText);
    if (number == null) {
      setState(() => _visualizationBorderColor = Colors.black);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid input! Please enter a valid number.')),
      );
      return;
    }

    setState(() {
      stack.add(number);
      _listKey.currentState?.insertItem(
        stack.length - 1,
        duration: const Duration(milliseconds: 500),
      );
      _visualizationBorderColor = Colors.blueAccent;
    });

    _inputController.clear();

    // Add a slight delay to allow insertion animation to complete before scrolling.
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void pop() {
    if (stack.isEmpty) {
      setState(() => _visualizationBorderColor = Colors.black);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing to pop!')),
      );
      return;
    }

    int poppedNumber = stack.removeLast();
    _listKey.currentState?.removeItem(
      stack.length,
      (context, animation) =>
          _buildItem(poppedNumber, animation, popping: true),
      duration: const Duration(milliseconds: 500),
    );

    setState(() => _visualizationBorderColor = Colors.redAccent);

    // Scroll to the latest remaining item.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildItem(int number, Animation<double> animation,
      {bool popping = false}) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              150.0, 8.0, 0.0, 8.0), // 150px left padding
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: popping ? Colors.red : Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              number.toString(),
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Stacks',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                tabs: const [
                  Tab(
                    child: Text(
                      'Simulate',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'I\'ll Take a Shot',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSimulateTab(),
          const Center(
            child: Text(
              'This feature is under construction.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimulateTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              labelText: 'Input',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Stack Visualization:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: _visualizationBorderColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedList(
                    key: _listKey,
                    controller: _scrollController,
                    initialItemCount: stack.length,
                    reverse: true,
                    itemBuilder: (context, index, animation) {
                      return _buildItem(stack[index], animation);
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: push,
                icon: const Icon(Icons.add, color: Colors.white),
                label:
                    const Text('Push', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: pop,
                icon: const Icon(Icons.remove, color: Colors.white),
                label: const Text('Pop', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
