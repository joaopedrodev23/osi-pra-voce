import '../entities/briefing.dart';
import '../repositories/briefing_repository.dart';

class ListBriefings {
  ListBriefings(this._repository);

  final BriefingRepository _repository;

  Future<List<Briefing>> call() {
    return _repository.list();
  }
}
