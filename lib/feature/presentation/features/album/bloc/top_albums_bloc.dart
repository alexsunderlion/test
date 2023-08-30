import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/feature/data/model/album/album.dart';
import 'package:clubforce/feature/domain/use_case/album/get_top_albums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'top_albums_bloc.freezed.dart';

@injectable
class TopAlbumBloc extends Bloc<TopAlbumEvent, TopAlbumState> {
  TopAlbumBloc(this.getTopAlbumsUseCase) : super(const TopAlbumState.loading()) {
    on<TopAlbumLoadEvent>((event, emit) async {
      emit(const TopAlbumState.loading());
      _artist = event.artistId;
      final response = await getTopAlbumsUseCase.call((ParamsGetTopAlbums(artistId: event.artistId)));
      response.fold((l) {
        if (l is ConnectionFailure) {
          emit(const TopAlbumState.noInternet());
        } else if (l is ServerFailure) {
          emit(TopAlbumState.serverFailure(l.errorMessage));
        } else if (l is FatalFailure) {
          emit(TopAlbumState.error(l.errorMessage));
        } else {
          emit(TopAlbumState.error(l.toString()));
        }
      }, (r) {
        _page = r.attr?.page ?? 1;
        _totalPage = r.attr?.totalPages ?? 1;
        emit(TopAlbumState.loaded(r.album.toList(), _page < _totalPage));
      });
    });
    on<TopAlbumLoadMoreEvent>((event, emit) async {
      if (!_loadingMore && _page < _totalPage) {
        await state.maybeWhen(
            orElse: () {},
            loaded: (albums, hasMore) async {
              _loadingMore = true;
              final response = await getTopAlbumsUseCase((ParamsGetTopAlbums(artistId: _artist, page: _page + 1)));
              response.fold((l) {}, (r) {
                _page = r.attr?.page ?? 1;
                _totalPage = r.attr?.totalPages ?? 1;
                emit(TopAlbumState.loaded([...albums, ...r.album], _page < _totalPage));
              });
              _loadingMore = false;
            });
      }
    });
  }

  final GetTopAlbums getTopAlbumsUseCase;
  String _artist = '';
  int _page = 0;
  int _totalPage = 1;
  bool _loadingMore = false;
}

abstract class TopAlbumEvent {
  const TopAlbumEvent();
}

class TopAlbumLoadEvent extends TopAlbumEvent {
  const TopAlbumLoadEvent(this.artistId);

  final String artistId;
}

class TopAlbumLoadMoreEvent extends TopAlbumEvent {
  const TopAlbumLoadMoreEvent();
}

@freezed
class TopAlbumState with _$TopAlbumState {
  const factory TopAlbumState.loading() = _Loading;

  const factory TopAlbumState.loaded(List<Album> albums, bool hasMore) = _Loaded;

  const factory TopAlbumState.error(String message) = _Error;

  const factory TopAlbumState.serverFailure(String message) = _ServerFailure;

  const factory TopAlbumState.noInternet() = _NoInternet;
}
