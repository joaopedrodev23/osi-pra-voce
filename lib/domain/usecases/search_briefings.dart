import '../entities/briefing.dart';
import '../repositories/briefing_repository.dart';

class SearchBriefings {
  SearchBriefings(this._repository);

  final BriefingRepository _repository;

  Future<List<Briefing>> call(String query) {
    return _repository.search(query);
  }
}
