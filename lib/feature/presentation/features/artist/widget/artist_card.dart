import 'package:cached_network_image/cached_network_image.dart';
import 'package:clubforce/core/injection/injection_container.dart';
import 'package:clubforce/core/route/app_router.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key? key, required this.artist}) : super(key: key);
  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        inject<AppRouter>().push(TopAlbumsRoute(artist: artist));
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WrappedRoute(child: TopAlbumsPage(artist: artist))));
      },
      leading: CachedNetworkImage(
        imageUrl:
            artist.image?.firstWhereOrNull((i) => i.size == 'medium')?.url ?? artist.image?.firstOrNull?.url ?? '',
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
        artist.name ?? '',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      subtitle: Text(
        '${artist.playCount} plays',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
