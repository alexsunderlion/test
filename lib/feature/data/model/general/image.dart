import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';

part 'image.g.dart';

@freezed
class RemoteImage with _$RemoteImage {
  const factory RemoteImage({
    String? size,
    @JsonKey(name: '#text') String? url,
  }) = _RemoteImage;

  factory RemoteImage.fromJson(Map<String, dynamic> json) => _$RemoteImageFromJson(json);
}
