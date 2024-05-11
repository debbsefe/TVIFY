import 'package:flutter/material.dart';
import 'package:tvify/core/core.dart';
import 'package:tvify/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:tvify/features/single_tv/presentation/notifiers/tv_cast/tv_cast_notifier.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: castList.map((cast) {
              return Container(
                margin: const EdgeInsets.only(left: 8),
                width: 100,
                child: Column(
                  children: [
                    if (cast.profilePath != null)
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: CustomTheme.primaryColor300,
                        backgroundImage: NetworkImage(
                          url + cast.profilePath!,
                        ),
                      )
                    else
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: CustomTheme.primaryColor300,
                      ),
                    Text(
                      cast.name ?? '',
                      textAlign: TextAlign.center,
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
