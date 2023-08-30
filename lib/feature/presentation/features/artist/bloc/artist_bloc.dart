import 'package:clubforce/core/error/failure.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:clubforce/feature/domain/use_case/artist/get_artists.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'artist_bloc.freezed.dart';

@injectable
class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc(this.getArtistsUseCase) : super(const ArtistState.loading()) {
    on<ArtistLoadEvent>((event, emit) async {
      emit(const ArtistState.loading());
      final response = await getArtistsUseCase.call(const ParamsGetAllArtists());
      response.fold((l) {
        if (l is ConnectionFailure) {
          emit(const ArtistState.noInternet());
        } else if (l is ServerFailure) {
          emit(ArtistState.serverFailure(l.errorMessage));
        } else if (l is FatalFailure) {
          emit(ArtistState.error(l.errorMessage));
        } else {
          emit(ArtistState.error(l.toString()));
        }
      }, (r) {
        _page = r.attr?.page ?? 1;
        _totalPage = r.attr?.totalPages ?? 1;
        emit(ArtistState.loaded(r.artist.toList(), _page < _totalPage));
      });
    });
    on<ArtistLoadMoreEvent>((event, emit) async {
      if (!_loadingMore && _page < _totalPage) {
        await state.maybeWhen(
            orElse: () {},
            loaded: (artist, hasMore) async {
              _loadingMore = true;
              final response = await getArtistsUseCase(ParamsGetAllArtists(page: _page + 1));
              response.fold((l) {}, (r) {
                _page = r.attr?.page ?? 1;
                _totalPage = r.attr?.totalPages ?? 1;
                emit(ArtistState.loaded([...artist, ...r.artist], _page < _totalPage));
              });
              _loadingMore = false;
            });
      }
    });
    print('ArtistBloc constructor created');
  }

  final GetAllArtists getArtistsUseCase;
  int _page = 0;
  int _totalPage = 1;
  bool _loadingMore = false;
}

abstract class ArtistEvent {
  const ArtistEvent();
}

class ArtistLoadEvent extends ArtistEvent {
  const ArtistLoadEvent();
}

class ArtistLoadMoreEvent extends ArtistEvent {
  const ArtistLoadMoreEvent();
}

@freezed
class ArtistState with _$ArtistState {
  const factory ArtistState.loading() = _Loading;

  const factory ArtistState.loaded(List<Artist> artists, bool hasMore) = _Loaded;

  const factory ArtistState.error(String message) = _Error;

  const factory ArtistState.serverFailure(String message) = _ServerFailure;

  const factory ArtistState.noInternet() = _NoInternet;
}
