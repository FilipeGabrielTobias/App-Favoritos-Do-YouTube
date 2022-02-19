// @dart=2.9
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 25, child: Image.asset('images/yt_logo_rgb_dark.png')),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
