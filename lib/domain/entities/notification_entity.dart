import 'base_entity.dart';
import 'user_entity.dart';

class NotificationEntity extends BaseEntity {
  final String type;
  final String message;
  final UserEntity? sender;
  final String? targetId;
  final bool isRead;
  final DateTime createdAt;

  const NotificationEntity({
    required String id,
    required this.type,
    required this.message,
    this.sender,
    this.targetId,
    required this.isRead,
    required this.createdAt,
  }) : super(id);

  @override
  List<Object?> get props => [
    id,
    type,
    message,
    sender,
    targetId,
    isRead,
    createdAt,
  ];

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] ?? json['_id'] ?? '',
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      sender: json['sender'] is Map
          ? UserEntity.fromJson(json['sender'])
          : null,
      targetId: json['targetId'],
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'message': message,
      'sender': sender?.toJson(),
      'targetId': targetId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Future<void> copyWith({required bool isRead}) async {}
}