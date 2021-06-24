import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/notification_list_model.dart';

abstract class AddNotifListRepository {
  Future<Either<Failure, void>> addNotificationList(NotificationListModel list);
}
