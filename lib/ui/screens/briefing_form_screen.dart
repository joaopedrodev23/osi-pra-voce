import 'package:flutter/material.dart';

class BriefingFormScreen extends StatelessWidget {
  const BriefingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo briefing'),
      ),
      body: const Center(
        child: Text('Formulário de briefing (placeholder)'),
      ),
    );
  }
}
