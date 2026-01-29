import 'package:flutter/material.dart';

class BriefingsListScreen extends StatelessWidget {
  const BriefingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Briefings salvos'),
      ),
      body: const Center(
        child: Text('Lista de briefings (placeholder)'),
      ),
    );
  }
}
