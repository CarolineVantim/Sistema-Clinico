import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sistema_clinico/shared/widgets/loading_widgets.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailPage extends StatefulWidget {
  const ServiceDetailPage(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  late VideoPlayerController controller;
  bool _isLooping = false;

  final images = [
    'https://images.pexels.com/photos/6203420/pexels-photo-6203420.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/6191928/pexels-photo-6191928.jpeg?auto=compress&cs=tinysrgb&w=1200',
    'https://images.pexels.com/photos/8460036/pexels-photo-8460036.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  ];

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      videoPlayerOptions: VideoPlayerOptions(),
      Uri.parse(
        'https://videos.pexels.com/video-files/8159870/8159870-sd_640_360_25fps.mp4',
      ),
    )..initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Card.outlined(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'OBSERVAÇÃO',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: Text(widget.description),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: Text(
              'VIDEOS',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          controller.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: VideoPlayer(controller),
                    ),
                  ),
                )
              : const LoadingWidget(),
          OverflowBar(
            children: [
              IconButton(
                onPressed: () {
                  controller.play();
                },
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  controller.pause();
                },
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                icon: _isLooping
                    ? const Icon(Icons.restart_alt)
                    : Icon(Icons.restart_alt, color: Colors.grey.shade200),
                onPressed: () {
                  _isLooping = !_isLooping;
                  setState(() {
                    controller.setLooping(_isLooping);
                  });
                },
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Text('FOTOS', style: Theme.of(context).textTheme.headlineSmall),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: CarouselView(
              itemExtent: 320,
              onTap: (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: const Text('PhotoView')),
                      body: PhotoView(
                        imageProvider: NetworkImage(
                          images[value],
                        ),
                      ),
                    ),
                  ),
                );
              },
              children: [
                Image.network(
                  images[0],
                  fit: BoxFit.cover,
                ),
                Image.network(
                  images[1],
                  fit: BoxFit.cover,
                ),
                Image.network(
                  images[2],
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
