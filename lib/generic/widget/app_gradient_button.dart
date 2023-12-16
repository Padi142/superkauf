import 'package:flutter/material.dart';

import '../../library/app.dart';

class AppGradientButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final double radius;
  final List<Color> colors;
  final Function onPressed;

  const AppGradientButton({
    super.key,
    required this.buttonText,
    required this.width,
    required this.colors,
    required this.radius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.0, 1.0],
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(buttonText, style: App.appTheme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
