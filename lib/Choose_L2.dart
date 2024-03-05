import 'package:flutter/material.dart';



class CL2HOME extends StatefulWidget {
  const CL2HOME({super.key});

  @override
  State<CL2HOME> createState() => _CL2HOMEState();
}

class _CL2HOMEState extends State<CL2HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Let's learn sorting algorithm"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    return const Text(
      "CHOOSE SORTING ALGORITHM",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}

class NormalWidget extends StatelessWidget {
  const NormalWidget({super.key});

  void click() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => StartPage()));
  }

  @override
  Widget build(BuildContext context) {
    var message = StringBuffer('Dart is fun');

    for(var i = 0; i < 5; i++){
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('AH')),
        label: Text('Hamilton'),
      );
    }
    
    return new Wrap(
  spacing: 8.0, // gap between adjacent chips
  runSpacing: 4.0, // gap between lines
  children: <Widget>[
        

      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('AH')),
        label: Text('Hamilton'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('ML')),
        label: Text('Lafayette'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('HM')),
        label: Text('Mulligan'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('JL')),
        label: Text('Laurens'),
      ),
  ],
);
    

  }
}




// class ListBtn extends StatefulWidget {
//   const ListBtn({super.key});

//   @override
//   State<ListBtn> createState() => _ListBtnState();
// }

// class _ListBtnState extends State<ListBtn> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder( 
//       // itemCount: this.widget.listItems.length,
//       itemBuilder: (context, index) {
//         var post = this.widget.listItems[index];


//        return TextButton(
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateProperty.all<Color>(Color.fromARGB(255, 65, 65, 71)),
//         foregroundColor: MaterialStateProperty.all<Color>(
//             const Color.fromARGB(255, 255, 255, 255)),
//       ),
//       onPressed: ,
//       child: Container(
//         child: Text(
//           'BACK',
//           style: TextStyle(fontSize: 30),
//         ),
//         width: 190,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         alignment: Alignment.center,
//       ),
//       // Text('START', style: TextStyle(fontSize: 30),),
//     );
//       },
//     );
//   }
// }

























class clickbtn extends StatefulWidget {
  const clickbtn({super.key});

  @override
  State<clickbtn> createState() => _clickbtnState();
}

class _clickbtnState extends State<clickbtn> {
  void click() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => StartPage()));
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
          'BACK',
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