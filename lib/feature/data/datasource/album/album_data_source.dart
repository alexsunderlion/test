import 'package:clubforce/config/app_config.dart';
import 'package:clubforce/core/api_client/api_client.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AlbumDataSource {
  Future<AlbumResponse> getTopAlbums(String artistId, {int page = 1});
}

@Injectable(as: AlbumDataSource)
class AlbumDataSourceImpl implements AlbumDataSource {
  final LastFMApiClient apiClient;
  final AppConfig appConfig;

  AlbumDataSourceImpl(this.appConfig, this.apiClient);

  @override
  Future<AlbumResponse> getTopAlbums(String artistId, {int page = 1}) async {
    final response = await apiClient.get(
      '/2.0',
      queryParameters: {
        'api_key': appConfig.apiKey,
        'method': 'artist.gettopalbums',
        'format': 'json',
        'artist': artistId,
        'page': page,
      },
    );
    if (response.statusCode == 200) {
      return AlbumResponse.fromJson(response.data['topalbums']);
    } else {
      throw DioException(requestOptions: RequestOptions(path: 'artist.gettopalbums'), response: response);
    }
  }
}
