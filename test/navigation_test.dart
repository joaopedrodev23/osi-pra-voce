import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:osi_pra_voce/app/dependencies.dart';
import 'package:osi_pra_voce/domain/entities/briefing.dart';
import 'package:osi_pra_voce/domain/repositories/briefing_repository.dart';
import 'package:osi_pra_voce/main.dart';

class FakeBriefingRepository implements BriefingRepository {
  final List<Briefing> _items = [];

  @override
  Future<Briefing> create(Briefing briefing) async {
    _items.add(briefing);
    return briefing;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((item) => item.id == id);
  }

  @override
  Future<Briefing> duplicate(String id) async {
    final original = _items.firstWhere((item) => item.id == id);
    final duplicated = original.copyWith(id: 'dup-${original.id}');
    _items.add(duplicated);
    return duplicated;
  }

  @override
  Future<Briefing?> getById(String id) async {
    for (final item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<List<Briefing>> list() async {
    return List<Briefing>.from(_items);
  }

  @override
  Future<List<Briefing>> search(String query) async {
    return list();
  }

  @override
  Future<Briefing> update(Briefing briefing) async {
    final index = _items.indexWhere((item) => item.id == briefing.id);
    if (index >= 0) {
      _items[index] = briefing;
    }
    return briefing;
  }
}

void main() {
  testWidgets('navegação Home → Lista', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          briefingRepositoryProvider.overrideWithValue(FakeBriefingRepository()),
        ],
        child: const OsiApp(),
      ),
    );

    expect(find.text('Briefings salvos'), findsOneWidget);

    await tester.tap(find.text('Briefings salvos'));
    await tester.pumpAndSettle();

    expect(find.text('Nenhum briefing encontrado.'), findsOneWidget);
  });
}
