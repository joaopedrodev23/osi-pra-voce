class Briefing {
  const Briefing({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.instagramOrSite,
    required this.projectName,
    required this.contentGoal,
    required this.contentGoalOther,
    required this.targetAudience,
    required this.toneOfVoice,
    required this.toneOfVoiceOther,
    required this.contentType,
    required this.contentTypeOther,
    required this.platforms,
    required this.deliverables,
    required this.keyMessage,
    required this.callToAction,
    required this.restrictions,
    required this.notes,
    required this.deadline,
    required this.referenceLinks,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String clientName;
  final String email;
  final String phone;
  final String instagramOrSite;
  final String projectName;

  final String contentGoal;
  final String contentGoalOther;
  final String targetAudience;
  final String toneOfVoice;
  final String toneOfVoiceOther;

  final String contentType;
  final String contentTypeOther;
  final List<String> platforms;
  final String deliverables;

  final String keyMessage;
  final String callToAction;
  final String restrictions;
  final String notes;

  final DateTime? deadline;
  final List<String> referenceLinks;

  Briefing copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? clientName,
    String? email,
    String? phone,
    String? instagramOrSite,
    String? projectName,
    String? contentGoal,
    String? contentGoalOther,
    String? targetAudience,
    String? toneOfVoice,
    String? toneOfVoiceOther,
    String? contentType,
    String? contentTypeOther,
    List<String>? platforms,
    String? deliverables,
    String? keyMessage,
    String? callToAction,
    String? restrictions,
    String? notes,
    DateTime? deadline,
    List<String>? referenceLinks,
  }) {
    return Briefing(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      clientName: clientName ?? this.clientName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      instagramOrSite: instagramOrSite ?? this.instagramOrSite,
      projectName: projectName ?? this.projectName,
      contentGoal: contentGoal ?? this.contentGoal,
      contentGoalOther: contentGoalOther ?? this.contentGoalOther,
      targetAudience: targetAudience ?? this.targetAudience,
      toneOfVoice: toneOfVoice ?? this.toneOfVoice,
      toneOfVoiceOther: toneOfVoiceOther ?? this.toneOfVoiceOther,
      contentType: contentType ?? this.contentType,
      contentTypeOther: contentTypeOther ?? this.contentTypeOther,
      platforms: platforms ?? this.platforms,
      deliverables: deliverables ?? this.deliverables,
      keyMessage: keyMessage ?? this.keyMessage,
      callToAction: callToAction ?? this.callToAction,
      restrictions: restrictions ?? this.restrictions,
      notes: notes ?? this.notes,
      deadline: deadline ?? this.deadline,
      referenceLinks: referenceLinks ?? this.referenceLinks,
    );
  }
}
