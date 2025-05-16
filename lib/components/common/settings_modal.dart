import 'package:hive/hive.dart';
import 'package:yuix/auth/auth_provider.dart';
import 'package:yuix/hiveData/appData/database.dart';
import 'package:yuix/main.dart';
import 'package:yuix/screens/downloads/download_page.dart';
import 'package:yuix/screens/onboarding/login_page.dart';
import 'package:yuix/screens/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      // Listen to changes in AppData
      builder: (context, appData, child) {
        var box = Hive.box('login-data');
        final userInfo =
            box.get('userInfo', defaultValue: ['Guest', 'Guest', 'null']);
        final userName =
            (userInfo != null && userInfo.isNotEmpty) ? userInfo[0] : 'Guest';
        final avatarImagePath =
            (userInfo != null && userInfo.length > 2) ? userInfo[2] : 'null';
        final isLoggedIn = userName != 'Guest';

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  child: isLoggedIn
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: avatarImagePath != 'null'
                              ? Image.network(
                                  fit: BoxFit.cover, avatarImagePath)
                              : Icon(
                                  Icons.person,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                                ),
                        )
                      : Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName),
                  ],
                ),
                const Expanded(child: SizedBox.shrink()),
                IconButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    icon: const Icon(Iconsax.notification)),
              ]),
              const SizedBox(height: 10),
              if (!isLoggedIn)
                ListTile(
                  leading: const Icon(Iconsax.login),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Iconsax.user),
                title: const Text('View Profile'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.document_download),
                title: const Text('Downloads'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DownloadPage()),
                  );
                },
              ),
              if (isLoggedIn)
                ListTile(
                  leading: const Icon(Iconsax.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    final appData =
                        Provider.of<AppData>(context, listen: false);

                    await appData.logout();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainApp()),
                      (route) => false,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
