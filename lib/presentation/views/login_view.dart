import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';
import 'package:kopiek_resto/presentation/blocs/login/login_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/custom_outline_button.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginBloc loginBloc;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loginBloc = di<LoginBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>loginBloc,
      child: BlocListener<LoginBloc,LoginState>(
        listener: (context,state){
          if(state is LoginFailure){
            EasyLoading.showError(state.message);
          }else if(state is LoginSuccess){
            if(state.role == 'admin'){
              Navigator.pushNamedAndRemoveUntil(context, RouteList.homeAdmin, (route) => false);
            }else if (state.role == 'pelanggan'){
              Navigator.pushNamedAndRemoveUntil(context, RouteList.homeClient, (route) => false);
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('KOPIEK RESTO', style: blackTextStyle.copyWith(fontSize: 32,fontWeight: extraBold),),
                    vSpace(40),
                    TextFieldWidget(
                      hintText: 'Email',
                      controller: email,
                      typeInput: TextInputType.emailAddress,
                      validator: FormValidation.validateEmail,
                    ),
                    vSpace(20),
                    TextFieldWidget(
                      hintText: 'password',
                      isPasswordField: true,
                      controller: password,
                      validator: FormValidation.validatePassword,
                    ),
                    vSpace(20),
                    CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIGN IN', onPressed: (){
                      FocusScope.of(context).unfocus();
                      if(_form.currentState?.validate()??false){
                            loginBloc.add(StartLogin(
                                LoginParams(email.text, password.text)));
                          }
                        }),
                    vSpace(20),
                    CustomOutlineButton(borderColor: AppColor.primary, label: 'REGISTER', onPressed: (){
                      Navigator.pushNamed(context, RouteList.register);
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
