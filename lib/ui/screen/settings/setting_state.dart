import 'package:flutter/material.dart';
import 'package:moviedb_flutter/ui/screen/settings/setting_widget.dart';

class SettingState extends State<Setting> {
  final TextStyle stylePart = TextStyle(color: Colors.pink, fontSize: 15);
  final TextStyle styleHeading =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle styleTitle = TextStyle(color: Colors.white, fontSize: 15);

  final Color checkColor = Colors.black87;
  final Color activeColor = Colors.pink;

  bool enableInfoCards = true;
  bool enableBingeWatching = false;
  bool isAboutWatchlist = true;
  bool isAboutRewards = true;
  bool isShowWarning = true;
  bool isRestrictQuality = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Scrollbar(
        child: ListView(
      children: <Widget>[
        _buildLanguageCaptions(),
        _buildPlayback(),
        _buildGetNotifications(),
        _buildUseAnotherDevice(),
        _buildStreamingOnMobileNetworks(),
        _buildDownload(),
        _buildAbout(),
      ],
    ));
  }

  Widget _buildLanguageCaptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Language and captions",
            style: stylePart,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Audio languate",
                style: styleHeading,
              ),
              Text(
                "The video's original language",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Captions settings",
                style: styleHeading,
              ),
              Text(
                "Set preferences for closed captions",
                style: styleTitle,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPlayback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Text(
            "Playback",
            style: stylePart,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Parental controls",
                style: styleHeading,
              ),
              Text(
                "Show all",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, top: 32),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Enable Info Cards",
                        style: styleHeading,
                      ),
                      Text(
                        "Show information about the actors and songs featured at the curent position in the video",
                        style: styleTitle,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                    checkColor: checkColor,
                    activeColor: activeColor,
                    value: enableInfoCards,
                    onChanged: (value) {
                      setState(() {
                        enableInfoCards = !enableInfoCards;
                      });
                    })
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enable binge-watching",
                      style: styleHeading,
                    ),
                    Text(
                      "Automatically play the next episode in your library",
                      style: styleTitle,
                    )
                  ],
                ),
              ),
              Checkbox(
                  checkColor: checkColor,
                  activeColor: activeColor,
                  value: enableBingeWatching,
                  onChanged: (value) {
                    setState(() {
                      enableBingeWatching = !enableBingeWatching;
                    });
                  })
            ],
          ),
        )
      ],
    );
  }

  Widget _buildGetNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Text(
            "Get notifications",
            style: stylePart,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "About watchlist",
                        style: styleHeading,
                      ),
                      Text(
                        "When content from your watchlist becomes avaiable or drops in price",
                        style: styleTitle,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                    checkColor: checkColor,
                    activeColor: activeColor,
                    value: isAboutWatchlist,
                    onChanged: (value) {
                      setState(() {
                        isAboutWatchlist = !isAboutWatchlist;
                      });
                    })
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "About rewards",
                      style: styleHeading,
                    ),
                    Text(
                      "When your rewards are about to expire",
                      style: styleTitle,
                    )
                  ],
                ),
              ),
              Checkbox(
                  checkColor: checkColor,
                  activeColor: activeColor,
                  value: isAboutRewards,
                  onChanged: (value) {
                    setState(() {
                      isAboutRewards = !isAboutRewards;
                    });
                  })
            ],
          ),
        )
      ],
    );
  }

  Widget _buildUseAnotherDevice() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
            child: Text(
              "Use Play Movies on another device",
              style: stylePart,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Finish setting up a Roku or smart TV",
                  style: styleHeading,
                ),
                Text(
                  "Start setup on you TV, then finish here",
                  style: styleTitle,
                )
              ],
            ),
          )
        ]);
  }

  Widget _buildStreamingOnMobileNetworks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Text(
            "Streaming on mobile networks",
            style: stylePart,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Show warning",
                        style: styleHeading,
                      ),
                      Text(
                        "Displays a warning before streaming over a mobile network",
                        style: styleTitle,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                    checkColor: checkColor,
                    activeColor: activeColor,
                    value: isShowWarning,
                    onChanged: (value) {
                      setState(() {
                        isShowWarning = !isShowWarning;
                      });
                    })
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Restrict quality",
                      style: styleHeading,
                    ),
                    Text(
                      "Limits quality to SD when streaming over a mobile network (uses less data)",
                      style: styleTitle,
                    )
                  ],
                ),
              ),
              Checkbox(
                  checkColor: checkColor,
                  activeColor: activeColor,
                  value: isRestrictQuality,
                  onChanged: (value) {
                    setState(() {
                      isRestrictQuality = !isRestrictQuality;
                    });
                  })
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDownload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Text(
            "Downloads",
            style: stylePart,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Manage downloads",
                style: styleHeading,
              ),
              Text(
                "Free up space and view downloads in progress",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Network",
                style: styleHeading,
              ),
              Text(
                "Download only on Wi-Fi",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Quality",
                style: styleHeading,
              ),
              Text(
                "HD (Better quality)",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Storage",
                style: styleHeading,
              ),
              Text(
                "Internal storage",
                style: styleTitle,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Text(
            "About",
            style: stylePart,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Open source licenses",
                style: styleHeading,
              ),
              Text(
                "License details for open source software and fonts",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Device ID",
                style: styleHeading,
              ),
              Text(
                "1457865431654654654",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "App verison",
                style: styleHeading,
              ),
              Text(
                "2.11.5",
                style: styleTitle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Device",
                style: styleHeading,
              ),
              Text(
                "Google, Android SDK built for x86",
                style: styleTitle,
              )
            ],
          ),
        )
      ],
    );
  }
}
