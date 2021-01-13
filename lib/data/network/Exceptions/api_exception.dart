import '../../../helpers/global_scaffold.dart';
import 'package:dio/dio.dart';

class ApiException {
  Response<dynamic> response;

  ApiException(errorsResponse) {
    response = errorsResponse;

    showErrors();
  }

  showErrors() {

    if (response.statusCode == 422) {
      Map errors = response.data['errors'];

      if (errors != null) {
        String allErrors = "";

        errors.forEach((key, value) => allErrors = allErrors + value[0] + "\n");

        GlobalScaffold.instance.showSnackBar(allErrors);
        //FlutterToast.error(allErrors);

        return;
      }

      //FlutterToast.error('Dados inválidos');
      GlobalScaffold.instance.showSnackBar('Dados inválidos');

      return;
    } else if (response.statusCode == 404) {
      //FlutterToast.error('Requisição inválida');
      GlobalScaffold.instance.showSnackBar('invalid credentials');

      return;
    }else if (response.statusCode >= 400 && response.statusCode < 500) {
      //FlutterToast.error('Requisição inválida');
      GlobalScaffold.instance.showSnackBar('Requisição inválida');

      return;
    }

    GlobalScaffold.instance.showSnackBar('Falha ao fazer a requisição (tente novamente mais tarde)');

    // FlutterToast.error(
    //     'Falha ao fazer a requisição (tente novamente mais tarde)');

    return;
  }
}
