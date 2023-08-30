import 'package:clubforce/core/util/helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attr.freezed.dart';

part 'attr.g.dart';

@freezed
class ResponseAttr with _$ResponseAttr {
  const factory ResponseAttr({
    @JsonKey(fromJson: Helper.toInt) int? page,
    @JsonKey(fromJson: Helper.toInt) int? totalPages,
  }) = _ResponseAttr;

  factory ResponseAttr.fromJson(Map<String, dynamic> json) => _$ResponseAttrFromJson(json);
}
