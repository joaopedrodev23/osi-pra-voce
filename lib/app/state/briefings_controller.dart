import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/briefing.dart';
import '../../domain/usecases/create_briefing.dart';
import '../../domain/usecases/delete_briefing.dart';
import '../../domain/usecases/duplicate_briefing.dart';
import '../../domain/usecases/list_briefings.dart';
import '../../domain/usecases/update_briefing.dart';
import '../dependencies.dart';

class BriefingsController extends AsyncNotifier<List<Briefing>> {
  late final ListBriefings _listBriefings;
  late final CreateBriefing _createBriefing;
  late final UpdateBriefing _updateBriefing;
  late final DeleteBriefing _deleteBriefing;
  late final DuplicateBriefing _duplicateBriefing;

  @override
  Future<List<Briefing>> build() async {
    _listBriefings = ref.read(listBriefingsProvider);
    _createBriefing = ref.read(createBriefingProvider);
    _updateBriefing = ref.read(updateBriefingProvider);
    _deleteBriefing = ref.read(deleteBriefingProvider);
    _duplicateBriefing = ref.read(duplicateBriefingProvider);

    return _listBriefings();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await _listBriefings());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<Briefing> create(Briefing briefing) async {
    final created = await _createBriefing(briefing);
    _upsert(created);
    return created;
  }

  Future<Briefing> updateBriefing(Briefing briefing) async {
    final updated = await _updateBriefing(briefing);
    _upsert(updated);
    return updated;
  }

  Future<void> delete(String id) async {
    await _deleteBriefing(id);
    final items = List<Briefing>.from(state.value ?? [])
      ..removeWhere((item) => item.id == id);
    state = AsyncData(_sorted(items));
  }

  Future<Briefing> duplicate(String id) async {
    final duplicated = await _duplicateBriefing(id);
    _upsert(duplicated);
    return duplicated;
  }

  void _upsert(Briefing briefing) {
    final items = List<Briefing>.from(state.value ?? []);
    final index = items.indexWhere((item) => item.id == briefing.id);
    if (index >= 0) {
      items[index] = briefing;
    } else {
      items.add(briefing);
    }
    state = AsyncData(_sorted(items));
  }

  List<Briefing> _sorted(List<Briefing> items) {
    items.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return items;
  }
}

final briefingsControllerProvider =
    AsyncNotifierProvider<BriefingsController, List<Briefing>>(
  BriefingsController.new,
);
