import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/debouncer.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/features/create_post/features/bloc/search_hashtag/search_hashtag_bloc.dart';

class CreatePostImage extends StatelessWidget {
  final File? selectedImage;
  final void Function() onTap;

  const CreatePostImage({super.key, this.selectedImage, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8, // Adjust for top padding
          right: 8,
          child: InkWell(
            onTap: onTap,
            child: Container(
              // Add a background for better visibility
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close, // Or use another icon (e.g., Icons.delete)
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SearchHashTagSheet extends StatelessWidget {
  const SearchHashTagSheet(
      {super.key,
      required this.searchHashtagBloc,
      required this.hashtagController,
      required this.debouncer,
      required this.addToUi,
      required this.onpresses});
  final TextEditingController hashtagController;
  final Debouncer debouncer;
  final void Function() onpresses;
  final void Function(String value) addToUi;
  final SearchHashtagBloc searchHashtagBloc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: hashtagController,
              onChanged: (query) {
                debouncer.run(() {
                  searchHashtagBloc.add(SeachHashTagGetEvent(query: query));
                });
              },
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(),
                  hintText: 'Search Hashtags',
                  suffixIcon: IconButton(
                      onPressed: onpresses, icon: const Icon(Icons.add)),
                  border: const UnderlineInputBorder()),
            ),
            AppSizedBox.sizedBox10H,
            BlocConsumer(
              bloc: searchHashtagBloc,
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
                            addToUi(state.hashtags[index].hashTagName);
                          },
                          title: Text('#${state.hashtags[index].hashTagName}'),
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
      ),
    );
  }
}
