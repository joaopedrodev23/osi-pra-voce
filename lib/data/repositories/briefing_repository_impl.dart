import 'package:hive/hive.dart';

import '../../domain/entities/briefing.dart';
import '../../domain/repositories/briefing_repository.dart';
import '../models/briefing_model.dart';
import '../utils/id_generator.dart';

class BriefingRepositoryImpl implements BriefingRepository {
  BriefingRepositoryImpl(this._box);

  final Box<BriefingModel> _box;

  @override
  Future<Briefing> create(Briefing briefing) async {
    final now = DateTime.now();
    final created = briefing.copyWith(
      id: IdGenerator.generate(),
      createdAt: now,
      updatedAt: now,
    );
    final model = BriefingModel.fromEntity(created);
    await _box.put(created.id, model);
    return created;
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<Briefing?> getById(String id) async {
    final model = _box.get(id);
    return model?.toEntity();
  }

  @override
  Future<List<Briefing>> list() async {
    final items = _box.values.map((model) => model.toEntity()).toList();
    items.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return items;
  }

  @override
  Future<List<Briefing>> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return list();
    }
    final items = _box.values.map((model) => model.toEntity()).where((briefing) {
      return briefing.clientName.toLowerCase().contains(normalized) ||
          briefing.email.toLowerCase().contains(normalized) ||
          briefing.instagramOrSite.toLowerCase().contains(normalized);
    }).toList();
    items.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return items;
  }

  @override
  Future<Briefing> update(Briefing briefing) async {
    final updated = briefing.copyWith(updatedAt: DateTime.now());
    final model = BriefingModel.fromEntity(updated);
    await _box.put(updated.id, model);
    return updated;
  }

  @override
  Future<Briefing> duplicate(String id) async {
    final original = _box.get(id)?.toEntity();
    if (original == null) {
      throw StateError('Briefing não encontrado');
    }

    final now = DateTime.now();
    final duplicated = original.copyWith(
      id: IdGenerator.generate(),
      createdAt: now,
      updatedAt: now,
      projectName: original.projectName.isEmpty
          ? original.projectName
          : '${original.projectName} (Cópia)',
    );

    await _box.put(duplicated.id, BriefingModel.fromEntity(duplicated));
    return duplicated;
  }
}
