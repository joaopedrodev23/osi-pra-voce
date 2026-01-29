import 'package:hive/hive.dart';

import '../../domain/entities/briefing.dart';

class BriefingModel {
  BriefingModel({
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

  factory BriefingModel.fromEntity(Briefing briefing) {
    return BriefingModel(
      id: briefing.id,
      createdAt: briefing.createdAt,
      updatedAt: briefing.updatedAt,
      clientName: briefing.clientName,
      email: briefing.email,
      phone: briefing.phone,
      instagramOrSite: briefing.instagramOrSite,
      projectName: briefing.projectName,
      contentGoal: briefing.contentGoal,
      contentGoalOther: briefing.contentGoalOther,
      targetAudience: briefing.targetAudience,
      toneOfVoice: briefing.toneOfVoice,
      toneOfVoiceOther: briefing.toneOfVoiceOther,
      contentType: briefing.contentType,
      contentTypeOther: briefing.contentTypeOther,
      platforms: briefing.platforms,
      deliverables: briefing.deliverables,
      keyMessage: briefing.keyMessage,
      callToAction: briefing.callToAction,
      restrictions: briefing.restrictions,
      notes: briefing.notes,
      deadline: briefing.deadline,
      referenceLinks: briefing.referenceLinks,
    );
  }

  Briefing toEntity() {
    return Briefing(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      clientName: clientName,
      email: email,
      phone: phone,
      instagramOrSite: instagramOrSite,
      projectName: projectName,
      contentGoal: contentGoal,
      contentGoalOther: contentGoalOther,
      targetAudience: targetAudience,
      toneOfVoice: toneOfVoice,
      toneOfVoiceOther: toneOfVoiceOther,
      contentType: contentType,
      contentTypeOther: contentTypeOther,
      platforms: platforms,
      deliverables: deliverables,
      keyMessage: keyMessage,
      callToAction: callToAction,
      restrictions: restrictions,
      notes: notes,
      deadline: deadline,
      referenceLinks: referenceLinks,
    );
  }
}

class BriefingModelAdapter extends TypeAdapter<BriefingModel> {
  @override
  final int typeId = 1;

  @override
  BriefingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }

    return BriefingModel(
      id: fields[0] as String,
      createdAt: fields[1] as DateTime,
      updatedAt: fields[2] as DateTime,
      clientName: fields[3] as String,
      email: fields[4] as String,
      phone: fields[5] as String,
      instagramOrSite: fields[6] as String,
      projectName: fields[7] as String,
      contentGoal: fields[8] as String,
      contentGoalOther: fields[9] as String,
      targetAudience: fields[10] as String,
      toneOfVoice: fields[11] as String,
      toneOfVoiceOther: fields[12] as String,
      contentType: fields[13] as String,
      contentTypeOther: fields[14] as String,
      platforms: (fields[15] as List).cast<String>(),
      deliverables: fields[16] as String,
      keyMessage: fields[17] as String,
      callToAction: fields[18] as String,
      restrictions: fields[19] as String,
      notes: fields[20] as String,
      deadline: fields[21] as DateTime?,
      referenceLinks: (fields[22] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BriefingModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.clientName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.instagramOrSite)
      ..writeByte(7)
      ..write(obj.projectName)
      ..writeByte(8)
      ..write(obj.contentGoal)
      ..writeByte(9)
      ..write(obj.contentGoalOther)
      ..writeByte(10)
      ..write(obj.targetAudience)
      ..writeByte(11)
      ..write(obj.toneOfVoice)
      ..writeByte(12)
      ..write(obj.toneOfVoiceOther)
      ..writeByte(13)
      ..write(obj.contentType)
      ..writeByte(14)
      ..write(obj.contentTypeOther)
      ..writeByte(15)
      ..write(obj.platforms)
      ..writeByte(16)
      ..write(obj.deliverables)
      ..writeByte(17)
      ..write(obj.keyMessage)
      ..writeByte(18)
      ..write(obj.callToAction)
      ..writeByte(19)
      ..write(obj.restrictions)
      ..writeByte(20)
      ..write(obj.notes)
      ..writeByte(21)
      ..write(obj.deadline)
      ..writeByte(22)
      ..write(obj.referenceLinks);
  }
}
