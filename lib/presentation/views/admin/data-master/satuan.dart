import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/common/utils/form_validation.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';
import 'package:kopiek_resto/presentation/blocs/satuan/satuan_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/custom_dialog.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class SatuanView extends StatefulWidget {
  const SatuanView({Key? key}) : super(key: key);

  @override
  _SatuanViewState createState() => _SatuanViewState();
}

class _SatuanViewState extends State<SatuanView> {
  late SatuanBloc _satuanBloc;
  @override
  void initState() {
    super.initState();
    _satuanBloc = di<SatuanBloc>();
    _satuanBloc.add(FetchSatuanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _satuanBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SheetSatuan(
                            satuanBloc: _satuanBloc,
                          ),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))))
                .then((value) {
              if (value != null) {
                print(value);
                _satuanBloc.add(FetchSatuanEvent());
              }
            });
          },
          label: const Text('TAMBAH'),
          backgroundColor: AppColor.primary,
          icon: const Icon(Icons.add),
        ),
        body: BlocBuilder<SatuanBloc, SatuanState>(builder: (context, state) {
          if(state is SatuanLoading){
            return const Center(child: LoadingCircle(),);
          }else if (state is SatuanLoaded){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DataSatuan data = state.data[index];
                  return ListTile(
                    leading:  const Icon(Icons.adb,color: AppColor.secondary,),
                    title: Text(data.nama),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

class SheetSatuan extends StatefulWidget {
  final SatuanBloc satuanBloc;
  const SheetSatuan({Key? key, required this.satuanBloc}) : super(key: key);

  @override
  State<SheetSatuan> createState() => _SheetSatuanState();
}

class _SheetSatuanState extends State<SheetSatuan> {
  TextEditingController nama = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.satuanBloc,
      child: BlocListener<SatuanBloc, SatuanState>(
        listener: (context, state) {
          if (state is SatuanLoaded) {
            if (state.status == Status.failure) {
              EasyLoading.showError('Gagal');
            } else if (state.status == Status.success) {
              EasyLoading.showSuccess('Berhasil');
              Navigator.pop(context, 'ok');
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TAMBAH SATUAN',
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                vSpace(10),
                TextFieldWidget(
                  hintText: 'Nama',
                  controller: nama,
                  validator: (value) =>
                      FormValidation.validate(value.toString(), label: 'Nama'),
                ),
                vSpace(10),
                CustomFlatButton(
                  backgroundColor: AppColor.secondary,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_form.currentState?.validate() ?? false) {
                      widget.satuanBloc.add(AddSatuan(SatuanParams(nama.text)));
                    }
                  },
                  label: 'TAMBAH',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
