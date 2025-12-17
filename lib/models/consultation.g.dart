// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsultationAdapter extends TypeAdapter<Consultation> {
  @override
  final int typeId = 1;

  @override
  Consultation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Consultation(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      symptoms: (fields[2] as List).cast<String>(),
      remedy: fields[3] as String,
      messages: (fields[4] as List).cast<ChatMessage>(),
      consultationSummary: fields[5] as String,
      severity: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Consultation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.symptoms)
      ..writeByte(3)
      ..write(obj.remedy)
      ..writeByte(4)
      ..write(obj.messages)
      ..writeByte(5)
      ..write(obj.consultationSummary)
      ..writeByte(6)
      ..write(obj.severity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsultationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
