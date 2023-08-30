import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ArtistDetailsHeader extends StatelessWidget {
  const ArtistDetailsHeader({
    Key? key,
    required this.artist,
    required this.minHeight,
    required this.maxHeight,
  }) : super(key: key);
  final Artist artist;
  final double minHeight;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.biggest.height;
      final double offset = ((height - minHeight) / (maxHeight - minHeight)).clamp(0, 1);
      final imageHeight = (offset * 45 + 20) * 2 - offset * 40;
      final double radius = (1 - offset) * imageHeight / 2;
      final double left = (1 - offset) * 100;
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: (1 - offset) * 50),
            alignment: Alignment((offset - 1) * pow(3, offset), offset * -0.5),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: artist.image?.firstWhereOrNull((i) => i.size == 'extralarge')?.url ??
                    artist.image?.firstOrNull?.url ??
                    '',
                width: imageHeight,
                height: imageHeight,
                errorWidget: (context, _, __) {
                  return Icon(
                    Icons.image,
                    size: imageHeight,
                  );
                },
                placeholder: (context, _) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    width: 56,
                    height: 56,
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: left, top: 8),
            child: Align(
              alignment: Alignment(offset - 1, offset * 0.8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment(offset - 1, offset * 0.8),
                    child: Text(
                      artist.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4 + 4 * offset),
                  Align(
                    alignment: Alignment(offset - 1, offset * 0.8),
                    child: Text(
                      '${artist.playCount} Plays',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12 + 2 * offset,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${artist.streamable} Steamable',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(offset),
                      fontWeight: FontWeight.w600,
                      fontSize: 12 * offset,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${artist.tagCount} Tags',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(offset),
                      fontWeight: FontWeight.w600,
                      fontSize: 12 * offset,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
