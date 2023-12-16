import 'package:superkauf/generic/constants.dart';

import '../../../library/app_navigation.dart';

class HomeNavigation {
  void goToLogin() {
    AppNavigation().push(ScreenPath.loginScreen, root: false);
  }
}
