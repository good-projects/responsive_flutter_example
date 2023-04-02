import 'package:flutter/widgets.dart';

extension BuildContextExtensions on BuildContext {
  bool isBigScreen() {
    return MediaQuery.of(this).size.width > 980;
  }
}
