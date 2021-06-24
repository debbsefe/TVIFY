import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/notification/data/models/notification_list_model.dart';
import 'package:movie_colony/features/notification/domain/repositories/add_notif_list_repository.dart';
import 'package:movie_colony/features/notification/domain/usecases/add_notif_list.dart';

class MockAddNotifListRepository extends Mock
    implements AddNotifListRepository {}

void main() {
  late MockAddNotifListRepository repository;
  late AddNotificationList usecase;
  setUp(() {
    repository = MockAddNotifListRepository();
    usecase = AddNotificationList(repository);
  });

  var tModel = NotificationListModel(
      id: 1, name: 'tv', rating: 8, date: 'date', posterImage: '');
  test(
    'verify addNotificationList was called',
    () async {
      // act
      await usecase(Params(model: tModel));
      // assert
      verify(repository.addNotificationList(tModel));
      verifyNoMoreInteractions(repository);
    },
  );
}
