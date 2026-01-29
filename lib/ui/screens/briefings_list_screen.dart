import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../domain/entities/briefing.dart';

class BriefingsListScreen extends ConsumerStatefulWidget {
  const BriefingsListScreen({super.key});

  @override
  ConsumerState<BriefingsListScreen> createState() =>
      _BriefingsListScreenState();
}

class _BriefingsListScreenState extends ConsumerState<BriefingsListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initialQuery = ref.read(searchQueryProvider);
    _searchController = TextEditingController(text: initialQuery);
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state =
          _searchController.text.trim();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final briefingsAsync = ref.watch(briefingsControllerProvider);
    final filtered = ref.watch(filteredBriefingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Briefings salvos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/briefings/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por nome, e-mail ou Instagram/site',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: briefingsAsync.when(
              data: (_) => _BriefingsList(items: filtered),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text('Erro ao carregar: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BriefingsList extends StatelessWidget {
  const _BriefingsList({required this.items});

  final List<Briefing> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Nenhum briefing encontrado.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final briefing = items[index];
        final date = MaterialLocalizations.of(context).formatMediumDate(
          briefing.updatedAt,
        );
        return Card(
          child: ListTile(
            onTap: () => context.push('/briefings/${briefing.id}'),
            title: Text(
              briefing.projectName.isEmpty
                  ? briefing.clientName
                  : briefing.projectName,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(briefing.clientName),
                const SizedBox(height: 2),
                Text(briefing.instagramOrSite),
                const SizedBox(height: 2),
                Text('Atualizado em $date'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
