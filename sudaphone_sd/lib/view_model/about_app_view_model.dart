import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppViewModel extends GetxController {
  
  openBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw ' can\'t launch $url';
    }
  }
}
