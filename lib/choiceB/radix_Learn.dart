import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class RadixSortScreen extends StatefulWidget {
  @override
  _RadixSortScreenState createState() => _RadixSortScreenState();
}

class _RadixSortScreenState extends State<RadixSortScreen> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset('assets/RadixVidSort.mp4'),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Learn Radix Sort"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200, // Set the height for the video player
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
            SizedBox(height: 20),
            Text(
              'Radix Sort',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: detailedExplanationText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailedExplanationText() {
    return Text(
      'Radix: The fundamental base of a numeral system, determining the number of unique digits and their positional values.\n\n'
      'Decimal System (Base 10): Radix is 10, with digits 0 through 9 representing values from 0 to 9 and each position representing a power of 10 (e.g., units, tens, hundreds).\n\n'
      'Binary System (Base 2): Radix is 2, with digits 0 and 1 representing values from 0 to 1 and each position representing a power of 2 (e.g., units, twos, fours).\n\n'
      'Positional Notation: Radix governs how numbers are represented by the placement of digits, where each position corresponds to a power of the radix.\n\n'
      'Radix Sort: Sorting algorithm that works by distributing elements into buckets according to individual digits or radix positions, then combining them.\n\n'
      'Computing Significance: Radix is foundational in various fields, including data representation, cryptography, and sorting algorithms, impacting how numbers are stored, processed, and manipulated in computer systems.',
      textAlign: TextAlign.justify,
    );
  }
}
