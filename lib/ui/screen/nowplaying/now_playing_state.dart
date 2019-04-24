import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_bloc.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_widget.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_bloc.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_widget.dart';

class NowPlayingState extends State<NowPlaying> {
  NowPlayingBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<NowPlayingBloc>(context);
    _bloc.fetchMovies(1);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: StreamBuilder(
            stream: _bloc.movies,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<MovieResponse> snapshot) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.movies.length,
        itemBuilder: (context, i) {
          return _buildRow(snapshot.data.movies[i], context);
        });
  }

  Widget _buildRow(Movie movie, BuildContext context) {
    var url = "http://image.tmdb.org/t/p/w185" + movie.posterPath;

    _gotoDetail() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<DetailBloc>(
                bloc: DetailBloc(),
                child: Detail(
                  movie: movie,
                ),
              )));
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
              icon: movie.isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
              onPressed: _handleFavorite,
            )
          ],
        ),
      ),
    );
  }
}
