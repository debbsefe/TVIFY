import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/notification/data/datasources/notification_list_remote_data_source.dart';

final notificationListNotifierProvider =
    StateNotifierProvider<NotificationListNotifier, LoadingState>((ref) {
  return NotificationListNotifier(
    ref.watch(notificationListRemoteDataSourceProvider),
  );
});

class NotificationListNotifier extends StateNotifier<LoadingState> {
  NotificationListNotifier(this.datasource) : super(const LoadingState.idle());

  final NotificationListRemoteDataSource datasource;
  final logger = Logger('AddNotifListNotifier');

  Future<void> addNotification(NotificationListModel model) async {
    try {
      state = const LoadingState.loading();
      await datasource.addNotification(model);
      state = const LoadingState.success();
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }

  Future<void> removeNotification(NotificationListModel model) async {
    try {
      state = const LoadingState.loading();
      await datasource.removeNotification(model);
      state = const LoadingState.success();
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
