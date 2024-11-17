import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:yuix/hiveData/locale_provider.dart';
import 'package:yuix/utils/i18n.dart';
import 'package:provider/provider.dart';

class ChooseLanguageDialog extends StatefulWidget {
  const ChooseLanguageDialog({
    super.key,
  });

  @override
  _ChooseLanguageDialogState createState() => _ChooseLanguageDialogState();
}

class _ChooseLanguageDialogState extends State<ChooseLanguageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18nUtil.translate(context, 'choose_your_language')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: Text('English'),
              onTap: () {
                FlutterI18n.refresh(context, const Locale('en'));
                context.read<LocaleProvider>().setLocale(Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Tiếng Việt'),
              onTap: () {
                FlutterI18n.refresh(context, const Locale('vi'));
                context.read<LocaleProvider>().setLocale(Locale('vi'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
