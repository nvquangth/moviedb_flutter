import 'package:flutter/material.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_state.dart';

class Detail extends StatefulWidget {

  final Movie movie;

  const Detail({Key key, this.movie}): super(key: key);

  @override
  DetailState createState() => DetailState();
}
