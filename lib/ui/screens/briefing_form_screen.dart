import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../domain/entities/briefing.dart';
import '../../domain/validators/briefing_validators.dart';

class BriefingFormScreen extends ConsumerStatefulWidget {
  const BriefingFormScreen({super.key, this.briefingId});

  final String? briefingId;

  @override
  ConsumerState<BriefingFormScreen> createState() => _BriefingFormScreenState();
}

class _BriefingFormScreenState extends ConsumerState<BriefingFormScreen> {
  final _stepKeys = List.generate(4, (_) => GlobalKey<FormState>());

  final _clientNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _contentGoalOtherController = TextEditingController();
  final _targetAudienceController = TextEditingController();
  final _toneOtherController = TextEditingController();
  final _contentTypeOtherController = TextEditingController();
  final _deliverablesController = TextEditingController();
  final _keyMessageController = TextEditingController();
  final _ctaController = TextEditingController();
  final _restrictionsController = TextEditingController();
  final _notesController = TextEditingController();

  final List<TextEditingController> _referenceControllers = [
    TextEditingController(),
  ];

  final List<String> _goalOptions = const [
    'Engajamento',
    'Vendas',
    'Autoridade',
    'Informativo',
    'Outro',
  ];
  final List<String> _toneOptions = const [
    'Profissional',
    'Descontraído',
    'Inspirador',
    'Educativo',
    'Outro',
  ];
  final List<String> _contentTypeOptions = const [
    'Post feed',
    'Reels',
    'Stories',
    'Carrossel',
    'Outro',
  ];
  final List<String> _platformOptions = const [
    'Instagram',
    'TikTok',
    'YouTube',
    'Blog',
    'Site',
  ];

  String? _contentGoal;
  String? _toneOfVoice;
  String? _contentType;
  final Set<String> _platforms = {};
  DateTime? _deadline;
  bool _platformsError = false;

  int _currentStep = 0;
  bool _initialized = false;
  String? _editingId;
  DateTime? _createdAt;

  bool get _isEditing => widget.briefingId != null;

  @override
  void initState() {
    super.initState();
    _editingId = widget.briefingId;
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _instagramController.dispose();
    _projectNameController.dispose();
    _contentGoalOtherController.dispose();
    _targetAudienceController.dispose();
    _toneOtherController.dispose();
    _contentTypeOtherController.dispose();
    _deliverablesController.dispose();
    _keyMessageController.dispose();
    _ctaController.dispose();
    _restrictionsController.dispose();
    _notesController.dispose();
    for (final controller in _referenceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      final briefingAsync = ref.watch(briefingByIdProvider(widget.briefingId!));
      return briefingAsync.when(
        data: (briefing) {
          if (briefing == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Novo briefing')),
              body: const Center(child: Text('Briefing não encontrado.')),
            );
          }
          if (!_initialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _hydrateFromBriefing(briefing);
              }
            });
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return _buildForm(context);
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Scaffold(
          appBar: AppBar(title: const Text('Novo briefing')),
          body: Center(child: Text('Erro ao carregar: $error')),
        ),
      );
    }

    return _buildForm(context);
  }

  Scaffold _buildForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar briefing' : 'Novo briefing'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _handleContinue,
        onStepCancel: _handleCancel,
        controlsBuilder: (context, details) {
          final isLast = _currentStep == 3;
          return Row(
            children: [
              if (_currentStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Voltar'),
                ),
              const Spacer(),
              FilledButton(
                onPressed: details.onStepContinue,
                child: Text(isLast ? 'Salvar' : 'Continuar'),
              ),
            ],
          );
        },
        steps: [
          Step(
            title: const Text('Contato'),
            isActive: _currentStep >= 0,
            content: Form(
              key: _stepKeys[0],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _clientNameController,
                    decoration: const InputDecoration(labelText: 'Nome do cliente'),
                    validator: BriefingValidators.requiredField,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: BriefingValidators.email,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Telefone/WhatsApp'),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _instagramController,
                    decoration: const InputDecoration(labelText: 'Instagram ou site'),
                    validator: BriefingValidators.requiredField,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _projectNameController,
                    decoration: const InputDecoration(labelText: 'Nome do projeto/negócio'),
                    validator: BriefingValidators.requiredField,
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Objetivo e público'),
            isActive: _currentStep >= 1,
            content: Form(
              key: _stepKeys[1],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _contentGoal,
                    items: _goalOptions
                        .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _contentGoal = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Objetivo principal'),
                    validator: (value) =>
                        value == null ? 'Selecione uma opção' : null,
                  ),
                  if (_contentGoal == 'Outro') ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _contentGoalOtherController,
                      decoration: const InputDecoration(labelText: 'Outro objetivo'),
                      validator: (value) => BriefingValidators.otherRequired(
                        selected: _contentGoal ?? '',
                        otherValue: value,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _targetAudienceController,
                    decoration: const InputDecoration(labelText: 'Público-alvo'),
                    validator: BriefingValidators.requiredField,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _toneOfVoice,
                    items: _toneOptions
                        .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _toneOfVoice = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Tom de voz'),
                    validator: (value) =>
                        value == null ? 'Selecione uma opção' : null,
                  ),
                  if (_toneOfVoice == 'Outro') ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _toneOtherController,
                      decoration: const InputDecoration(labelText: 'Outro tom de voz'),
                      validator: (value) => BriefingValidators.otherRequired(
                        selected: _toneOfVoice ?? '',
                        otherValue: value,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Conteúdo'),
            isActive: _currentStep >= 2,
            content: Form(
              key: _stepKeys[2],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _contentType,
                    items: _contentTypeOptions
                        .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _contentType = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Tipo de conteúdo'),
                    validator: (value) =>
                        value == null ? 'Selecione uma opção' : null,
                  ),
                  if (_contentType == 'Outro') ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _contentTypeOtherController,
                      decoration: const InputDecoration(labelText: 'Outro tipo de conteúdo'),
                      validator: (value) => BriefingValidators.otherRequired(
                        selected: _contentType ?? '',
                        otherValue: value,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Plataformas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _platformOptions.map((platform) {
                      final selected = _platforms.contains(platform);
                      return FilterChip(
                        label: Text(platform),
                        selected: selected,
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              _platforms.add(platform);
                            } else {
                              _platforms.remove(platform);
                            }
                            if (_platforms.isNotEmpty) {
                              _platformsError = false;
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  if (_platformsError) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Selecione ao menos uma plataforma.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _deliverablesController,
                    decoration: const InputDecoration(
                      labelText: 'Entregáveis e quantidade',
                    ),
                    validator: BriefingValidators.requiredField,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDeadline(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Prazo desejado',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _deadline == null
                            ? 'Selecionar data'
                            : MaterialLocalizations.of(context)
                                .formatMediumDate(_deadline!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Links de referência',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(_referenceControllers.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _referenceControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Link ${index + 1}',
                                ),
                                keyboardType: TextInputType.url,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: _referenceControllers.length == 1
                                  ? null
                                  : () => _removeReference(index),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _addReference,
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar link'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Mensagem e notas'),
            isActive: _currentStep >= 3,
            content: Form(
              key: _stepKeys[3],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _keyMessageController,
                    decoration: const InputDecoration(labelText: 'Mensagem-chave'),
                    validator: BriefingValidators.requiredField,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _ctaController,
                    decoration: const InputDecoration(labelText: 'Call to Action (CTA)'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _restrictionsController,
                    decoration: const InputDecoration(labelText: 'Restrições'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(labelText: 'Observações adicionais'),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    final isLast = _currentStep == 3;
    if (_currentStep == 2 && _platforms.isEmpty) {
      setState(() {
        _platformsError = true;
      });
      return;
    }
    if (!_stepKeys[_currentStep].currentState!.validate()) {
      return;
    }
    if (isLast) {
      _submit();
      return;
    }
    setState(() {
      _currentStep += 1;
    });
  }

  void _handleCancel() {
    if (_currentStep == 0) {
      return;
    }
    setState(() {
      _currentStep -= 1;
    });
  }

  void _submit() async {
    for (var i = 0; i < _stepKeys.length; i++) {
      if (!_stepKeys[i].currentState!.validate()) {
        setState(() {
          _currentStep = i;
        });
        return;
      }
    }

    if (_contentGoal == null || _toneOfVoice == null || _contentType == null) {
      setState(() {
        _currentStep = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos obrigatórios.')),
      );
      return;
    }

    if (_platforms.isEmpty) {
      setState(() {
        _currentStep = 2;
        _platformsError = true;
      });
      return;
    }

    if (_isEditing && (_editingId == null || _createdAt == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aguarde o carregamento do briefing.')),
      );
      return;
    }

    final references = _referenceControllers
        .map((controller) => controller.text.trim())
        .where((link) => link.isNotEmpty)
        .toList();

    final now = DateTime.now();
    final platformsOrdered = _platformOptions
        .where((platform) => _platforms.contains(platform))
        .toList();
    final briefing = Briefing(
      id: _editingId ?? '',
      createdAt: _createdAt ?? now,
      updatedAt: now,
      clientName: _clientNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      instagramOrSite: _instagramController.text.trim(),
      projectName: _projectNameController.text.trim(),
      contentGoal: _contentGoal ?? '',
      contentGoalOther: _contentGoal == 'Outro'
          ? _contentGoalOtherController.text.trim()
          : '',
      targetAudience: _targetAudienceController.text.trim(),
      toneOfVoice: _toneOfVoice ?? '',
      toneOfVoiceOther: _toneOfVoice == 'Outro'
          ? _toneOtherController.text.trim()
          : '',
      contentType: _contentType ?? '',
      contentTypeOther: _contentType == 'Outro'
          ? _contentTypeOtherController.text.trim()
          : '',
      platforms: platformsOrdered,
      deliverables: _deliverablesController.text.trim(),
      keyMessage: _keyMessageController.text.trim(),
      callToAction: _ctaController.text.trim(),
      restrictions: _restrictionsController.text.trim(),
      notes: _notesController.text.trim(),
      deadline: _deadline,
      referenceLinks: references,
    );

    final controller = ref.read(briefingsControllerProvider.notifier);
    if (_isEditing) {
      final updated = await controller.updateBriefing(briefing);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Briefing atualizado.')),
      );
      context.go('/briefings/${updated.id}');
    } else {
      final created = await controller.create(briefing);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Briefing criado.')),
      );
      context.go('/briefings/${created.id}');
    }
  }

  void _addReference() {
    setState(() {
      _referenceControllers.add(TextEditingController());
    });
  }

  void _removeReference(int index) {
    setState(() {
      _referenceControllers[index].dispose();
      _referenceControllers.removeAt(index);
    });
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      _deadline = picked;
    });
  }

  void _hydrateFromBriefing(Briefing briefing) {
    _clientNameController.text = briefing.clientName;
    _emailController.text = briefing.email;
    _phoneController.text = briefing.phone;
    _instagramController.text = briefing.instagramOrSite;
    _projectNameController.text = briefing.projectName;
    _contentGoal = briefing.contentGoal.isEmpty ? null : briefing.contentGoal;
    _contentGoalOtherController.text = briefing.contentGoalOther;
    _targetAudienceController.text = briefing.targetAudience;
    _toneOfVoice = briefing.toneOfVoice.isEmpty ? null : briefing.toneOfVoice;
    _toneOtherController.text = briefing.toneOfVoiceOther;
    _contentType = briefing.contentType.isEmpty ? null : briefing.contentType;
    _contentTypeOtherController.text = briefing.contentTypeOther;
    _platforms
      ..clear()
      ..addAll(briefing.platforms);
    _deliverablesController.text = briefing.deliverables;
    _keyMessageController.text = briefing.keyMessage;
    _ctaController.text = briefing.callToAction;
    _restrictionsController.text = briefing.restrictions;
    _notesController.text = briefing.notes;
    _deadline = briefing.deadline;

    for (final controller in _referenceControllers) {
      controller.dispose();
    }
    _referenceControllers
      ..clear()
      ..addAll(
        briefing.referenceLinks.isEmpty
            ? [TextEditingController()]
            : briefing.referenceLinks
                .map((link) => TextEditingController(text: link)),
      );

    _editingId = briefing.id;
    _createdAt = briefing.createdAt;

    setState(() {
      _initialized = true;
    });
  }
}
