import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AL-GO!'),),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SAS(),
          ),
          Expanded(
            child: LLS(),
          ),
        ],
      ),
    );
  }
}



class SAS extends StatefulWidget {
  const SAS({super.key});

  @override
  State<SAS> createState() => _SASState();
}

class _SASState extends State<SAS> {
  String text = "Let's embark on a simulation of sorting algorithms, where we can dynamically select from insertion, radix, and merge sort. The goal is to vividly visualize the step-by-step process of each sorting algorithm in action.";

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
        Column(children: <Widget>[
          Text('Sorting Algorithm Simulator' , style: 
            TextStyle(fontSize: 20,), textAlign: TextAlign.center,),

          Container(
            width: 300,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent),
            child: Text(text,style: TextStyle(fontSize: 14,),
            
            ),
            
          ),

          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 65, 65, 71)),
              foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
            ),
            
            onPressed: () {},
            child: Container(
              child: Text('SELECT', style: TextStyle(fontSize: 15), ), 
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              ),
            
            // Text('START', style: TextStyle(fontSize: 30),), 
            
          ),
          
        ],)
  
    );
  }
}






class LLS extends StatefulWidget {
  const LLS({super.key});

  @override
  State<LLS> createState() => _LLSState();
}

class _LLSState extends State<LLS> {
  String text = "Let's embark on a simulation of sorting algorithms, where we can dynamically select from insertion, radix, and merge sort. The goal is to vividly visualize the step-by-step process of each sorting algorithm in action.";

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
        Column(children: <Widget>[
         

          Text("Let's Learn Sorting Algorithm" , style: 
            TextStyle(fontSize: 20,),textAlign: TextAlign.center,),

          Container(
            width: 300,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent),
            child: Text(text,style: TextStyle(fontSize: 14),
            
            ),
            
          ),

          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 65, 65, 71)),
              foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
            ),
            
            onPressed: () {},
            child: Container(
              child: Text('SELECT', style: TextStyle(fontSize: 15), ), 
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              ),
            
            // Text('START', style: TextStyle(fontSize: 30),), 
            
          ),
        ],)

    );
  }
}




