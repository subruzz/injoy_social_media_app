import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';

class SelectedHashtags extends StatelessWidget {
  const SelectedHashtags({super.key, required this.selectTagsCubit});
  final SelectTagsCubit selectTagsCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: selectTagsCubit,
      builder: (context, state) {
        if (state is SelectdTagsSuccess) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: state.tags.map((s) {
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 5),
                      
                        child:
                            Text('#$s', style: const TextStyle(color: Colors.blue)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -15,
                        child: IconButton(
                          onPressed: () {
                            selectTagsCubit.removeTag(s);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 10,
                          ),
                        ),
                      )
                    ],
                  );
                }).toList()),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
