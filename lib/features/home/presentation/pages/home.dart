// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_pending_transactions_cubit/pending_transactions_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:hebron_pay/features/home/presentation/pages/deposit.dart';
import 'package:hebron_pay/features/home/presentation/pages/generate_ticket.dart';
import 'package:hebron_pay/features/home/presentation/pages/pending_transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/withdraw.dart';
import 'package:hebron_pay/features/home/presentation/widgets/transaction_card.dart';
import 'package:hebron_pay/size_config.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/generate_eod_cubit/generate_eod_cubit.dart';
import '../widgets/pending_transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.loggedInUser});
  final LoginEntity loggedInUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BalanceEntity? balanceDetails;
  List<PendingTransactionEntity>? pendingTransaction;
  List<TransactionEntity>? transaction;

  /// Show Balance
  void _showBalance() async {
    await BlocProvider.of<BalanceCubit>(context).showBalance();
  }

  /// Get Pending Transactions
  void _getPendingTransaction() async {
    var res = await BlocProvider.of<PendingTransactionsCubit>(context)
        .getPendingTransactions();
    pendingTransaction = res;
  }

  /// Get Transactions
  void _getTransaction() async {
    var res =
        await BlocProvider.of<TransactionCubit>(context).getTransactions();
    transaction = res;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _showBalance();
    _getPendingTransaction();
    _getTransaction();
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
        child: BlocConsumer<BalanceCubit, BalanceState>(
          listener: (context, state) {
            if (state is BalanceFailure) {
              showErrorSnackBar(context, (state).errorMessage);
            }
          },
          builder: (context, state) {
            if (state is BalanceLoading) {
              _isLoading = true;
            } else {
              _isLoading = false;
            }
            if (state is BalanceSuccess) {
              balanceDetails = (state).walletDetails;
            }
            return Column(
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
                  child: _isLoading || balanceDetails == null
                      ? SpinKitWave(
                          color: kWhiteColor,
                          size: getProportionateScreenWidth(25),
                        )
                      : Column(
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
                                  nairaAmount(
                                      balanceDetails!.walletBalance.toDouble()),
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
                                      Navigator.pushNamed(
                                          context, DepositScreen.id);
                                    },
                                    text: 'Deposit',
                                  ),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(20)),
                                Expanded(
                                  child: TransactionButton(
                                    text: 'Withdraw',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, WithdrawScreen.id);
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
                    BlocConsumer<GenerateEodCubit, GenerateEodState>(
                      listener: (context, state) {
                        if (state is GenerateEodSuccess) {
                          showSuccessSnackBar(context,
                              'Your End-of-Day has been Successfully sent to your Mail');
                        }
                        if (state is GenerateEodFailure) {
                          showErrorSnackBar(context, (state).errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GenerateEodLoading) {
                          _isLoading = true;
                        } else {
                          _isLoading = false;
                        }
                        return Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await BlocProvider.of<GenerateEodCubit>(context)
                                  .generateEod();
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
                              child: _isLoading
                                  ? SpinKitDancingSquare(
                                      color: kPrimaryColor,
                                      size: getProportionateScreenWidth(50),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                        );
                      },
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
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
                        BlocConsumer<PendingTransactionsCubit,
                            PendingTransactionsState>(
                          listener: (context, state) {
                            if (state is PendingTransactionsFailure) {
                              showErrorSnackBar(context, (state).errorMessage);
                            }
                          },
                          builder: (context, state) {
                            if (state is PendingTransactionsLoading) {
                              _isLoading = true;
                            } else {
                              _isLoading = false;
                            }
                            if (state is PendingTransactionsSuccess) {
                              pendingTransaction = (state).pendingTrx;
                            }
                            return _isLoading
                                ? SpinKitWave(
                                    color: kPrimaryColor,
                                    size: getProportionateScreenWidth(25),
                                  )
                                : SizedBox(
                                    height: getProportionateScreenHeight(170),
                                    child: ListView.builder(
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return PendingTransactionReceipt(
                                                  position: index);
                                            }));
                                          },
                                          child: Column(
                                            children: [
                                              PendingTransactionCard(
                                                ticketDescription:
                                                    pendingTransaction![index]
                                                        .description,
                                                ticketAmount: nairaAmount(
                                                    pendingTransaction![index]
                                                        .amount
                                                        .toDouble()),
                                                timeCreated:
                                                    pendingTransaction![index]
                                                        .time,
                                                dateCreated:
                                                    pendingTransaction![index]
                                                        .date,
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          },
                        ),

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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
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
                        BlocConsumer<TransactionCubit, TransactionState>(
                          listener: (context, state) {
                            if (state is TransactionFailure) {
                              showErrorSnackBar(context, (state).errorMessage);
                            }
                          },
                          builder: (context, state) {
                            if (state is TransactionLoading) {
                              _isLoading = true;
                            } else {
                              _isLoading = false;
                            }
                            if (state is TransactionSuccess) {
                              transaction = (state).userTrx;
                            }
                            return _isLoading
                                ? SpinKitWave(
                                    color: kPrimaryColor,
                                    size: getProportionateScreenWidth(25))
                                : SizedBox(
                                    height: getProportionateScreenHeight(315),
                                    child: ListView.builder(
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return TransactionReceipt(
                                                    position: index);
                                              }));
                                            },
                                            child: Column(
                                              children: [
                                                TransactionCard(
                                                  ticketDescription:
                                                      transaction![index]
                                                          .description,
                                                  ticketAmount: nairaAmount(
                                                      transaction![index]
                                                          .amount
                                                          .toDouble()),
                                                  isDebit: transaction![index]
                                                              .type ==
                                                          'debit'
                                                      ? true
                                                      : false,
                                                  timeCreated:
                                                      transaction![index].time,
                                                  dateCreated:
                                                      transaction![index].date,
                                                ),
                                                SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            10))
                                              ],
                                            ),
                                          );
                                        }),
                                  );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
