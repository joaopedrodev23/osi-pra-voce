import '../entities/briefing.dart';
import '../repositories/briefing_repository.dart';

class GetBriefingById {
  GetBriefingById(this._repository);

  final BriefingRepository _repository;

  Future<Briefing?> call(String id) {
    return _repository.getById(id);
  }
}
