import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_detail/tv_detail_state.dart';
import '../../../../providers.dart';

class TvSummary extends ConsumerWidget {
  const TvSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tvDetail = watch(tvDetailProvider);

    if (tvDetail is TvDetailLoaded) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plot Summary',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Height(10),
            Text(
              tvDetail.tvDetail.overview,
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12),
            ),
            const Height(15),
            Text(
              'Genres',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Height(15),
            Wrap(
              spacing: 10,
              runSpacing: 15,
              alignment: WrapAlignment.spaceBetween,
              children: tvDetail.tvDetail.categories.map((e) {
                return InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: CustomTheme.primaryTint5,
                        border: Border.all(
                          color: CustomTheme.primaryTint2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: CustomButton(
                onPressed: () {},
                name: 'Notify Me',
              ),
            )
          ],
        ),
      );
    }
    return Container();
  }
}
