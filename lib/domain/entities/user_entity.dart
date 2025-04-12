import 'base_entity.dart';

class UserEntity extends BaseEntity {
  final String email;
  final String name;
  final String? profilePicture;
  final String? bio;
  final bool isEmailVerified;
  final DateTime createdAt;

  const UserEntity({
    required String id,
    required this.email,
    required this.name,
    this.profilePicture,
    this.bio,
    required this.isEmailVerified,
    required this.createdAt,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    profilePicture,
    bio,
    isEmailVerified,
    createdAt,
  ];

  // Factory method to create from JSON
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profilePicture: json['profilePicture'],
      bio: json['bio'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  // Convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Copy with method for easy cloning with modifications
  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? profilePicture,
    String? bio,
    bool? isEmailVerified,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}