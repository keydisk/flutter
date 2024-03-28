import 'package:flutter/foundation.dart';
import 'package:test_project/APIs/APIClient.dart';
import 'package:test_project/generated/l10n.dart';

class CommonViewModel extends ChangeNotifier {

  final APIClient api = APIClient();
}
