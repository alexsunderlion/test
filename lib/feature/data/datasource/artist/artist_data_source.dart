import 'package:clubforce/config/app_config.dart';
import 'package:clubforce/core/api_client/api_client.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ArtistDataSource {
  Future<ArtistResponse> getAllArtists({int page = 1});
}

@Injectable(as: ArtistDataSource)
class ArtistDataSourceImpl implements ArtistDataSource {
  final LastFMApiClient apiClient;
  final AppConfig appConfig;

  ArtistDataSourceImpl(this.appConfig, this.apiClient);

  @override
  Future<ArtistResponse> getAllArtists({int page = 1}) async {
    final response = await apiClient.get(
      '/2.0',
      queryParameters: {
        'api_key': appConfig.apiKey,
        'method': 'library.getartists',
        'user': 'joanofarctan',
        'format': 'json',
        'page': page,
      },
    );
    if (response.statusCode == 200) {
      return ArtistResponse.fromJson(response.data['artists']);
    } else {
      throw DioException(requestOptions: RequestOptions(path: 'library.getartists'), response: response);
    }
  }
}
