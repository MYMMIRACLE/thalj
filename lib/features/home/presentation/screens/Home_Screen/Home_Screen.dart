import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalj/features/home/presentation/bloc/get-accepted-offers/acceptedOffers_bloc.dart';
import 'package:thalj/features/home/presentation/components/customNavbar.dart';

import 'package:thalj/features/home/presentation/screens/Home_Screen/HomeBody.dart';
import 'package:thalj/features/home/presentation/screens/Home_Screen/offers.dart';
import 'package:thalj/features/home/presentation/screens/Home_Screen/profile.dart';

import '../../../domain/repository.dart';
import '../../bloc/orders_bloc/orders_bloc.dart';
import '../../bloc/paySubscription/paySubscription-bloc.dart';
import '../../components/profileAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [



    BlocProvider<GetOrdersDataBloc>(
        create: (context) =>
            GetOrdersDataBloc(homeRepository: context.read<HomeRepository>()),
        child:const HomeBody()),
    BlocProvider<AcceptedOrderBloc>(
        create: (context) =>
            AcceptedOrderBloc(homeRepository: context.read<HomeRepository>()),
        child: const Offers()),
    BlocProvider<PaySubScriptionBloc>(
        create: (context) =>
            PaySubScriptionBloc(homeRepository: context.read<HomeRepository>() ),
        child: const Profile()),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body:  SafeArea(child: Column(
        children: [
          const ProfileAppBar(),
          Expanded(child: _pages.elementAt(_selectedIndex)),
        ],
      ),
      ),




    );
  }
}