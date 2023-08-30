import 'package:cached_network_image/cached_network_image.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.album}) : super(key: key);
  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (album.url != null) {
          launchUrlString(album.url!);
        }
      },
      leading: CachedNetworkImage(
        imageUrl: album.image?.firstWhereOrNull((i) => i.size == 'small')?.url ?? album.image?.firstOrNull?.url ?? '',
        width: 56,
        height: 56,
        errorWidget: (context, _, __) {
          return const Icon(
            Icons.image,
            size: 56,
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
      title: Text(
        album.name ?? '',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      subtitle: Text(
        '${album.playCount} Plays',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
