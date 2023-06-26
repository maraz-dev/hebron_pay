import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/core/widgets/general_button.dart';
import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_pending_transactions_cubit/pending_transactions_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:hebron_pay/features/home/presentation/pages/pending_transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/widgets/pending_transaction_card.dart';
import 'package:hebron_pay/features/home/presentation/widgets/transaction_card.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/bloc/cubit/user_details_cubit.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key, required this.isPendingTrx});
  final bool isPendingTrx;

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  HebronPayWalletEntity? balanceDetails;
  List<PendingTransactionEntity>? pendingTransaction = [];
  List<TransactionEntity>? transaction = [];
  bool _isLoading = false;
  String? errorText;
  final GlobalKey<FormState> _pinFormkey = GlobalKey();

  /// Set PIN Controller
  final TextEditingController _pinController = TextEditingController();

  void _showBalance() async {
    var balance =
        await BlocProvider.of<UserDetailsCubit>(context).getWalletDetails();
    balanceDetails = balance;
  }

  /// Get Pending Transactions
  void _getPendingTransaction() async {
    var res = await BlocProvider.of<PendingTransactionsCubit>(context)
        .getPendingTransactions();
    pendingTransaction = res!;
  }

  /// Get Transactions
  void _getTransaction() async {
    var res =
        await BlocProvider.of<TransactionCubit>(context).getTransactions();
    transaction = res!;
  }

  @override
  void initState() {
    super.initState();
    _showBalance();
    widget.isPendingTrx ? _getPendingTransaction() : _getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            backArrowIcon,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          widget.isPendingTrx
              ? 'View All Pending Transactions'
              : 'View All Transactions',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        children: [
          BlocConsumer<UserDetailsCubit, UserDetailsState>(
            listener: (context, state) {
              if (state is UserDetailsFailure) {
                showErrorSnackBar(context, (state).errorMessage);
              }
            },
            builder: (context, state) {
              if (state is UserDetailsLoading) {
                _isLoading = true;
              } else {
                _isLoading = false;
              }
              if (state is UserDetailsWalletSuccess) {
                balanceDetails = (state).walletEntity;
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10)),
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      border: Border.all(color: kPrimaryColor, width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  child: _isLoading || balanceDetails == null
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10)),
                          child: SpinKitSquareCircle(
                            color: kPrimaryColor,
                            size: getProportionateScreenWidth(25),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: kPrimaryColor),
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  balanceDetails == null
                                      ? nairaAmount(0)
                                      : nairaAmount(balanceDetails!
                                          .walletBalance
                                          .toDouble()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: kPrimaryColor),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    eyeSlashIcon,
                                    color: kPrimaryColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(16)),
                          ],
                        ),
                ),
              );
            },
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: widget.isPendingTrx
                    ? BlocConsumer<PendingTransactionsCubit,
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
                              ? Center(
                                  child: SpinKitFoldingCube(
                                    color: kPrimaryColor,
                                    size: getProportionateScreenWidth(25),
                                  ),
                                )
                              : pendingTransaction!.isEmpty ||
                                      pendingTransaction == null
                                  ? Center(
                                      child: Column(
                                      children: [
                                        Text(
                                          "You don't have any Pending Transactions yet...",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: kLightGrey),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(10),
                                        )
                                      ],
                                    ))
                                  : SizedBox(
                                      child: ListView.builder(
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: pendingTransaction!.length,
                                        itemBuilder: (context, pendingIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              _showPinBottomSheet(
                                                  context, pendingIndex);
                                            },
                                            child: Column(
                                              children: [
                                                PendingTransactionCard(
                                                  ticketDescription:
                                                      pendingTransaction![
                                                              pendingIndex]
                                                          .description,
                                                  ticketAmount: nairaAmount(
                                                      pendingTransaction![
                                                              pendingIndex]
                                                          .amount
                                                          .toDouble()),
                                                  timeCreated:
                                                      pendingTransaction![
                                                              pendingIndex]
                                                          .time,
                                                  dateCreated:
                                                      pendingTransaction![
                                                              pendingIndex]
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
                      )
                    : BlocConsumer<TransactionCubit, TransactionState>(
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
                              ? Center(
                                  child: SpinKitFoldingCube(
                                      color: kPrimaryColor,
                                      size: getProportionateScreenWidth(25)),
                                )
                              : transaction!.isEmpty || transaction == null
                                  ? Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            "You don't have any Pending Transactions yet...",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: kLightGrey),
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      child: ListView.builder(
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: transaction!.length,
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
                                                        transaction![index]
                                                            .time,
                                                    dateCreated:
                                                        transaction![index]
                                                            .date,
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
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Transaction PIN Modal Sheet
  void _showPinBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              errorText = null;
              return false;
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: kWhiteColor,
              ),
              child: Form(
                key: _pinFormkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        'Enter PIN',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Text(
                      'Enter your Transaction PIN below to continue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    errorText == null
                        ? Container()
                        : Center(
                            child: Text(
                            errorText!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: kErrorColor,
                                    fontWeight: FontWeight.bold),
                          )),
                    SizedBox(height: getProportionateScreenHeight(20)),

                    /// Transaction PIN Box
                    Center(
                      child: Pinput(
                        controller: _pinController,
                        length: 4,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        defaultPinTheme: kDefaultPin(context),
                        focusedPinTheme: kFocusedPin(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Cannot be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    GeneralButton(
                        text: 'Continue',
                        onPressed: () {
                          if (!_pinFormkey.currentState!.validate()) return;
                          if (balanceDetails!.walletPin ==
                              int.parse(_pinController.text)) {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return PendingTransactionReceipt(position: index);
                            }));
                            errorText = null;
                            _pinController.clear();
                          } else {
                            Navigator.pop(context);
                            showErrorSnackBar(context, 'Incorrect Pin');
                            print('Incorrect PIN');
                            setState(() {
                              errorText = 'Incorrect Pin';
                            });
                            _pinController.clear();
                          }
                        }),
                    SizedBox(height: getProportionateScreenHeight(20))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
