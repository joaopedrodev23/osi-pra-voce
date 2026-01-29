import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../domain/entities/briefing.dart';

class BriefingDetailScreen extends ConsumerWidget {
  const BriefingDetailScreen({super.key, required this.briefingId});

  final String briefingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final briefingAsync = ref.watch(briefingByIdProvider(briefingId));

    return briefingAsync.when(
      data: (briefing) {
        if (briefing == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Briefing')),
            body: const Center(child: Text('Briefing não encontrado.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalhe do briefing'),
            actions: [
              IconButton(
                tooltip: 'Editar',
                onPressed: () => context.push('/briefings/${briefing.id}/edit'),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                tooltip: 'Duplicar',
                onPressed: () async {
                  final duplicated = await ref
                      .read(briefingsControllerProvider.notifier)
                      .duplicate(briefing.id);
                  context.go('/briefings/${duplicated.id}');
                },
                icon: const Icon(Icons.copy),
              ),
              IconButton(
                tooltip: 'Excluir',
                onPressed: () => _confirmDelete(context, ref, briefing),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          body: _BriefingDetailBody(briefing: briefing),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Briefing')),
        body: Center(child: Text('Erro ao carregar: $error')),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Briefing briefing,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir briefing'),
          content: const Text('Tem certeza que deseja excluir este briefing?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    await ref.read(briefingsControllerProvider.notifier).delete(briefing.id);
    if (!context.mounted) {
      return;
    }
    context.go('/briefings');
  }
}

class _BriefingDetailBody extends StatelessWidget {
  const _BriefingDetailBody({required this.briefing});

  final Briefing briefing;

  @override
  Widget build(BuildContext context) {
    final createdAt = MaterialLocalizations.of(context).formatMediumDate(
      briefing.createdAt,
    );
    final updatedAt = MaterialLocalizations.of(context).formatMediumDate(
      briefing.updatedAt,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Section(
          title: 'Contato',
          children: [
            _InfoRow(label: 'Cliente', value: briefing.clientName),
            _InfoRow(label: 'E-mail', value: briefing.email),
            _InfoRow(label: 'Telefone', value: briefing.phone),
            _InfoRow(label: 'Instagram/Site', value: briefing.instagramOrSite),
            _InfoRow(label: 'Projeto', value: briefing.projectName),
          ],
        ),
        _Section(
          title: 'Objetivo e público',
          children: [
            _InfoRow(label: 'Objetivo', value: _withOther(briefing.contentGoal, briefing.contentGoalOther)),
            _InfoRow(label: 'Público-alvo', value: briefing.targetAudience),
            _InfoRow(label: 'Tom de voz', value: _withOther(briefing.toneOfVoice, briefing.toneOfVoiceOther)),
          ],
        ),
        _Section(
          title: 'Conteúdo',
          children: [
            _InfoRow(label: 'Tipo', value: _withOther(briefing.contentType, briefing.contentTypeOther)),
            _InfoRow(label: 'Plataformas', value: briefing.platforms.join(', ')),
            _InfoRow(label: 'Entregáveis', value: briefing.deliverables),
            if (briefing.deadline != null)
              _InfoRow(
                label: 'Prazo',
                value: MaterialLocalizations.of(context).formatMediumDate(
                  briefing.deadline!,
                ),
              ),
          ],
        ),
        _Section(
          title: 'Mensagem e notas',
          children: [
            _InfoRow(label: 'Mensagem-chave', value: briefing.keyMessage),
            _InfoRow(label: 'CTA', value: briefing.callToAction),
            _InfoRow(label: 'Restrições', value: briefing.restrictions),
            _InfoRow(label: 'Observações', value: briefing.notes),
          ],
        ),
        _Section(
          title: 'Referências',
          children: [
            if (briefing.referenceLinks.isEmpty)
              const _InfoRow(label: 'Links', value: 'Nenhum link informado')
            else
              ...briefing.referenceLinks.map(
                (link) => _InfoRow(label: 'Link', value: link),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Criado em $createdAt • Atualizado em $updatedAt',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  String _withOther(String value, String other) {
    if (value == 'Outro' && other.trim().isNotEmpty) {
      return 'Outro: $other';
    }
    return value;
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}
