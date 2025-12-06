// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 0;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel(
      gender: fields[0] as Gender?,
      activityLevel: fields[1] as ActivityLevel?,
      age: fields[2] as int?,
      heightCm: fields[3] as int?,
      weightKg: fields[4] as double?,
      targetWeightKg: fields[5] as double?,
      dietType: fields[6] as String?,
      allergies: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.activityLevel)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.heightCm)
      ..writeByte(4)
      ..write(obj.weightKg)
      ..writeByte(5)
      ..write(obj.targetWeightKg)
      ..writeByte(6)
      ..write(obj.dietType)
      ..writeByte(7)
      ..write(obj.allergies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
