import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/pages/person_chat_page.dart';

import '../../../../core/utils/di/di.dart';

class PersonalChatBuilder extends StatelessWidget {
  const PersonalChatBuilder({super.key, required this.otherUserId});
  final String otherUserId;
  @override
  Widget build(BuildContext context) {
    final id = context.read<AppUserBloc>().appUser.id;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<MessageCubit>())
      ],
      child: PersonChatPage(
        otherUserId: otherUserId,
        myId: id,
      ),
    );
  }
}
