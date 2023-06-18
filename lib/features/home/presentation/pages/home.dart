// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:hebron_pay/features/home/presentation/pages/deposit.dart';
import 'package:hebron_pay/features/home/presentation/pages/generate_ticket.dart';
import 'package:hebron_pay/features/home/presentation/pages/pending_transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/withdraw.dart';
import 'package:hebron_pay/features/home/presentation/widgets/transaction_card.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';
import '../widgets/pending_transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.loggedInUser});
  final LoginEntity loggedInUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BalanceEntity? balanceDetails;

  // /// Show Balance
  // void showBalance() async {
  //   balanceDetails = await BlocProvider.of<BalanceCubit>(context).showBalance();
  // }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Home');
    // showBalance();
    // print(balanceDetails!.walletBalance);
    BlocProvider.of<BalanceCubit>(context).showBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome, ${widget.loggedInUser.firstName}',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(notificationReadIcon),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            /// Balance, Withdraw and Deposit Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20)),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: kWhiteColor),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nairaAmount(10000),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: kWhiteColor),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          eyeSlashIcon,
                          color: kWhiteColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Row(
                    children: [
                      Expanded(
                        child: TransactionButton(
                          onPressed: () {
                            Navigator.pushNamed(context, DepositScreen.id);
                          },
                          text: 'Deposit',
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      Expanded(
                        child: TransactionButton(
                          text: 'Withdraw',
                          onPressed: () {
                            Navigator.pushNamed(context, WithdrawScreen.id);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),

            /// Ticket and EOD Button
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, GenerateTicket.id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(5)),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(ticketIcon),
                          Text(
                            'Generate \nTicket',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          SvgPicture.asset(
                            arrowRightIcon,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(15)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(5)),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: _isLoading
                          ? SpinKitDancingSquare(
                              color: kPrimaryColor,
                              size: getProportionateScreenWidth(25),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(eodIcon),
                                Text(
                                  'Generate \nE O D',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                                SvgPicture.asset(
                                  arrowRightIcon,
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(15)),

                    /// Pending Payments
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pending Transactions',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See all',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    color: kDarkGrey),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PendingTransactionReceipt.id);
                      },
                      child: PendingTransactionCard(
                        ticketDescription: 'Chicken and Chips',
                        ticketAmount: nairaAmount(1000),
                        timeCreated: '8:55PM',
                        dateCreated: '25-10-2022',
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    PendingTransactionCard(
                      ticketDescription: 'Drinks',
                      ticketAmount: nairaAmount(1000),
                      timeCreated: '8:55PM',
                      dateCreated: '25-10-2022',
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),

                    /// Recent Transactions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transactions',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See all',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    color: kDarkGrey),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, TransactionReceipt.id);
                      },
                      child: TransactionCard(
                        ticketDescription: 'Chicken and Chips',
                        ticketAmount: nairaAmount(2000),
                        isDebit: true,
                        timeCreated: '5:45PM',
                        dateCreated: '25-10-2022',
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    TransactionCard(
                      ticketDescription: 'Chicken and Chips',
                      ticketAmount: nairaAmount(20000),
                      isDebit: false,
                      timeCreated: '5:45PM',
                      dateCreated: '25-10-2022',
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    TransactionCard(
                      ticketDescription: 'Drinks',
                      ticketAmount: nairaAmount(2000),
                      isDebit: true,
                      timeCreated: '5:45PM',
                      dateCreated: '25-10-2022',
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    TransactionCard(
                      ticketDescription: 'Chicken and Chips',
                      ticketAmount: nairaAmount(20000),
                      isDebit: false,
                      timeCreated: '5:45PM',
                      dateCreated: '25-10-2022',
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    TransactionCard(
                      ticketDescription: 'Drinks',
                      ticketAmount: nairaAmount(2000),
                      isDebit: true,
                      timeCreated: '5:45PM',
                      dateCreated: '25-10-2022',
                    ),
                    SizedBox(height: getProportionateScreenHeight(100))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
