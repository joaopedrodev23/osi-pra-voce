import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'data/hive/hive_boxes.dart';
import 'data/models/briefing_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(BriefingModelAdapter().typeId)) {
    Hive.registerAdapter(BriefingModelAdapter());
  }
  await Hive.openBox<BriefingModel>(HiveBoxes.briefings);

  runApp(const ProviderScope(child: OsiApp()));
}

class OsiApp extends ConsumerWidget {
  const OsiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'OSI — Briefing de Criação de Conteúdo',
      theme: AppTheme.light(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
