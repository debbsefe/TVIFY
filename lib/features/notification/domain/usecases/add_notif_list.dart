import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';
import 'package:movie_colony/features/notification/domain/repositories/add_notif_list_repository.dart';

class AddNotificationList extends UseCase<void, Params> {
  AddNotificationList(this.repository);

  final AddNotifListRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addNotificationList(params.model);
  }
}

class Params extends Equatable {
  const Params({required this.model});

  final NotificationListModel model;

  @override
  List<Object> get props => [model];
}
