import 'package:auto_route/auto_route.dart';
import 'package:clubforce/feature/presentation/features/album/pages/top_albums_page.dart';
import 'package:clubforce/feature/presentation/features/artist/pages/artist_page.dart';

export 'app_router.gr.dart';

@AdaptiveAutoRouter(routes: [
  MaterialRoute<void>(page: ArtistPage, initial: true),
  MaterialRoute<void>(page: TopAlbumsPage),
], replaceInRouteName: 'Page,Route')
class $AppRouter {}
