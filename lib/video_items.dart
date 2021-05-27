// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   VideoPlayerScreen({Key key}) : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     // Create an store the VideoPlayerController. The VideoPlayerController
//     // offers several different constructors to play videos from assets, files,
//     // or the internet.
//     _controller = VideoPlayerController.asset(
//       'assets/videos/bill-sent-to-collections.mov',
//     );

//     _initializeVideoPlayerFuture = _controller.initialize();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     // Ensure disposing of the VideoPlayerController to free up resources.
//     _controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Complete the code in the next step.
//   }
// }
