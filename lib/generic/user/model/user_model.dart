import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  final int id;
  final String username;
  final DateTime createdAt;
  final bool isAdmin;
  final DateTime lastLoggedIn;
  final String profilePicture;
  final int karma;
  final String supabaseUid;
  final String instagram;

  const UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.isAdmin,
    required this.lastLoggedIn,
    required this.profilePicture,
    required this.karma,
    required this.supabaseUid,
    required this.instagram,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
        lastLoggedIn,
        profilePicture,
        createdAt,
      ];
}
