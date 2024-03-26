import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/widgets/dialogs.dart';
import 'package:movie_colony/features/notification/presentation/notifiers/add_notif_list_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/similar_tv/similar_tv_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_cast/tv_cast_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_detail/tv_detail_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/header_image.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/similar_tv_shows_widget.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/top_cast.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/tv_summary.dart';

@RoutePage()
class SingleTvDetailPage extends ConsumerStatefulWidget {
  const SingleTvDetailPage({@PathParam('id') required this.id, super.key});
  final String id;

  @override
  ConsumerState<SingleTvDetailPage> createState() => _SingleTvDetailPageState();
}

class _SingleTvDetailPageState extends ConsumerState<SingleTvDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    ref.read(tvDetailNotifierProvider.notifier).fetchTvDetail(widget.id);

    ref.read(tvCastNotifierProvider.notifier).fetchTvCast(widget.id);
    ref.read(similarTvNotifierProvider.notifier).fetchSimilarTv(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addNotificationListNotifierProvider, (previous, next) {
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
              const HeaderImage(),
              const TvSummary(),
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
              const SizedBox(height: 100, child: TopCast()),
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
              const SizedBox(height: 300, child: SimilarTvShowsWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
