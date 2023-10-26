import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thalj/core/utils/app_text_style.dart';
import 'package:thalj/features/adminHome/presenation/screens/driver_data_sent_to_owner.dart';

import '../../../../core/utils/app_colors.dart';
import '../bloc/drivers_data_bloc/get_drivers_data_bloc.dart';

class DriverDocWidget extends StatelessWidget {
  const DriverDocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetDriversDataBloc>(context).add(GetDriversData());
    return BlocBuilder<GetDriversDataBloc, GetDriversDataState>(
      builder: (context, state) {
        if (state is GetDriversDataSuccess) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.driversData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DriverDataSentToOwner(),
                        settings: RouteSettings(
                          arguments: state.driversData[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.driversData[index].fullname!,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 24),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is GetDriversDataFailure) {
          return Column(
            children: [
              SizedBox(height: 300.h,),

              Center(child: Text( "لا يوجد سائقين",style: regularStyle(fontSize: 24.h),)),
            ],
          );
        } else {
          return Column(

            children: [
              SizedBox(height: 300.h,),

              const Center(child: CircularProgressIndicator.adaptive()),
            ],
          );
        }
      },
    );
  }
}