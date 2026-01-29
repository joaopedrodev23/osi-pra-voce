import '../entities/briefing.dart';
import '../repositories/briefing_repository.dart';

class UpdateBriefing {
  UpdateBriefing(this._repository);

  final BriefingRepository _repository;

  Future<Briefing> call(Briefing briefing) {
    return _repository.update(briefing);
  }
}
