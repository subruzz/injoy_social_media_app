import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/presentation/pages/person_chat_page.dart';
import 'package:social_media_app/init_dependecies.dart';

import '../../cubits/message_attribute/message_attribute_bloc.dart';

class PeronalChatBuilder extends StatelessWidget {
  const PeronalChatBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<MessageAttributeBloc>(),
      child: const PersonChatPage(),
    );
  }
}
