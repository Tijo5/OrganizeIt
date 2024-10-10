import 'package:flutter/material.dart';

class LocaleProvider extends InheritedWidget {
  final Locale locale;
  final Function(Locale) changeLocale;

  const LocaleProvider({
    Key? key,
    required Widget child,
    required this.locale,
    required this.changeLocale,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(LocaleProvider oldWidget) {
    return locale != oldWidget.locale;
  }

  static LocaleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
  }
}
