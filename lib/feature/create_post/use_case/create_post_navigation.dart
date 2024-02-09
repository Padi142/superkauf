import 'package:superkauf/generic/constants.dart';

import '../../../library/app_navigation.dart';

class CreatePostNavigation {
  void goBack() {
    AppNavigation().pop();
  }

  void goToLogin() {
    AppNavigation().push(
      ScreenPath.loginScreen,
      root: false,
      replace: 1,
      params: ScreenPath.createPostScreen,
    );
  }
}
