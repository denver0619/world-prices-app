import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:world_prices_app/ui/nonreusable_widget/country_group/europe_country.dart';
import 'package:world_prices_app/main.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(path: '/',
    name: 'home',
    builder: (BuildContext context, GoRouterState state) {
      return MyHomePage();
    },
    routes: [
      GoRoute(path: 'europe_country/:title/:code',
        name: 'europe_country',
        builder: (BuildContext context, GoRouterState state) {
          return EuropeCountry(title: state.params['title']!, code: state.params['code']!);
        }
      )
    ]
  )
]);