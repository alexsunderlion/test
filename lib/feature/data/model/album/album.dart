import 'package:clubforce/core/util/helper.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:clubforce/feature/data/model/general/attr.dart';
import 'package:clubforce/feature/data/model/general/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';

part 'album.g.dart';

@freezed
class AlbumResponse with _$AlbumResponse {
  const factory AlbumResponse({
    @Default(<Album>[]) List<Album> album,
    @JsonKey(name: '@attr') ResponseAttr? attr,
  }) = _AlbumResponse;

  factory AlbumResponse.fromJson(Map<String, dynamic> json) => _$AlbumResponseFromJson(json);
}

@freezed
class Album with _$Album {
  const factory Album({
    String? name,
    String? url,
    String? mbid,
    @JsonKey(name: 'playcount', fromJson: Helper.toInt) int? playCount,
    Artist? artist,
    List<RemoteImage>? image,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
