import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yuix/routers/router.dart';
import 'package:yuix/themes/theme_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  await initHiveForFlutter();

  // Create the HttpLink
  final HttpLink httpLink = HttpLink('https://graphql.anilist.co');

  // Create the GraphQL client
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: MyApp(myclient: client),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.myclient});

  final ValueNotifier<GraphQLClient> myclient; // Marked as final

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GraphQLProvider(
      client: widget.myclient,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'YuiX',
        theme: themeProvider.currentTheme,
      ),
    );
  }
}
