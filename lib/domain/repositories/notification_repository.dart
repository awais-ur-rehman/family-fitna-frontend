import '../entities/notification_entity.dart';
import '../entities/pagination_entity.dart';

class NotificationListResponse {
  final List<NotificationEntity> notifications;
  final PaginationEntity pagination;
  final int unreadCount;

  NotificationListResponse({
    required this.notifications,
    required this.pagination,
    required this.unreadCount,
  });
}

abstract class NotificationRepository {
  Future<NotificationListResponse> getNotifications({int page = 1, int limit = 20});
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
}