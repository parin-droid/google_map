import 'package:flutter/material.dart';

class Global {
  static String apiKey = "AIzaSyDr6v76RXaYX7UeN0HhvKsnHSBHZzCnBQA";

  void loading({required bool show, String title = "Loading.."}) {
    if (show) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..maskColor = Colors.green.withOpacity(.3)

        /// custom style
        ..loadingStyle = EasyLoadingStyle.custom
        ..progressColor = Colors.green
        ..indicatorColor = Colors.green
        ..backgroundColor = Colors.white
        ..textColor = Colors.black

        ///
        ..userInteractions = false
        ..animationStyle = EasyLoadingAnimationStyle.offset
        ..dismissOnTap = kDebugMode;
      EasyLoading.show(
        maskType: EasyLoadingMaskType.custom,
        status: title,
      );
    } else {
      EasyLoading.dismiss();
    }
  }
}
