import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';

// class CreatePostImage extends StatelessWidget {
//   final File? selectedImage;
//   final String? alreadyImmage;
//   final void Function() onTap;

//   const CreatePostImage(
//       {super.key, this.selectedImage, required this.onTap, this.alreadyImmage});
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => ViewImagePage(img: selectedImage!),
//             ));
//           },
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.file(
//               selectedImage!,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 8,
//           right: 8,
//           child: InkWell(
//             onTap: onTap,
//             child: Container(
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.close,
//                 size: 20,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class SearchHashTagSheet extends StatelessWidget {
  const SearchHashTagSheet(
      {super.key,
      required this.hashtagController,
      required this.debouncer,
      required this.addToUi,
      required this.onpresses});
  final TextEditingController hashtagController;
  final Debouncer debouncer;
  final void Function() onpresses;
  final void Function(String value) addToUi;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          AppSizedBox.sizedBox15H,
          TextField(
            controller: hashtagController,
            onChanged: (query) {
              debouncer.run(() {
                context
                    .read<SearchHashtagBloc>()
                    .add(SeachHashTagGetEvent(query: query));
              });
            },
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(),
                hintText: 'Search Hashtags',
                filled: false,
                suffixIcon: IconButton(
                    onPressed: onpresses, icon: const Icon(Icons.add)),
                border: const UnderlineInputBorder()),
          ),
          AppSizedBox.sizedBox10H,
          BlocConsumer<SearchHashtagBloc, SearchHashtagState>(
            listener: (context, state) {
              if (state is SearchHashtagError) {
                Messenger.showSnackBar(message: state.errorMsg);
              }
            },
            builder: (context, state) {
              if (state is SearchHashtagError) {
                return Center(child: Text(state.errorMsg));
              }
              if (state is SearchHashtagloading) {
                return const CircularProgressIndicator();
              }
              if (state is SearchHashtagInitial) {
                return const Center(
                  child: Text('Search for hashtags'),
                );
              } else if (state is SearchHashtagSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.hashtags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          addToUi(state.hashtags[index].hashtagName);
                        },
                        title: Text(state.hashtags[index].hashtagName),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
