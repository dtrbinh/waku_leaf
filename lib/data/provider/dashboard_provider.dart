// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:wakucoin/modules/dashboard/widget_home.dart';
import 'package:wakucoin/modules/dashboard/widget_send_eth.dart';
import 'package:wakucoin/modules/dashboard/wiget_settings.dart';

class DashBoardProvider extends ChangeNotifier {
  int currentSelection = 0;

  void setCurrentSelection(int value) {
    currentSelection = value;
    notifyListeners();
  }




  Widget getBody(BuildContext context) {
    switch (currentSelection) {
      case 0:
        return home(context);
      case 1:
        return sendETH(context);
      case 2:
        return settings(context);
      default:
        return home(context);
    }
  }

  void reset() {
    currentSelection = 0;
    notifyListeners();
  }
}
