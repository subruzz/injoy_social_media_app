import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/bloc/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
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
                  state.user.userName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: ()async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(appUser: state.user),
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
                        Stack(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 55,
                                backgroundImage: state.user.profilePic != null
                                    ? NetworkImage(state.user.profilePic!)
                                    : const AssetImage(
                                        'assets/images/profile_icon.png')),
                            Positioned(
                              right: 20,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppDarkColor().buttonBackground,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.user.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            textAlign: TextAlign.center,
                            state.user.occupation ?? '',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                            textAlign: TextAlign.center,
                            state.user.about ?? '',
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.user.posts.length.toString(),
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
                                  state.user.followers.length.toString(),
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
                                  state.user.following.length.toString(),
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
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return Container(
          height: 123 + (index * 50),
          color: Colors.grey,
        );
      },
    );
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
