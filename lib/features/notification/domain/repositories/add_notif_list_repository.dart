import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';

abstract class AddNotifListRepository {
  Future<Either<Failure, void>> addNotificationList(NotificationListModel list);
}
