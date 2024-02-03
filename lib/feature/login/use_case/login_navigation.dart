// import '../../../generic/constant.dart';
// import '../../../library/app_navigation.dart';
//
import 'package:superkauf/library/app_navigation.dart';

class LoginNavigation {
  // void goToHome() {
  //   AppNavigation().push(ScreenPath.HOME_SCREEN, root: true);
  // }

  void goBack(String path) {
    AppNavigation().push(path, root: false, replace: 1);
  }
}
