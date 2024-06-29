import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/create_mutliple_status.dart';
import 'package:social_media_app/features/create_post/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/sample.dart';

class StatusCreationPage extends StatefulWidget {
  const StatusCreationPage({super.key});

  @override
  State<StatusCreationPage> createState() => _StatusCreationPageState();
}

class _StatusCreationPageState extends State<StatusCreationPage> {
  Color selectedColor = Colors.blue;
  final TextEditingController _controller = TextEditingController();
  final colorCubit = SelectColorCubit();
  final List<AssetEntity> _selectedAssets = [];
  bool _isMultipleStatusPage = false;
  @override
  Widget build(BuildContext context) {
    return _isMultipleStatusPage
        ? MyPageViewScreen(
            changeScreen: () {
              setState(() {
                _selectedAssets.clear();
                _isMultipleStatusPage = false;
              });
            },
            assets: _selectedAssets,
          )
        : BlocBuilder(
            bloc: colorCubit,
            builder: (context, state) {
              return Scaffold(
                floatingActionButton: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 70.0), // Adjust the value as needed
                    child: FloatingActionButton(
                      onPressed: () async {
                        final List<AssetEntity>? res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Media(
                                      alreadySelected: _selectedAssets,
                                    )));
                        _selectedAssets.clear();

                        if (res != null) {
                          setState(() {
                            _isMultipleStatusPage = true;
                          });
                          _selectedAssets.addAll(res);
                        } else {
                          _selectedAssets.clear();
                        }
                      },
                      child: const Icon(Icons.camera_sharp),
                    )),
                appBar: AppBar(
                  backgroundColor: colorCubit.color,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  title: Text(
                    'Create Status',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  actions: [
                    BlocConsumer<StatusBloc, StatusState>(
                      listener: (context, state) {
                        if (state is StatusCreateSuccess) {
                          Navigator.pop(context);
                        }
                        if (state is StatusCreateFailure) {
                          Messenger.showSnackBar(
                              message: 'Error while creating status');
                        }
                      },
                      builder: (context, state) {
                        if (state is CreatePostLoading) {
                          return const LoadingBar();
                        }
                        return IconButton(
                            onPressed: () {
                              final currentUser =
                                  context.read<AppUserBloc>().appUser!;
                              context.read<StatusBloc>().add(CreateStatusEvent(
                                  userId: currentUser.id,
                                  profilePic: currentUser.profilePic,
                                  userName: currentUser.userName ?? '',
                                  content: _controller.text.trim(),
                                  color: colorCubit.color.value,
                                  statusImage: null));
                            },
                            icon: Transform.rotate(
                              angle:
                                  -45 * (2.4 / 180), // -45 degrees in radians
                              child: const Icon(
                                Icons.send_outlined,
                              ),
                            ));
                      },
                    )
                  ],
                ),
                body: Container(
                  color: colorCubit.color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: TextField(
                            controller: _controller,
                            textAlign: TextAlign.center,
                            maxLines: null,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppDarkColor().primaryText),
                              hintText: 'Write your thought\n with others',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildColorButton(Colors.green),
                            _buildColorButton(Colors.yellow.withOpacity(.8)),
                            _buildColorButton(Colors.blue),
                            _buildColorButton(Colors.red),
                            _buildColorButton(Colors.pink),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        colorCubit.changeColor(color);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: colorCubit.color == color
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
      ),
    );
  }
}
