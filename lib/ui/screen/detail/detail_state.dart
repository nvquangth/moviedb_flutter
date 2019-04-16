import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/cast.dart';
import 'package:moviedb_flutter/data/model/cast_response.dart';
import 'package:moviedb_flutter/data/model/company.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_widget.dart';
import 'package:toast/toast.dart';

class DetailState extends State<Detail> {
  bool isFavorite = false;
  BuildContext scaffoldContext;
  Movie _movie;
  final _injection = AppInjection();

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    _injection.provideRepository().getMovie(true, _movie.id, onSuccess, onFail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movie.title),
      ),
      body: Builder(builder: (context) {
        scaffoldContext = context;
        return _buildDetail(_movie);
      }),
    );
  }

  void onSuccess(Movie movie) {
    setState(() {
      print(movie);
      _movie = movie;
    });
  }

  void onFail(Exception e) {}

  Widget _buildDetail(Movie movie) {
    return ListView(
      children: <Widget>[
        _buildImage(movie.backdropPath),
        _buildTitle(movie.title),
        _buildOverview(movie.overview),
        movie.castResponse != null
            ? _buildCast(movie.castResponse)
            : Center(
                child: CircularProgressIndicator(),
              ),
        movie.companies != null
            ? _buildCompany(movie.companies)
            : Container()
      ],
    );
  }

  Widget _buildImage(String path) {
    var url = "http://image.tmdb.org/t/p/w780" + path;
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

  Widget _buildOverview(String overview) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Overview",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: Text(
                overview,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCast(CastResponse castResponse) {
    return Container(
      height: 180,
      child: Card(
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Cast",
                style: TextStyle(fontSize: 16.0, color: Colors.blue),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: castResponse.casts.length,
                  itemBuilder: (context, i) {
                    return _buildRowCast(castResponse.casts[i]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowCast(Cast cast) {
    var url = "http://image.tmdb.org/t/p/w185/gAXGlrS9RlNA1sxJqi9C8gVsnUB.jpg";
    if (cast.profilePath != null) {
      url = "http://image.tmdb.org/t/p/w185" + cast.profilePath;
    }

    return Column(
      children: <Widget>[
        Image.network(
          url,
          width: 75.0,
        ),
        Text(cast.name)
      ],
    );
  }

  Widget _buildCompany(List<Company> companies) {
    return Container(
      height: 180,
      child: Card(
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Company",
                style: TextStyle(fontSize: 16.0, color: Colors.blue),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: companies.length,
                  itemBuilder: (context, i) {
                    return _buildRowCompany(companies[i]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowCompany(Company company) {
    var url = "http://image.tmdb.org/t/p/w185/2Tc1P3Ac8M479naPp1kYT3izLS5.png";
    if (company.logoPath != null) {
      url = "http://image.tmdb.org/t/p/w185" + company.logoPath;
    }

    return Column(
      children: <Widget>[
        Image.network(
          url,
          width: 75.0,
        ),
        Text(company.name)
      ],
    );
  }

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
