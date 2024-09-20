import 'package:share_plus/share_plus.dart';

/// Shares a message about the app through the device's sharing options.
///
/// This function constructs a message that invites users to check out the
/// Injoy app and includes a link to the app's page on Amazon.
Future<void> shareApp() async {
  const appUrl =
      "https://www.amazon.com/gp/product/B0DFCZ6189"; 
      
  await Share.share(
    "Check out Injoy, the social media app that connects you with what truly matters. Join the community now! $appUrl",
  );
}
