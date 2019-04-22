import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_widget.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_bloc.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_widget.dart';

class FavoriteState extends State<Favorite> {
  List<Movie> _movies = [];
  final FavoriteBloc bloc = FavoriteBloc();

  @override
  void initState() {
    super.initState();
    bloc.getMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: StreamBuilder(
            stream: bloc.movies,
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                _movies = snapshot.data;
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _movies.length,
                    itemBuilder: (context, i) {
                      return _buildRow(_movies[i], context);
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Widget _buildRow(Movie movie, BuildContext context) {
    var url = "http://image.tmdb.org/t/p/w185" + movie.posterPath;

    _gotoDetail() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Detail(
                movie: movie,
              )));

//      Navigator.of(context).pushNamed('/detail', arguments: movie);
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
              icon: Icon(Icons.favorite),
              onPressed: _handleFavorite,
            )
          ],
        ),
      ),
    );
  }
}
