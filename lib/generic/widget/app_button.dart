import 'package:flutter/material.dart';

class AppButton<DROPDOWN_VALUE_TYPE extends Object> extends StatelessWidget {
  final Color? backgroundColor;
  final String text;
  final bool enabled;
  final EdgeInsets padding;
  final Widget? imagePrefix;
  final Widget? imageSuffix;
  final List<PopupOption<DROPDOWN_VALUE_TYPE>>? popupMenu;
  final double spaceTextImage;
  final double radius;
  final Color borderColor;
  final TextStyle? textStyle;
  final double? elevation;

  final Function()? onClick;
  final Function()? onCancelPopup;
  final Function(PopupOption<DROPDOWN_VALUE_TYPE>)? onSelectPopup;

  const AppButton({
    Key? key,
    this.backgroundColor,
    this.onClick,
    this.text = '',
    this.textStyle,
    this.enabled = true,
    this.padding = const EdgeInsets.all(4),
    this.imagePrefix,
    this.imageSuffix,
    this.popupMenu,
    this.onSelectPopup,
    this.onCancelPopup,
    this.spaceTextImage = 4.0,
    this.radius = 0,
    this.borderColor = Colors.transparent,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle useTextStyle = textStyle ?? const TextStyle(fontSize: 20);
    Widget btnChild = Container();
    final Widget imagePrefixChild = imagePrefix ?? Container();
    final Widget imageSuffixChild = imageSuffix ?? Container();
    final Widget textChild = Text(
      text,
      textAlign: TextAlign.center,
      style: useTextStyle,
    );

    if (imagePrefix != null || imageSuffix != null) {
      final List<Widget> child = [];

      if (imagePrefix != null) {
        child.add(imagePrefixChild);
      }
      if (text.isNotEmpty) {
        child.add(SizedBox(width: spaceTextImage));
        child.add(textChild);
      }
      if (imageSuffix != null) {
        child.add(SizedBox(width: spaceTextImage));
        child.add(imageSuffixChild);
      }
      btnChild = Row(children: child, mainAxisAlignment: MainAxisAlignment.center);
    } else {
      btnChild = textChild;
    }

    VoidCallback? action;

    if (popupMenu?.isNotEmpty ?? false) {
      action = () {
        //find position of button, so there can render popup menu options
        FocusScope.of(context).requestFocus(FocusNode());
        final RenderBox? button = context.findRenderObject() as RenderBox?;
        final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button?.localToGlobal(const Offset(0, 0), ancestor: overlay) ?? const Offset(0, 0),
            button?.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay) ?? const Offset(0, 0),
          ),
          Offset.zero & (overlay?.size ?? const Size(0, 0)),
        );

        final List<PopupMenuEntry<PopupOption<DROPDOWN_VALUE_TYPE>>> toShow = [];

        for (final popupOption in popupMenu ?? <PopupOption<DROPDOWN_VALUE_TYPE>>[]) {
          toShow.add(popupOption.make());
        }

        onClick?.call();

        showMenu(
          context: context,
          position: position,
          items: toShow,
          color: Colors.white,
        ).then((newValue) {
          if (newValue == null) {
            //cancel
            onCancelPopup?.call();
          } else {
            onSelectPopup?.call(newValue);
          }
        });
      };
    }

    final ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(color: borderColor),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        VoidCallback? onPressFunction;
        if (enabled) {
          onPressFunction = action ??
              (() {
                onClick?.call();
              });
        }
        return ButtonTheme(
          minWidth: constraints.maxHeight == double.infinity ? constraints.minHeight : constraints.maxHeight,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              // ignore: deprecated_member_use
              primary: backgroundColor ?? Colors.transparent,
              shape: shape as OutlinedBorder,
              padding: padding,
            ),
            onPressed: onPressFunction,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: btnChild,
              ),
            ),
          ),
        );
      },
    );
  }
}

class PopupOption<T> {
  String title;
  String? subtitle;
  T value;
  Widget? image;
  List<AppButton> buttons;
  bool divider;
  TextStyle? textStyle;
  TextStyle? subtitleTextStyle;
  Widget? widget;
  bool enabled;

  PopupOption({
    this.title = '',
    this.subtitle,
    required this.value,
    this.image,
    this.buttons = const [],
    this.divider = false,
    this.textStyle,
    this.subtitleTextStyle,
    this.widget,
    this.enabled = true,
  });

  PopupMenuEntry<PopupOption<T>> make() {
    if (divider) {
      return PopupMenuItem<PopupOption<T>>(
        child: Builder(
          builder: (context) {
            return Container(
              height: 1,
              color: Theme.of(context).primaryColor,
            );
          },
        ),
        value: this,
        enabled: false,
        height: 1,
        padding: EdgeInsets.zero,
      );
    } else if (title.isNotEmpty) {
      return PopupMenuItem<PopupOption<T>>(
        child: Builder(
          builder: (context) {
            return Row(
              children: <Widget>[
                if (image != null)
                  Container(
                    padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4, left: 4),
                    width: 35,
                    height: 35,
                    child: image,
                  )
                else
                  Container(),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title, style: textStyle ?? Theme.of(context).textTheme.bodyLarge),
                    if (subtitle == null) Container() else Text(subtitle ?? '', style: subtitleTextStyle ?? Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                const SizedBox(width: 8),
              ],
            );
          },
        ),
        value: this,
        enabled: enabled,
        padding: EdgeInsets.zero,
      );
    } else if (buttons.isNotEmpty) {
      return PopupMenuItem<PopupOption<T>>(
        child: Row(
          children: buttons.map((btn) {
            return Container(
              padding: const EdgeInsets.all(4),
              width: 40,
              height: 40,
              child: btn,
            );
          }).toList(),
        ),
        enabled: false,
        value: this,
      );
    } else if (widget != null) {
      return PopupMenuItem<PopupOption<T>>(
        child: Builder(
          builder: (context) {
            return widget!;
          },
        ),
        value: this,
        enabled: false,
        padding: EdgeInsets.zero,
      );
    }
    return const PopupMenuDivider(height: 0);
  }
}
