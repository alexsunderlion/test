import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/core/use_case/use_case.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:clubforce/feature/domain/repository/artist/artist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

abstract class GetAllArtists implements UseCase<ArtistResponse, ParamsGetAllArtists> {}

@Injectable(as: GetAllArtists)
class GetAllArtistsImpl implements GetAllArtists {
  final ArtistRepository artistRepository;

  GetAllArtistsImpl(this.artistRepository);

  @override
  Future<Either<Failure, ArtistResponse>> call(params) {
    return artistRepository.getAllArtists(page: params.page);
  }
}

class ParamsGetAllArtists extends Equatable {
  final int page;

  const ParamsGetAllArtists({this.page = 1});

  @override
  List<Object?> get props => [page];
}
