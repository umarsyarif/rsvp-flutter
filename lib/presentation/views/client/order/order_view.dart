import 'package:flutter/material.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/widgets/custom_flat_button.dart';
import 'package:kopiek_resto/presentation/widgets/text_fied_widget.dart';

class OrderView extends StatefulWidget {
  final String jenis;
  const OrderView({Key? key, required this.jenis}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  TextEditingController jumlahPelaggan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Order ${widget.jenis}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFieldWidget(
                  hintText: 'Jumlah Pelanggan',
                  typeInput: TextInputType.number,
                  controller: jumlahPelaggan,
                maxLength: 2,
              ),
              vSpace(10),
              TextFieldWidget(
                hintText: 'Jadwal',
                readonly: true,
                controller: tanggal,
                onTap:(){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30))).then((value){
                        if(value!=null){
                          tanggal.text = dbDateFormat(value);
                        }
                  });
                }
              ),
              vSpace(10),
              TextFieldWidget(
                hintText: 'Jam',
                  readonly: true,
                  controller: jam,
                  onTap:(){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial,
                      builder: (context,child){
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      }
                    ).then((value){
                      if(value!=null){
                        jam.text = '${value.hour}:${value.minute}';
                      }
                    });
                  }
              ),
              vSpace(20),
              CustomFlatButton(backgroundColor: AppColor.primary, label: 'SIMPAN', onPressed: (){

              })
            ],
          ),
        ),
      ),
    );
  }
}
