import 'package:flutter/material.dart';
import 'package:tvify/core/utils/size_ext.dart';

class TvLargeCard extends StatelessWidget {
  const TvLargeCard({
    required this.url,
    required this.posterPath,
    required this.tvName,
    super.key,
  });

  final String url;
  final String? posterPath;
  final String? tvName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            '$url$posterPath',
            fit: BoxFit.cover,
            width: 160,
          ),
        ),
        const Height(8),
        Text(
          tvName ?? '',
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
