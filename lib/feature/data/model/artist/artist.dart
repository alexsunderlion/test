import 'package:clubforce/core/util/helper.dart';
import 'package:clubforce/feature/data/model/general/attr.dart';
import 'package:clubforce/feature/data/model/general/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';

part 'artist.g.dart';

@freezed
class ArtistResponse with _$ArtistResponse {
  const factory ArtistResponse({
    @Default(<Artist>[]) List<Artist> artist,
    @JsonKey(name: '@attr') ResponseAttr? attr,
  }) = _ArtistResponse;

  factory ArtistResponse.fromJson(Map<String, dynamic> json) => _$ArtistResponseFromJson(json);
}

@freezed
class Artist with _$Artist {
  factory Artist({
    String? name,
    String? url,
    String? mbid,
    @JsonKey(name: 'playcount', fromJson: Helper.toInt) int? playCount,
    @JsonKey(name: 'tagcount', fromJson: Helper.toInt) int? tagCount,
    @JsonKey(fromJson: Helper.toInt) int? streamable,
    List<RemoteImage>? image,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
