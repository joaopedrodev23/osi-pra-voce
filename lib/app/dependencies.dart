import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/hive/hive_boxes.dart';
import '../data/models/briefing_model.dart';
import '../data/repositories/briefing_repository_impl.dart';
import '../domain/repositories/briefing_repository.dart';
import '../domain/usecases/create_briefing.dart';
import '../domain/usecases/delete_briefing.dart';
import '../domain/usecases/duplicate_briefing.dart';
import '../domain/usecases/get_briefing_by_id.dart';
import '../domain/usecases/list_briefings.dart';
import '../domain/usecases/search_briefings.dart';
import '../domain/usecases/update_briefing.dart';

final briefingBoxProvider = Provider<Box<BriefingModel>>((ref) {
  return Hive.box<BriefingModel>(HiveBoxes.briefings);
});

final briefingRepositoryProvider = Provider<BriefingRepository>((ref) {
  return BriefingRepositoryImpl(ref.watch(briefingBoxProvider));
});

final createBriefingProvider = Provider<CreateBriefing>((ref) {
  return CreateBriefing(ref.watch(briefingRepositoryProvider));
});

final updateBriefingProvider = Provider<UpdateBriefing>((ref) {
  return UpdateBriefing(ref.watch(briefingRepositoryProvider));
});

final deleteBriefingProvider = Provider<DeleteBriefing>((ref) {
  return DeleteBriefing(ref.watch(briefingRepositoryProvider));
});

final getBriefingByIdProvider = Provider<GetBriefingById>((ref) {
  return GetBriefingById(ref.watch(briefingRepositoryProvider));
});

final listBriefingsProvider = Provider<ListBriefings>((ref) {
  return ListBriefings(ref.watch(briefingRepositoryProvider));
});

final searchBriefingsProvider = Provider<SearchBriefings>((ref) {
  return SearchBriefings(ref.watch(briefingRepositoryProvider));
});

final duplicateBriefingProvider = Provider<DuplicateBriefing>((ref) {
  return DuplicateBriefing(ref.watch(briefingRepositoryProvider));
});
