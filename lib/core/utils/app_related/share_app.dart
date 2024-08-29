import 'package:share_plus/share_plus.dart';

Future<void> shareApp() async {
  const appUrl =
      "https://www.amazon.com/gp/product/B0DFCZ6189"; 
  await Share.share(
    "Check out Injoy, the social media app that connects you with what truly matters. Join the community now! $appUrl",
  );
}
