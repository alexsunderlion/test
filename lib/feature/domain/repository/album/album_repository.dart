import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:dartz/dartz.dart';

abstract class AlbumRepository {
  Future<Either<Failure, AlbumResponse>> getTopAlbums({required String artistId, int page = 1});
}
