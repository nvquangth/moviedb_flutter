import 'package:flutter/material.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_widget.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_widget.dart';
import 'package:moviedb_flutter/ui/screen/detail/detail_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
      routes: <String, WidgetBuilder> {
        '/detail': (BuildContext context) => Detail()
      },
    );
  }
}

class MainState extends State<Main> {
  int _currentTab = 0;
  final List<Widget> _tabs = [NowPlaying(), Favorite()];
  final List<Widget> _titleTabs = [
    Text("Now Playing"),
    Text("Favorite")
  ];

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(Icons.home),
                title: Text("Now Playing")),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorite'))
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
