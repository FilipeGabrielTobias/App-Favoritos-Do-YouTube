import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/api.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: (){
        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0), 
                      child: Text(
                        video.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8), 
                      child: Text(
                        video.channel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: favoriteBloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: Icon(
                        snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border
                      ),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        favoriteBloc.toggleFavorite(video);
                      },
                    );  
                  } else {
                    return const CircularProgressIndicator();
                  }
                }
              )
            ],
          )
        ],
      ),
    );
  }
}