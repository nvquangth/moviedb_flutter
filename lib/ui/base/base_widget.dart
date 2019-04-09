import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class BaseWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    } else {
      return createIosWidget(context);
    }
  }
  
  A createAndroidWidget(BuildContext context);

  I createIosWidget(BuildContext context);

  Widget getName() {
    return Text(name());
  }

  String name();
}
