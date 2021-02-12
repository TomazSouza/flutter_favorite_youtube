import 'package:favorite_youtube/api.dart';
import 'package:favorite_youtube/blocs/favorite_bloc.dart';
import 'package:favorite_youtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: video.id
                  );
                },
                onLongPress: () {
                  bloc.toggleFavorite(video);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                        child: Text(
                      video.title,
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                    ))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
