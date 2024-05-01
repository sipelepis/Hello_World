import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class RadixSortScreen extends StatefulWidget {
  @override
  _RadixSortScreenState createState() => _RadixSortScreenState();
}

class _RadixSortScreenState extends State<RadixSortScreen> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/RadixVidSort.mp4')
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller.play();
        });
        flickManager = FlickManager(
          videoPlayerController: _controller,
        );
      }).catchError((error) {
        print('Error initializing video player: $error');
        setState(() {
          _isLoading = false;
        });
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    flickManager.dispose();
    _controller.dispose();
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
            if (_isLoading)
              Container(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                ),
              )
            else
              Container(
                height: 200,
                child: Center(child: Text('Failed to load video.')),
              ),
            SizedBox(height: 20),
            detailedExplanationText(),
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


