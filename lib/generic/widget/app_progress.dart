import 'package:flutter/material.dart';

import '../../library/app.dart';

class AppProgress extends StatelessWidget {
  final double size;
  const AppProgress({Key? key, this.size = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: size,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(App.appTheme.secondaryColor),
      ),
    );
  }
}
