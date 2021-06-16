import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/date_parser.dart';
import '../../../../core/utils/size_ext.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';
import '../notifiers/tv_detail/tv_detail_state.dart';

class HeaderImage extends ConsumerWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tvDetail = watch(tvDetailProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    if (tvDetail is TvDetailLoaded) {
      return Column(
        children: [
          CachedImage(
            url + tvDetail.tvDetail.posterImage,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvDetail.tvDetail.name,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          yearFromDateString(tvDetail.tvDetail.startDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: CustomTheme.greyColor3),
                        ),
                        const Width(10),
                        Text(
                          fetchSeason(
                            tvDetail.tvDetail.seasons,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: CustomTheme.greyColor3),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: CustomTheme.yellowStar,
                        ),
                        const Width(5),
                        Text(
                          tvDetail.tvDetail.rating.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: CustomTheme.primaryTint4,
            thickness: 0.75,
          )
        ],
      );
    }
    return Container();
  }
}

String fetchSeason(int value) {
  return value > 1 ? '$value Seasons' : '$value Season';
}
