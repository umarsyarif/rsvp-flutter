import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/route_list.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/register_params.dart';
import 'package:kopiek_resto/presentation/blocs/register/register_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterBloc _registerBloc;
  TextEditingController username = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noHp = TextEditingController();
  final _form = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _registerBloc = di<RegisterBloc>();
  }
  
  @override
  void dispose() {
    super.dispose();
    _registerBloc.close();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_registerBloc,
      child: Scaffold(
        body: BlocListener<RegisterBloc,RegisterState>(
          listener: (context,state){
            print(state);
            if(state is RegisterFailure){
              EasyLoading.showError(state.message);
            }else if (state is RegisterSuccess){
              EasyLoading.showSuccess('Berhasil daftar akun');
              Navigator.pushNamedAndRemoveUntil(context, RouteList.login, (route) => false);
            }
          },
          child: SafeArea(
            child: Center(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Daftar sebagai pelanggan',style: blackTextStyle.copyWith(fontSize: 24,fontWeight: bold),),
                            vSpace(20),
                            TextFieldWidget(
                                hintText: 'username',
                              controller: username,
                              validator: (value) =>
                                  FormValidation.validate(value.toString(), label: 'username'),
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'nama lengkap',
                              controller: nama,
                              validator: (value) =>
                                  FormValidation.validate(value.toString(), label: 'nama'),
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'password',
                                isPasswordField: true,
                              validator: FormValidation.validatePassword,
                              controller:  password,
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'konfirmasi password',
                              isPasswordField: true,
                              validator:(value)=> FormValidation.validateCPassword(value,password.text),
                              controller: cPassword,
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'email',
                              typeInput: TextInputType.emailAddress,
                              controller: email,
                              validator: FormValidation.validateEmail,
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'nomor hp',
                              typeInput: TextInputType.number,
                              controller: noHp,
                              maxLength: 13,
                              validator:(value)=> FormValidation.validateNoHp(value.toString()),
                            ),
                            vSpace(10),
                            TextFieldWidget(
                                hintText: 'alamat',
                              controller: alamat,
                              validator: (value) =>
                                  FormValidation.validate(value.toString(), label: 'Alamat'),
                            ),
                            vSpace(20),
                            CustomFlatButton(
                              onPressed: (){
                                if(_form.currentState?.validate()??false){
                                  _registerBloc.add(RegisterUserEvent(RegisterParams(
                                    username.text,
                                    password.text,
                                    email.text,
                                    alamat.text,
                                    noHp.text,
                                      nama.text
                                  )));
                                }
                              },
                              label: 'DAFTAR',
                              backgroundColor: AppColor.primary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
