import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/briefing.dart';
import 'dependencies.dart';
import 'state/briefings_controller.dart';
export 'state/briefings_controller.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredBriefingsProvider = Provider<List<Briefing>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final briefings = ref.watch(briefingsControllerProvider).value ?? <Briefing>[];
  if (query.isEmpty) {
    return briefings;
  }
  return briefings.where((briefing) {
    return briefing.clientName.toLowerCase().contains(query) ||
        briefing.email.toLowerCase().contains(query) ||
        briefing.instagramOrSite.toLowerCase().contains(query);
  }).toList();
});

final briefingByIdProvider = FutureProvider.family<Briefing?, String>((ref, id) {
  return ref.watch(getBriefingByIdProvider)(id);
});
