import '../entities/briefing.dart';
import '../repositories/briefing_repository.dart';

class CreateBriefing {
  CreateBriefing(this._repository);

  final BriefingRepository _repository;

  Future<Briefing> call(Briefing briefing) {
    return _repository.create(briefing);
  }
}
