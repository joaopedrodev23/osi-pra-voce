import '../entities/briefing.dart';

abstract class BriefingRepository {
  Future<Briefing> create(Briefing briefing);
  Future<Briefing> update(Briefing briefing);
  Future<void> delete(String id);
  Future<Briefing?> getById(String id);
  Future<List<Briefing>> list();
  Future<List<Briefing>> search(String query);
  Future<Briefing> duplicate(String id);
}
