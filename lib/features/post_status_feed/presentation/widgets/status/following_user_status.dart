import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/animated/border_widget.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/pages/view_status_page.dart';

class FollowingUserStatus extends StatelessWidget {
  const FollowingUserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllStatusBloc, GetAllStatusState>(
      builder: (context, state) {
        if (state is GetAllStatusSuccess) {
          return Expanded(
            child: ListView.builder(
                padding: AppPadding.onlyRightMedium,
                scrollDirection: Axis.horizontal,
                itemCount: state.allStatus.length,
                itemBuilder: (context, index) {
                  final userAttribute = state.allStatus[index];
                  return GestureDetector(
                    onTap: () {
                      //       GestureDetector(
                      //         onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewStatusPage(
                          index: 0,
                          statusEntity: userAttribute,
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CustomPaint(
                              painter: StatusDottedBordersWidget(
                                  numberOfStories:
                                      userAttribute.statuses.length,
                                  isMe: false,
                                  spaceLength: 6,
                                  images: userAttribute.statuses,
                                  uid: context.read<AppUserBloc>().appUser!.id),
                              child: Hero(
                                tag: userAttribute.uId,
                                child: CircularUserProfile(
                                    profile: userAttribute.profilePic),
                              ),
                            ),
                          ),
                          Text(userAttribute.userName)
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        return const EmptyDisplay();
      },
    );
  }
}
