import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';


class L2HOME extends StatefulWidget {
  const L2HOME({super.key});

  @override
  State<L2HOME> createState() => _L2HOMEState();
}

class _L2HOMEState extends State<L2HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('123'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(),
            NormalWidget(),
            clickbtn(),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////// BODY

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "LET'S LEARN",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    );
  }
}

class NormalWidget extends StatelessWidget {
  const NormalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment
          .center, // Align however you like (i.e .centerRight, centerLeft)
      child: Text(
        "LET'S LEARN SORING ALGORITHM",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class clickbtn extends StatefulWidget {
  const clickbtn({super.key});

  @override
  State<clickbtn> createState() => _clickbtnState();
}

class _clickbtnState extends State<clickbtn> {
  void click() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage())
        );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 65, 65, 71)),
        foregroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255)),
      ),
      onPressed: this.click,
      child: Container(
        child: Text(
          'CONTINUE',
          style: TextStyle(fontSize: 30),
        ),
        width: 190,
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
      ),
      // Text('START', style: TextStyle(fontSize: 30),),
    );
  }
}