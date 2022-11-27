import 'package:bloc_app/logic/cubits/patient_add/patient_add_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/patient.dart';

class FinalCreatePatient extends StatefulWidget {
  const FinalCreatePatient({super.key});

  @override
  State<FinalCreatePatient> createState() => _FinalCreatePatientState();
}

class _FinalCreatePatientState extends State<FinalCreatePatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả của việc tạo bệnh nhân mới'),
      ),
      body: BlocBuilder<PatientAddCubit, PatientAddState>(
          builder: (context, state) {
        BlocProvider.of<PatientAddCubit>(context).sendData();
        if (state.data_sending == dataSending.failure) {
          return Text('Dữ liệu này được cập nhật thất bại');
        } else if (state.data_sending == dataSending.sending) {
          return Text('Đang gửi dữ liệu bệnh nhân đến Firebase.');
        } else if (state.data_sending == dataSending.success) {
          return Text('Dữ liệu này được cập nhật thành công.');
        } else {
          return Text('Có lỗi xảy ra');
        }
      }),
    );
  }
}