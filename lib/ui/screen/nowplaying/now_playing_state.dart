import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/data/repository/movie_repository.dart';
import 'package:moviedb_flutter/data/source/data_source.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_widget.dart';

class NowPlayingState extends State<NowPlaying> {
  static const remote = MovieRemoteDataSource();
  var repository = MovieRepositoryImpl(remote: remote);
  var isLoading = true;
  List<Movie> movies;

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    repository.getNowPlaying(1, onSuccess, onFail);
  }

  void onSuccess(MovieResponse movieResponse) {
    setState(() {
      isLoading = false;
      this.movies = movieResponse.movies;
    });
  }

  void onFail(Exception e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, i) {
                  return _buildRow(movies[i], context);
                }),
      ),
    );
  }

  Widget _buildRow(Movie movie, BuildContext context) {
    var url = "http://image.tmdb.org/t/p/w185" + movie.posterPath;

    _gotoDetail() {
//      Navigator.of(context)
//          .push(MaterialPageRoute(builder: (context) => Detail()));

      Navigator.of(context).pushNamed('/detail', arguments: movie);
    }

    _handleFavorite() {}

    return GestureDetector(
      onTap: _gotoDetail,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(url),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        movie.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            movie.vote.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.star, color: Colors.yellow)
                        ],
                      ))
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: _handleFavorite,
            )
          ],
        ),
      ),
    );
  }
}
