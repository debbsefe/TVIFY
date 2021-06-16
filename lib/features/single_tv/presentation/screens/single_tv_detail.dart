import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_detail/tv_detail_state.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../providers.dart';

class SingleTvDetail extends StatefulWidget {
  const SingleTvDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _SingleTvDetailState createState() => _SingleTvDetailState();
}

class _SingleTvDetailState extends State<SingleTvDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    context.read(tvDetailProvider.notifier).fetchTvDetail(widget.id);

    context.read(tvCastProvider.notifier).fetchTvCast(widget.id);
    context.read(similarTvProvider.notifier).fetchSimilarTv(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ImageAndDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageAndDetails extends ConsumerWidget {
  const ImageAndDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tvDetail = watch(tvDetailProvider);
    if (tvDetail is TvDetailLoaded) {
      return Column(
        children: [
          CachedImage(
            tvDetail.tvDetail.posterImage.imageUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
          ),
        ],
      );
    }
    return Container();
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
