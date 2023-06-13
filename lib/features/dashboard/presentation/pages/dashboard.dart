// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/home/presentation/pages/home.dart';
import 'package:hebron_pay/features/profile/presentation/pages/profile.dart';
import 'package:hebron_pay/features/scan/presentation/pages/scan.dart';
import 'package:hebron_pay/size_config.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required this.loggedInUser});
  static const id = "/dashboard";
  final LoginEntity loggedInUser;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  /// Variable to hold the current screen
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// Variable to hold all the screens
    final List screens = [
      HomeScreen(loggedInUser: widget.loggedInUser),
      const ScanScreen(),
      ProfileScreen(loggedInUser: widget.loggedInUser)
    ];
    return Scaffold(
      body: Stack(children: [
        screens.elementAt(_pageIndex),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(40),
              vertical: getProportionateScreenHeight(10)),
          child: Align(
            alignment: const Alignment(0.0, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                showUnselectedLabels: false,
                selectedItemColor: kWhiteColor,
                selectedLabelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                unselectedItemColor: kLightGrey,
                backgroundColor: kPrimaryColor,
                currentIndex: _pageIndex,
                onTap: (int index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        homeIcon,
                        color: _pageIndex == 0 ? kWhiteColor : kLightPurple,
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenHeight(30),
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        scanIcon,
                        color: _pageIndex == 1 ? kWhiteColor : kLightPurple,
                        width: getProportionateScreenWidth(40),
                        height: getProportionateScreenHeight(40),
                      ),
                      label: 'Scan'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        profileIcon,
                        color: _pageIndex == 2 ? kWhiteColor : kLightPurple,
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenHeight(30),
                      ),
                      label: 'Profile')
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
