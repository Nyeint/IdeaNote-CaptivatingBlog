import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/features/auth/presentation/screens/forgot_password.dart';
import 'package:idea_notes/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/account_screen.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/add_blog.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/blog_detail.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/blogger/blogger_account.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/edit_blog.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/settings/change_name.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/settings/change_settings.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/dashboard.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/root_screen.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/settings/language_change.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/settings/theme_change.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/view_blog.dart';
import 'package:idea_notes/src/route/route_names.dart';
import 'package:idea_notes/src/route/route_paths.dart';
import '../features/auth/presentation/screens/login_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final globalContext =
    MyRouter.routerConfig.routerDelegate.navigatorKey.currentContext;
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MyRouter extends Route {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: '/root',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(child: Dashboard(child: child));
          },
          routes: [
            GoRoute(
                path: RoutePaths.viewBlog,
                name: RouteNames.viewBlog,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (context, state) =>  const NoTransitionPage(child: ViewBlog())),
            GoRoute(
              path: RoutePaths.account,
              name: RouteNames.account,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>  const NoTransitionPage(child: AccountScreen()),
            ),
          ]),
      GoRoute(
          path: '/root',
          name: 'root',
          builder: (context, state) => const RootScreen()),
      GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LogInScreen(),
          routes: [
            GoRoute(
                path: RoutePaths.signup,
                name: RouteNames.signup,
                builder: (context, state) => const SignUpScreen()),
            GoRoute(
                path: RoutePaths.forgotPassword,
                name: RouteNames.forgotPassword,
                builder: (context, state) => ForgotPasswordScreen()),
          ]),
      GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) => const ChangeSettings(),
          routes: [
            GoRoute(
                path: RoutePaths.userName,
                name: RouteNames.userName,
                builder: (context, state) => const ChangeAccountNameView()),
            GoRoute(
                path: RoutePaths.language,
                name: RouteNames.language,
                builder: (context, state) => const LanguageChangeView()),
            GoRoute(
                path: RoutePaths.theme,
                name: RouteNames.theme,
                builder: (context, state) => const ThemeChangeView()),
          ]),
      GoRoute(
          path: RoutePaths.addBlog,
          name: RouteNames.addBlog,
          builder: (context, state) => const AddBlogView()),
      GoRoute(
          path: RoutePaths.blogDetail,
          name: RouteNames.blogDetail,
          builder: (context, state) =>
              BlogDetailView(
                blog: state.extra as Blog,
              )
          ),
      GoRoute(
          path: RoutePaths.editBlog,
          name: RouteNames.editBlog,
          builder: (context, state) => EditBlogView(blog: state.extra as Blog,)),
      GoRoute(
          path: '/${RoutePaths.bloggerAccount}/:userId',
          name: RouteNames.bloggerAccount,
          builder: (context, state) => BloggerAccount(
            userId: state.pathParameters['userId']!,
          )),
    ],
  );
}
