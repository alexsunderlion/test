import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/core/network/network_info.dart';
import 'package:clubforce/feature/data/datasource/album/album_data_source.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:clubforce/feature/domain/repository/album/album_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AlbumRepository)
class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumDataSource newsDataSource;
  final NetworkInfo networkInfo;

  AlbumRepositoryImpl(this.newsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, AlbumResponse>> getTopAlbums({required String artistId, int page = 1}) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await newsDataSource.getTopAlbums(artistId, page: page);
        return Right(response);
      } on DioException catch (error) {
        return Left(ServerFailure(error.message ?? '', error: error));
      } catch (error) {
        return Left(FatalFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
