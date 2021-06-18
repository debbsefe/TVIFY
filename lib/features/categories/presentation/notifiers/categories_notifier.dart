import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_categories.dart';

class CategoriesNotifier extends GenericStateNotifier<List<Categories>> {
  CategoriesNotifier(this.allCategories);

  final GetAllCategories allCategories;

  void fetchCategory() {
    sendRequest(() async {
      return await allCategories(NoParams());
    });
  }
}
