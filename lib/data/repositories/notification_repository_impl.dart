import '../../domain/repositories/notification_repository.dart';
import '../../domain/entities/notification_entity.dart';
import '../services/notification_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl(this._notificationService);

  @override
  Future<NotificationListResponse> getNotifications({int page = 1, int limit = 20}) async {
    return await _notificationService.getNotifications(page: page, limit: limit);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _notificationService.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() async {
    await _notificationService.markAllAsRead();
  }
}