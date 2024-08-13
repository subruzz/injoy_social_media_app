import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore.dart';

import '../../../../core/utils/di/init_dependecies.dart';
import '../blocs/get_recommended_post/get_recommended_post_cubit.dart';
import '../blocs/search_hash_tag/search_hash_tag_cubit.dart';
import '../blocs/search_user/search_user_cubit.dart';

class ExplorePageBuilder extends StatefulWidget {
  const ExplorePageBuilder({super.key});

  @override
  State<ExplorePageBuilder> createState() => _ExplorePageBuilderState();
}

class _ExplorePageBuilderState extends State<ExplorePageBuilder> {
  @override
  void initState() {
    super.initState();
    log('explore page is built ');
  }

  @override
  void dispose() {
    log('explore page is disposed ');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<SearchUserCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SearchHashTagCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetRecommendedPostCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SearchLocationExploreCubit>(),
        ),
      ],
      child: const ExplorePage(),
    );
  }
}
