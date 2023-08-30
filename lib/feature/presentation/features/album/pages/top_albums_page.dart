import 'package:auto_route/auto_route.dart';
import 'package:clubforce/core/injection/injection_container.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:clubforce/feature/data/model/artist/artist.dart';
import 'package:clubforce/feature/presentation/features/album/bloc/top_albums_bloc.dart';
import 'package:clubforce/feature/presentation/features/album/widget/album_card.dart';
import 'package:clubforce/feature/presentation/features/album/widget/artist_details_header.dart';
import 'package:clubforce/feature/presentation/widgets/network_error_widget.dart';
import 'package:clubforce/feature/presentation/widgets/server_error_widget.dart';
import 'package:clubforce/feature/presentation/widgets/support_error_widget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopAlbumsPage extends StatefulWidget implements AutoRouteWrapper {
  final Artist artist;

  const TopAlbumsPage({Key? key, required this.artist}) : super(key: key);

  @override
  State<TopAlbumsPage> createState() => _TopAlbumsPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<TopAlbumBloc>()..add(TopAlbumLoadEvent(artist.name ?? '')),
      child: this,
    );
  }
}

class _TopAlbumsPageState extends State<TopAlbumsPage> {
  final GlobalKey<ExtendedNestedScrollViewState> listKey = GlobalKey();

  ScrollController get _innerController {
    return listKey.currentState!.innerController;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //triggers when scrolling reached to bottom
      _innerController.addListener(() {
        if (_innerController.position.pixels >=
            _innerController.position.maxScrollExtent - Thresholds.pagination + 56) {
          BlocProvider.of<TopAlbumBloc>(context).add(const TopAlbumLoadMoreEvent());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExtendedNestedScrollView(
          key: listKey,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: AppColors.black,
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  titlePadding: const EdgeInsets.symmetric(horizontal: 22),
                  title: ArtistDetailsHeader(artist: widget.artist, maxHeight: 240, minHeight: 76),
                ),
                collapsedHeight: 76,
                expandedHeight: 240,
                pinned: true,
              )
            ];
          },
          body: BlocBuilder<TopAlbumBloc, TopAlbumState>(
            builder: (context, state) {
              return state.when(loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, loaded: (albums, hasMore) {
                return ListView.builder(
                    itemCount: albums.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == albums.length) {
                        return const Center(
                          child: SizedBox(
                            height: 56,
                            width: 56,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return AlbumCard(album: albums[index]);
                    });
              }, error: (error) {
                return const SupportErrorWidget();
              }, serverFailure: (error) {
                return ServerErrorWidget(
                  message: error,
                  onRetry: () {
                    BlocProvider.of<TopAlbumBloc>(context)
                        .add(TopAlbumLoadEvent(widget.artist.mbid ?? widget.artist.name ?? ''));
                  },
                );
              }, noInternet: () {
                return NetworkErrorWidget(
                  onRetry: () {
                    BlocProvider.of<TopAlbumBloc>(context)
                        .add(TopAlbumLoadEvent(widget.artist.mbid ?? widget.artist.name ?? ''));
                  },
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
