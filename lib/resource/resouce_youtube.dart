import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ResouceYoutube extends StatefulWidget {
  const ResouceYoutube({Key? key}) : super(key: key);

  @override
  _ResouceYoutubeState createState() => _ResouceYoutubeState();
}

class _ResouceYoutubeState extends State<ResouceYoutube> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController =
        YoutubePlayerController(initialVideoId: '0fkCDLJaDwU');
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();

    return YoutubePlayerControllerProvider(
        controller: _youtubePlayerController,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Video player no CEMEC :-)'),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [const Expanded(child: player)],
              );
            },
          ),
        ));
  }
}
