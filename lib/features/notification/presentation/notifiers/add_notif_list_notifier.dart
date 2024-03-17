import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';
import 'package:movie_colony/features/notification/domain/usecases/add_notif_list.dart';

class AddNotifListNotifier extends GenericStateNotifier<void> {
  AddNotifListNotifier(this.addNotifList);

  final AddNotificationList addNotifList;

  void addNotification(NotificationListModel model) {
    sendRequest(() async {
      return await addNotifList(Params(model: model));
    });
  }
}
