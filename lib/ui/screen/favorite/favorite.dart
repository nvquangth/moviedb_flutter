import 'package:flutter/material.dart';
import 'package:moviedb_flutter/ui/base/base_widget.dart';

class Favorite extends BaseWidget {
  @override
  Widget createAndroidWidget(BuildContext context) {

    return Container(
      child: Center(
        child: getName(),
      ),
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return null;
  }

  @override
  String name() {
    return "Favorite";
  }
}
