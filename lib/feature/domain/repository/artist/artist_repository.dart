import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:dartz/dartz.dart';

abstract class ArtistRepository {
  Future<Either<Failure, ArtistResponse>> getAllArtists({int page = 1});
}
