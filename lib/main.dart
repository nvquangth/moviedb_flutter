import 'package:flutter/material.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_bloc.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_widget.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_bloc.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_widget.dart';

void main() => runApp(
  BlocProvider(child: MyApp(), bloc: FavoriteBloc())
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Main()
    );
  }
}

class MainState extends State<Main> {
  int _currentTab = 0;
  final List<Widget> _titleTabs = [Text("Now Playing"), Text("Favorite")];

  @override
  Widget build(BuildContext context) {

    final List<Widget> _tabs = [
      BlocProvider<NowPlayingBloc>(
        bloc: NowPlayingBloc(),
        child: NowPlaying(),
      ),
      BlocProvider<FavoriteBloc>(
        bloc: BlocProvider.of<FavoriteBloc>(context),
        child: Favorite(),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: _titleTabs[_currentTab],
        centerTitle: true,
      ),
      body: _tabs[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: onItemSelected,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.movie), title: Text("Now Playing")),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library), title: Text('Favorite'))
          ]),
    );
  }

  void onItemSelected(int index) {
    setState(() {
      if (index != _currentTab) {
        _currentTab = index;
      } else {}
    });
  }
}

class Main extends StatefulWidget {
  @override
  MainState createState() => MainState();
}
