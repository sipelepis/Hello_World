import 'package:flutter/material.dart';
import 'package:flutterapp/Home.dart';
import 'package:flutterapp/Choose_L2.dart';

class L2HOME extends StatefulWidget {
  const L2HOME({super.key});

  @override
  State<L2HOME> createState() => _L2HOMEState();
}

class _L2HOMEState extends State<L2HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AL-GO!'),),  
      body: 
          LayoutBuilder(
        builder: (context, constraints) {
          
          bool isPortrait = constraints.maxWidth < constraints.maxHeight;

          return isPortrait
              ? Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextWidget(),
                        NormalWidget(),
                      ],
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        clickbtnback(),
                        SizedBox(height: 36,),
                        clickbtn(),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextWidget(),
                        NormalWidget(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        clickbtn(),
                        SizedBox(width: 96,),
                        clickbtnback(),

                      ],
                    ),
                  ],
                );
        },
      ),
      
      
     
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       TextWidget(),
      //       NormalWidget(),
      //       clickbtn(),
      //     ],
      //   ),
      // ),
      
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
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    );
  }
}

class NormalWidget extends StatelessWidget {
  const NormalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment
          .center, // Align however you like (i.e .centerRight, centerLeft)
      child: Text(
        "LET'S LEARN SORING ALGORITHM",
        style: TextStyle(
          fontSize: 20,
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
        context, MaterialPageRoute(builder: (context) => StartPage())
        );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
        foregroundColor: MaterialStateProperty.all<Color>( Color.fromARGB(255, 3, 30, 65)),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: Colors.black, // Border color
            width: 2.0,          // Border thickness
          ),
        ),
        
      ),
      onPressed: this.click,
      
      child: Container(
        child: Text(
          'BACK',
          style: TextStyle(fontSize: 21,),
        ),
        width: 190,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
      ),
      // Text('START', style: TextStyle(fontSize: 30),),
    );
  }
}


//////////////////////////////////Button for "Continue"


class clickbtnback extends StatefulWidget {
  const clickbtnback({super.key});

  @override
  State<clickbtnback> createState() => _clickbtnbackState();
}

class _clickbtnbackState extends State<clickbtnback> {
  void click() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CL2HOME())
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
          style: TextStyle(fontSize: 21),
        ),
        width: 190,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
      ),
      // Text('START', style: TextStyle(fontSize: 30),),
    );
  }
}