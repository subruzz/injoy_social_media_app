class PushNotification {
  String body;
  String title;
  String deviceToken;
  String routeParameterId;
  String notificationRoute;
  String userCallingId;
  PushNotification({
    required this.body,
    required this.title,
    required this.deviceToken,
    this.userCallingId = '',
    required this.routeParameterId,
    required this.notificationRoute,
  });

  Map<String, dynamic> toMap() => {
        'message': {
          'token': deviceToken,
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'android': {
            'notification': {'channel_id': '1'}
          },
          'data': <String, dynamic>{
            // 'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'route': notificationRoute,
            'routeParameterId': routeParameterId,
            'userCallingId': userCallingId,
            // 'isThatGroupChat': isThatGroupChat,
          },
        }
      };
}
