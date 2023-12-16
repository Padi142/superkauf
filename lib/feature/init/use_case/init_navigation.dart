import 'package:superkauf/generic/constants.dart';

import '../../../library/app_navigation.dart';

class InitNavigation {
  void goToHome() {
    AppNavigation().push(ScreenPath.homeScreen, root: true);
  }
}
