import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/widgets/dialogs.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/header_image.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/similar_tv_shows_widget.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/top_cast.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/tv_summary.dart';
import 'package:movie_colony/providers.dart';

class SingleTvDetail extends ConsumerStatefulWidget {
  const SingleTvDetail({@PathParam('id') required this.id, super.key});
  final String id;

  @override
  ConsumerState<SingleTvDetail> createState() => _SingleTvDetailState();
}

class _SingleTvDetailState extends ConsumerState<SingleTvDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    ref.read(tvDetailProvider.notifier).fetchTvDetail(widget.id);

    ref.read(tvCastProvider.notifier).fetchTvCast(widget.id);
    ref.read(similarTvProvider.notifier).fetchSimilarTv(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addNotificationListProvider, (previous, next) {
      if (next is Error<void>) {
        messageDialog(
          context: context,
          onPressed: () {
            context.router.root.pop();
          },
          content: next.message,
        );
      } else if (next is Loaded<void>) {
        messageDialog(
          context: context,
          onPressed: () {
            context.router.root.pop();
          },
          content: 'Notification added',
        );
      }
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
