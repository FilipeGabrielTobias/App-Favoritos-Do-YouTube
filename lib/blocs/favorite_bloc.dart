import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/models/video.dart';

class FavoriteBloc extends BlocBase {

  Map<String, Video> _favorites = {};
  final StreamController<Map<String, Video>> _favController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  // TODO: verificar erro ao utilizar o SharedPreferences 
  FavoriteBloc() {
    // SharedPreferences.getInstance().then((prefs) {
    //   if (prefs.getKeys().contains('favorites')) {
    //     _favorites = json.decode(prefs.getString('favorites')).map((key, value) {
    //       return MapEntry(key, Video.fromJson(value));
    //     }).cast<String, Video>();
    //     _favController.add(_favorites);
    //   }
    // });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);

    // _saveFav();
  }

  void _saveFav() {
    // SharedPreferences.getInstance().then((prefs){
    //   prefs.setString('favorites', json.encode(_favorites));
    // });
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}