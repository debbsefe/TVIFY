import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/components/dialogs.dart';
import 'package:movie_colony/features/homescreen/presentation/widgets/title_and_summary.dart';
import 'package:movie_colony/features/notification/presentation/notifiers/notification_list_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/similar_tv/similar_tv_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/header_image.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/top_cast.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/tv_summary.dart';

@RoutePage()
class SingleTvDetailPage extends ConsumerWidget {
  const SingleTvDetailPage({@PathParam('id') required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(notificationListNotifierProvider, (previous, next) {
      next.mapOrNull(
        error: (error) {
          messageDialog(
            context: context,
            onPressed: () {
              context.router.root.maybePop();
            },
            content: error.error.toString(),
          );
        },
        success: (success) {
          messageDialog(
            context: context,
            onPressed: () {
              context.router.root.maybePop();
            },
            content: 'Notification added',
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderImage(tvId: id),
              TvSummary(tvId: id),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 10,
                ),
                child: Text(
                  'Top Cast ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              TopCast(tvId: id),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 10,
                ),
                child: Text(
                  'TV Shows like this',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              TvCard(
                state: ref.watch(similarTvNotifierProvider(id)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
