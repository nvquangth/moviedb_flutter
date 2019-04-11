import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_widget.dart';
import 'package:toast/toast.dart';

class DetailState extends State<Detail> {
  bool isFavorite = false;
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Builder(builder: (context) {
        scaffoldContext = context;
        return _buildDetail(movie);
      }),
    );
  }

  Widget _buildDetail(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImage(movie.backdropPath),
        _buildTitle(movie.title)
      ],
    );
  }

  Widget _buildImage(String path) {
    var url = "http://image.tmdb.org/t/p/w780" + path;
    print(url);
    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.network(url, fit: BoxFit.fitWidth),
        ),
        Positioned(
          right: -10,
          bottom: 10,
          child: RawMaterialButton(
            onPressed: _handleFavorite,
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.blue,
              size: 35.0,
            ),
            shape: CircleBorder(),
            fillColor: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.all(10.0),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }

  Widget _buildOverview(String overview) {}

  _handleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    String msg = "";
    if (isFavorite) {
      msg = "Add to Favorite!";
    } else {
      msg = "Remove from Favorite!";
    }

    Toast.show(msg, context);
  }
}
