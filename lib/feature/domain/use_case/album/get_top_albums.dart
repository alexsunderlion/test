import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/core/use_case/use_case.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:clubforce/feature/domain/repository/album/album_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

abstract class GetTopAlbums implements UseCase<AlbumResponse, ParamsGetTopAlbums> {}

@Injectable(as: GetTopAlbums)
class GetTopAlbumsImpl implements GetTopAlbums {
  final AlbumRepository newsRepository;

  GetTopAlbumsImpl(this.newsRepository);

  @override
  Future<Either<Failure, AlbumResponse>> call(params) {
    return newsRepository.getTopAlbums(artistId: params.artistId, page: params.page);
  }
}

class ParamsGetTopAlbums extends Equatable {
  final String artistId;
  final int page;

  const ParamsGetTopAlbums({required this.artistId, this.page = 1});

  @override
  List<Object?> get props => [artistId, page];
}
