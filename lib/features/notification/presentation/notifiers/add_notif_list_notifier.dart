import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/notification/data/repositories/add_notif_list_repository.dart';

final addNotificationListNotifierProvider =
    StateNotifierProvider<AddNotifListNotifier, LoadingState>((ref) {
  return AddNotifListNotifier(ref.watch(addNotifListRepositoryProvider));
});

class AddNotifListNotifier extends StateNotifier<LoadingState> {
  AddNotifListNotifier(this.addNotifListRepository)
      : super(const LoadingState.idle());

  final AddNotifListRepository addNotifListRepository;
  final logger = Logger('AddNotifListNotifier');

  Future<void> addNotification(NotificationListModel model) async {
    try {
      state = const LoadingState.loading();
      await addNotifListRepository.addNotificationList(model);
      state = const LoadingState.success();
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
