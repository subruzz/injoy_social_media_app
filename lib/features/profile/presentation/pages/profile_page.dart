import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocConsumer<AppUserBloc, AppUserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  context.read<AppUserBloc>().appUser!.userName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                            appUser: context.read<AppUserBloc>().appUser!),
                      ));
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  // Profile info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Stack(
                        //   children: [
                        //     CircleAvatar(
                        //         backgroundColor: Colors.black,
                        //         radius: 55,
                        //         backgroundImage: context
                        //                     .read<AppUserBloc>()
                        //                     .appUser!
                        //                     .profilePic !=
                        //                 null
                        //             ? NetworkImage(context
                        //                 .read<AppUserBloc>()
                        //                 .appUser!
                        //                 .profilePic!)
                        //             : const AssetImage(
                        //                 'assets/images/profile_icon.png')),
                        //     Positioned(
                        //       right: 20,
                        //       bottom: 0,
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           height: 20,
                        //           width: 20,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(2.0),
                        //             color: AppDarkColor().buttonBackground,
                        //           ),
                        //           child: const Icon(
                        //             Icons.edit,
                        //             color: Colors.black,
                        //             size: 13,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 8),
                        Text(
                          context.read<AppUserBloc>().appUser!.fullName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            textAlign: TextAlign.center,
                            context.read<AppUserBloc>().appUser!.occupation ??
                                '',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                            textAlign: TextAlign.center,
                            context.read<AppUserBloc>().appUser!.about ?? '',
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  context
                                      .read<AppUserBloc>()
                                      .appUser!
                                      .posts
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Posts',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height:
                                  40, // Specify a height to see the vertical divider
                              child: VerticalDivider(
                                width: 20,
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  context
                                      .read<AppUserBloc>()
                                      .appUser!
                                      .followers
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height:
                                  40, // Specify a height to see the vertical divider
                              child: VerticalDivider(
                                width: 20,
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  context
                                      .read<AppUserBloc>()
                                      .appUser!
                                      .following
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // TabBar for switching between Photos and Posts
                        TabBar(
                          dividerColor: AppDarkColor().secondaryBackground,
                          indicatorColor: Colors.red,
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_rounded),
                                  SizedBox(width: 5),
                                  Text('Photos'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_to_photos_sharp),
                                  SizedBox(width: 5),
                                  Text('posts'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // TabBarView for displaying content of each tab
                  Expanded(
                    child: TabBarView(
                      children: [
                        PhotosTab(),
                        PostsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('not logged In'),
            );
          }
        },
      ),
    );
  }
}

class PhotosTab extends StatelessWidget {
  const PhotosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoading) {
          return CircularProgressIndicator();
        } else if (state is GetUserPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserPostsSuccess) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.userPosts.length,
              itemBuilder: (context, index) =>
                  Text(state.userPosts[index].postId),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );

    // MasonryGridView.count(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 4,
    //   crossAxisSpacing: 4,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       height: 123 + (index * 50),
    //       child: Image.network(
    //         'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg',
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   },
    // );
  }
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.grey[300],
          height: 100,
        );
      },
    );
  }
}
