import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/widgets/loading_widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChewieVideoPlayerWidget extends StatefulWidget {
  const ChewieVideoPlayerWidget({super.key, required this.url});

  final String url;

  @override
  State<ChewieVideoPlayerWidget> createState() =>
      _ChewieVideoPlayerWidgetState();
}

class _ChewieVideoPlayerWidgetState extends State<ChewieVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _controller.value.size.height,
        child: _controller.value.isInitialized
            ? Chewie(controller: _chewieController)
            : const LoadingWidget());
  }
}

// class CustomVideoPlayerWidget extends StatefulWidget {
//   const CustomVideoPlayerWidget({super.key, required this.url});
//
//   final String url;
//
//   @override
//   State<CustomVideoPlayerWidget> createState() =>
//       _CustomVideoPlayerWidgetState();
// }
//
// class _CustomVideoPlayerWidgetState extends State<CustomVideoPlayerWidget> {
//   late VideoPlayerController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.url),
//       videoPlayerOptions: VideoPlayerOptions(
//         mixWithOthers: true,
//       ),
//     );
//
//     controller.addListener(() => setState(() {}));
//     controller.setLooping(true);
//     controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: VideoPlayer(controller),
//     );
//   }
// }
