import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/core/network/network_info.dart';
import 'package:clubforce/feature/data/datasource/artist/artist_data_source.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:clubforce/feature/domain/repository/artist/artist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ArtistRepository)
class ArtistRepositoryImpl implements ArtistRepository {
  final ArtistDataSource newsDataSource;
  final NetworkInfo networkInfo;

  ArtistRepositoryImpl(this.newsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ArtistResponse>> getAllArtists({int page = 1}) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await newsDataSource.getAllArtists(page: page);
        return Right(response);
      } on DioException catch (error) {
        return Left(ServerFailure(error.message ?? '', error: error));
      } on TypeError catch (error) {
        return Left(FatalFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
