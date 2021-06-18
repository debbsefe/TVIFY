import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';
import '../../../single_tv/presentation/screens/single_tv_detail.dart';

class TrendingWidget extends ConsumerWidget {
  const TrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(dailyTrendingProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return trending.when(
        initial: () => Container(),
        loading: () => Container(),
        error: (e) => Text(e.toString()),
        loaded: (trend) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10),
              itemCount: trend!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var singleTrend = trend[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SingleTvDetail(
                              id: singleTrend.id.toString(),
                            ),
                          );
                        },
                        child: CachedImage(
                          url + singleTrend.posterImage,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      Text(
                        singleTrend.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        yearFromDateString(singleTrend.date),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: CustomTheme.greyColor3),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 13,
                            color: CustomTheme.yellowStar,
                          ),
                          Text(
                            singleTrend.rating.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
