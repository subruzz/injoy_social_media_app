import 'package:social_media_app/core/const/enums/message_type.dart';

import '../../../features/chat/data/model/message_model.dart';

String getRecentTextMessage(MessageModel message) {
    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        return '📷 Photo';
      case MessageTypeConst.videoMessage:
        return '📸 Video';
      case MessageTypeConst.audioMessage:
        return '🎵 Audio';
      case MessageTypeConst.gifMessage:
        return 'GIF';
      default:
        return message.message ?? '';
    }
  }