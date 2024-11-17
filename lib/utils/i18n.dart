import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class I18nUtil {
  static FlutterI18nDelegate getI18nDelegate() {
    return FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'vi',
        basePath: 'assets/i18n',
      ),
    );
  }

  static List<LocalizationsDelegate<dynamic>> getLocalizationDelegates() {
    return [
      getI18nDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  static List<Locale> getSupportedLocales() {
    return const [
      Locale('en'), // English
      Locale('vi'), // Vietnamese
    ];
  }

  static String translate(BuildContext context, String key) {
    return FlutterI18n.translate(context, key);
  }
}
