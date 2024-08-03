// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/common/entities/user_entity.dart';

// import '../../../../../core/firebase_helper.dart';
// import '../../../../../init_dependecies.dart';

// part 'reciever_chat_info_state.dart';

// class RecieverChatInfoCubit extends Cubit<RecieverChatInfoState> {
//   RecieverChatInfoCubit() : super(RecieverChatInfoInitial());
//   bool _loadMesages = true;
//   Future<void> setRecipientMessageUserDetails(String userId) async {
//     try {
//       emit(RecieverChatInfoLoading());
//       serviceLocator<FirebaseHelper>().getUserDetailsStream(userId).listen(
//           (appUserModel) {
//         if (_loadMesages) {
//           _loadMesages = false;
//           return emit(RecieverChatInfoSuccess(
//               otherUser: appUserModel, loadMessage: true));
//         }
//         emit(RecieverChatInfoSuccess(otherUser: appUserModel));
//       }, onError: (error) {
//         emit(const RecieverChatInfoError());
//       });
//     } catch (e) {
//       emit(const RecieverChatInfoError());
//     }
//   }
// }
