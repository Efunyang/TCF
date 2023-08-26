import 'package:echo_frontend/hyper_track_handler.dart';
import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:echo_frontend/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    ref.watch(hyperTrackHandlerProvider).init();
    return MaterialApp.router(
      title: 'echo'.hcd,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF9FEFF8),
          secondary: Color(0xFF7986CB),
        ),
      ),
    );
  }
}
