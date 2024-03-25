import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/notification/data/repositories/add_notif_list_repository.dart';

final addNotificationListNotifierProvider =
    StateNotifierProvider<AddNotifListNotifier, GenericState<void>>((ref) {
  return AddNotifListNotifier(ref.watch(addNotifListRepositoryProvider));
});

class AddNotifListNotifier extends GenericStateNotifier<void> {
  AddNotifListNotifier(this.addNotifListRepository);

  final AddNotifListRepository addNotifListRepository;

  void addNotification(NotificationListModel model) {
    sendRequest(() async {
      return addNotifListRepository.addNotificationList(model);
    });
  }
}
