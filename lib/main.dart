import 'package:flutter/material.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_bloc.dart';
import 'package:moviedb_flutter/ui/screen/favorite/favorite_widget.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_bloc.dart';
import 'package:moviedb_flutter/ui/screen/nowplaying/now_playing_widget.dart';

void main() => runApp(BlocProvider(child: MyApp(), bloc: FavoriteBloc()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: Main());
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
      appBar: _buildAppBar(),
      body: _tabs[_currentTab],
      bottomNavigationBar: _buildBottomNavigation(),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: _titleTabs[_currentTab],
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: "Search",
          onPressed: _gotoSearch,
        )
      ],
    );
  }

  void _gotoSearch() {}

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    "Movies & TV",
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  right: 10.0,
                  bottom: 10.0,
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/drawer_header.png"))),
          ),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Help & Feedback"),
            leading: Icon(Icons.mail),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: onItemSelected,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie), title: Text("Now Playing")),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), title: Text('Favorite'))
        ]);
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
