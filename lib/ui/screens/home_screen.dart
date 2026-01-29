import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/branding/osi_logo.png',
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(height: 180);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'OSI',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: scheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Briefings de Criação de Conteúdo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.primaryContainer,
                    ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.push('/briefings/new'),
                child: const Text('Novo briefing'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.push('/briefings'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  side: BorderSide(color: scheme.primary),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Briefings salvos'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
