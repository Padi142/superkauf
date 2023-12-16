import 'package:superkauf/generic/constants.dart';

import '../../../library/app_navigation.dart';

class AccountNavigation {
  void goToLogin() {
    AppNavigation().push(ScreenPath.loginScreen, root: false, replace: 1);
  }

  void goToAccount() {
    AppNavigation().push(ScreenPath.profileScreen, root: false, replace: 1);
  }
}
