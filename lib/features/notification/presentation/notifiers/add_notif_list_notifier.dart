import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';
import 'package:movie_colony/features/notification/domain/usecases/add_notif_list.dart';

final addNotificationListNotifierProvider =
    StateNotifierProvider<AddNotifListNotifier, GenericState<void>>((ref) {
  return AddNotifListNotifier(ref.watch(addNotificationListProvider));
});

class AddNotifListNotifier extends GenericStateNotifier<void> {
  AddNotifListNotifier(this.addNotifList);

  final AddNotificationList addNotifList;

  void addNotification(NotificationListModel model) {
    sendRequest(() async {
      return addNotifList(Params(model: model));
    });
  }
}
