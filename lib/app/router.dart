import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/briefing_form_screen.dart';
import '../ui/screens/briefings_list_screen.dart';
import '../ui/screens/home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/briefings',
        builder: (context, state) => const BriefingsListScreen(),
      ),
      GoRoute(
        path: '/briefings/new',
        builder: (context, state) => const BriefingFormScreen(),
      ),
    ],
  );
});
