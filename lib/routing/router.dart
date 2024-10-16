import 'package:calm/pages/edit_page.dart';
import 'package:calm/entity/event.dart';
import 'package:calm/pages/month_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MonthPage(),
        routes: [
          GoRoute(
            path: '/edit',
            builder: (context, state) => EditPage(
              event: state.extra == null ? null : state.extra as Event,
            ),
          ),
        ],
      ),
    ],
  );
}
