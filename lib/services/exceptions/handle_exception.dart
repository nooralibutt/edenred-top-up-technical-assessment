import 'package:mobile_top_up/services/exceptions/exceptions.dart';

class HandleException {
  static AppException handleException(dynamic e) {
    AppException appException;

    if (e is ServerException) {
      appException = e;
    } else {
      appException = UnexpectedException(e.toString());
    }

    return appException;
  }
}
