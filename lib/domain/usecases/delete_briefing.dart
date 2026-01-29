import '../repositories/briefing_repository.dart';

class DeleteBriefing {
  DeleteBriefing(this._repository);

  final BriefingRepository _repository;

  Future<void> call(String id) {
    return _repository.delete(id);
  }
}
