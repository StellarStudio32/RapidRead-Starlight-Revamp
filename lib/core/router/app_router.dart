import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rapid_read_v2/presentation/screens/library_screen.dart';
import 'package:rapid_read_v2/presentation/screens/rsvp_screen.dart';

/// Centralizes the application's routing logic using go_router.
/// This approach keeps routing configuration separate from UI widgets,
/// making navigation easier to manage and test. It provides features like
/// deep-linking and named routes out of the box.
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LibraryScreen(key: Key('libraryScreen'));
        },
        routes: <GoRoute>[
          GoRoute(
            path: 'rsvp',
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, String> extra =
                  state.extra as Map<String, String>;
              return RsvpScreen(
                text: extra['text'] ?? '',
                wpm: int.tryParse(extra['wpm'] ?? '300') ?? 300,
                docId: int.tryParse(extra['docId'] ?? '0') ?? 0,
                initialIndex: int.tryParse(extra['initialIndex'] ?? '0') ?? 0,
              );
            },
          ),
        ],
      ),
    ],
  );
}
