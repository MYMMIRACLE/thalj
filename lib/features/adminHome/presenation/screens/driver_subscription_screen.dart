import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thalj/core/widgets/custom_app_bar_product_info.dart';

import '../../../../core/utils/app_text_style.dart';
import '../bloc/driver_subscription_bloc/driver_subscription_bloc.dart';
import '../bloc/driver_subscription_bloc/driver_subscription_event.dart';
import '../bloc/driver_subscription_bloc/driver_subscription_state.dart';
import '../components/custom_driver_subscription.dart';

class DriverSubscriptionScreen extends StatelessWidget {
  const DriverSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DriverSubscriptionBloc>(context)
        .add(FetchDriverSubscriptions());

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CustomAppBar(title: ":وصولات دفع السائقين"),
                _buildScreen(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildScreen(BuildContext context) {
    return BlocBuilder<DriverSubscriptionBloc, DriverSubscriptionState>(
      builder: (context, state) {
        if (state is DriverSubscriptionLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.driverSubscriptions.length,
              itemBuilder: (context, index) {
                return CustomDriverSubscription(
                  driverSubscriptionModel: state.driverSubscriptions[index],
                );
              },
            ),
          );

        } else if (state is DriverSubscriptionError) {
          return Column(

            children: [
              SizedBox(height: 300.h,),
              Text(
                "لا توجد فواتير",
                style: regularStyle(fontSize: 24.h),
              ),
            ],
          );
        } else  {
          return Column(
            children: [
              SizedBox(height: 300.h,),
              const CircularProgressIndicator.adaptive(),
            ],
          );
        }
      },
    );
  }
}