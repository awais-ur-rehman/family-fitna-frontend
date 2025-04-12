import '../../core/network/api_client.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/pagination_entity.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationService {
  final ApiClient _apiClient;

  NotificationService(this._apiClient);

  Future<NotificationListResponse> getNotifications({int page = 1, int limit = 20}) async {
    final response = await _apiClient.get(
      '/api/notifications',
      queryParams: {'page': page, 'limit': limit},
    );
    final notifications = (response['data']['notifications'] as List)
        .map((notification) => NotificationEntity.fromJson(notification))
        .toList();
    final pagination = PaginationEntity.fromJson(response['data']['pagination']);
    final unreadCount = response['data']['unreadCount'];

    return NotificationListResponse(
      notifications: notifications,
      pagination: pagination,
      unreadCount: unreadCount,
    );
  }

  Future<void> markAsRead(String notificationId) async {
    await _apiClient.put('/api/notifications/$notificationId/read');
  }

  Future<void> markAllAsRead() async {
    await _apiClient.put('/api/notifications/read-all');
  }
}