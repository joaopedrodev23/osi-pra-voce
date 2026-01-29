import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:osi_pra_voce/data/models/briefing_model.dart';
import 'package:osi_pra_voce/data/repositories/briefing_repository_impl.dart';
import 'package:osi_pra_voce/domain/entities/briefing.dart';
import 'package:osi_pra_voce/domain/usecases/duplicate_briefing.dart';

void main() {
  late Directory tempDir;
  late Box<BriefingModel> box;
  late BriefingRepositoryImpl repository;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(BriefingModelAdapter().typeId)) {
      Hive.registerAdapter(BriefingModelAdapter());
    }
    box = await Hive.openBox<BriefingModel>('briefings_test');
    repository = BriefingRepositoryImpl(box);
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  test('duplicação de briefing cria nova versão', () async {
    final original = Briefing(
      id: 'temp',
      createdAt: DateTime(2025, 1, 1),
      updatedAt: DateTime(2025, 1, 1),
      clientName: 'Camilla',
      email: 'camilla@exemplo.com',
      phone: '11999999999',
      instagramOrSite: '@camillafr',
      projectName: 'Projeto X',
      contentGoal: 'Engajamento',
      contentGoalOther: '',
      targetAudience: 'Público alvo',
      toneOfVoice: 'Profissional',
      toneOfVoiceOther: '',
      contentType: 'Post feed',
      contentTypeOther: '',
      platforms: const ['Instagram'],
      deliverables: '5 posts',
      keyMessage: 'Mensagem principal',
      callToAction: 'Chame no direct',
      restrictions: '',
      notes: '',
      deadline: null,
      referenceLinks: const [],
    );

    final created = await repository.create(original);
    final usecase = DuplicateBriefing(repository);
    final duplicated = await usecase(created.id);

    expect(duplicated.id, isNot(created.id));
    expect(duplicated.projectName, equals('Projeto X (Cópia)'));
    expect(duplicated.createdAt.isAfter(created.createdAt), isTrue);
  });
}
