import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_cast/tv_cast_notifier.dart';

class TopCast extends ConsumerWidget {
  const TopCast({required this.tvId, super.key});
  final String tvId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchProfileSizeUrl();

    final tvCast = ref.watch(tvCastNotifierProvider(tvId));

    return tvCast.when(
      idle: Container.new,
      loading: Container.new,
      error: (message) {
        return Center(
          child: Text(
            message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
      success: (success) {
        final value = success! as TvCastModel;
        final castList = value.cast ?? [];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: castList.map((cast) {
              return Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: CustomTheme.primaryColor300,
                      backgroundImage: NetworkImage(
                        url + cast.profilePath!,
                      ),
                    ),
                    Text(
                      cast.name ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
