import 'package:auto_route/auto_route.dart';
import 'package:clubforce/core/injection/injection_container.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:clubforce/feature/domain/use_case/artist/get_artists.dart';
import 'package:clubforce/feature/presentation/features/artist//bloc/artist_bloc.dart';
import 'package:clubforce/feature/presentation/features/artist/widget/artist_card.dart';
import 'package:clubforce/feature/presentation/widgets/network_error_widget.dart';
import 'package:clubforce/feature/presentation/widgets/server_error_widget.dart';
import 'package:clubforce/feature/presentation/widgets/support_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistPage extends StatefulWidget implements AutoRouteWrapper {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ArtistBloc(inject<GetAllArtists>())..add(const ArtistLoadEvent());
      },
      child: this,
    );
  }
}

class _ArtistPageState extends State<ArtistPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    //triggers when scrolling reached to bottom
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent - Thresholds.pagination + 56) {
        BlocProvider.of<ArtistBloc>(context).add(const ArtistLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Artists',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            return state.when(loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, loaded: (artists, hasMore) {
              return ListView.builder(
                itemCount: artists.length + (hasMore ? 1 : 0),
                controller: controller,
                itemBuilder: (context, index) {
                  if (index == artists.length) {
                    return const Center(
                      child: SizedBox(
                        height: 56,
                        width: 56,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return ArtistCard(artist: artists[index]);
                },
              );
            }, error: (error) {
              return const SupportErrorWidget();
            }, serverFailure: (error) {
              return ServerErrorWidget(
                message: error,
                onRetry: () {
                  BlocProvider.of<ArtistBloc>(context).add(const ArtistLoadEvent());
                },
              );
            }, noInternet: () {
              return NetworkErrorWidget(
                onRetry: () {
                  BlocProvider.of<ArtistBloc>(context).add(const ArtistLoadEvent());
                },
              );
            });
          },
        ),
      ),
    );
  }
}
