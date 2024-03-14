import 'package:flutter/material.dart';
import 'package:flutterapp/choiceB/continue_button.dart';



class CL2HOME extends StatefulWidget {
  const CL2HOME({super.key});

  @override
  State<CL2HOME> createState() => _CL2HOMEState();
}

class _CL2HOMEState extends State<CL2HOME> {

  List<Postbtn> posts = [Postbtn("Radix Sort"), Postbtn("Bubble Sort"),Postbtn("Merge Sort"),Postbtn("Insertion Sort"),Postbtn("Stupid Sort"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo"),Postbtn("Algo")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Let's learn sorting algorithm"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 16,),
            TextWidget(),
            SizedBox(height: 16,),
            Expanded(child: ListBtn(this.posts),),
            SizedBox(height: 8,),
            clickbtn(),
            SizedBox(height: 16,),
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
      "CHOOSE SORTING ALGORITHM",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}


class Postbtn {
  String textlabel;

  Postbtn(this.textlabel);
}

// class ListBtn extends StatefulWidget {
//   final List<Postbtn> listItems;

//   ListBtn(this.listItems);

//   @override
//   State<ListBtn> createState() => _ListBtnState();
// }

// class _ListBtnState extends State<ListBtn> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//         child: Wrap(
//           spacing: 14.0, // gap between adjacent chips
//           runSpacing: 14.0, // gap between lines
//           children: widget.listItems.map((post) {
//             return(
//               TextButton(
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all<OutlinedBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5), // Set the border radius to zero
//                     ),
//                   ),
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 92, 179)),
//                   foregroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 255, 255, 255)),
//                 ),
//                 onPressed: () {},
//                 child: Expanded(
//                   child: Text(
//                     post.textlabel,
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ),
//                 // Text('START', style: TextStyle(fontSize: 30),),
//               )
//             );
//           }).toList(),
//         ),
//     );
//   }
// }





class ListBtn extends StatefulWidget {
  // const ListBtn({super.key});

  final List<Postbtn> listItems;

  ListBtn(this.listItems);

  @override
  State<ListBtn> createState() => _ListBtnState();
}

class _ListBtnState extends State<ListBtn> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
            return Wrap(
              spacing: 18.0, // gap between adjacent chips
              runSpacing: 26.0, // gap between lines
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        width: double.infinity, // Expand to maximum width
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5), // Set the border radius to zero
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 92, 179)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 255, 255)),
                            
                          ),
                          onPressed: () {print(post.textlabel);},
                          // child: Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
                            child: Text(
                              post.textlabel,
                              style: TextStyle(fontSize: 30), 
                            ),
                            ),
                        ),
                            ))
                          )
                      ),
                      ],
            );


        // return Card(
        //   child: 
        //     Row(children: <Widget>[
        //       Row(children: <Widget>[
        //         Container(
        //             child: Text(post.textlabel, 
        //             style: TextStyle(fontSize: 20)),
        //             padding: EdgeInsets.fromLTRB(0, 0, 10, 0), 
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.thumb_up),
        //           onPressed:() {},
        //         )],)
        //       ] 
        //   ));
      },
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
        context, MaterialPageRoute(builder: (context) => L2HOME()));
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
          style: TextStyle(fontSize: 25),
        ),
        width: 140,
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
      ),
      // Text('START', style: TextStyle(fontSize: 30),),
    );
  }
}