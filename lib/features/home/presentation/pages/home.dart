// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/bloc/cubit/user_details_cubit.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_pending_transactions_cubit/pending_transactions_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/set_pin_cubit/set_pin_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:hebron_pay/features/home/presentation/pages/all_transactions.dart';
import 'package:hebron_pay/features/home/presentation/pages/deposit.dart';
import 'package:hebron_pay/features/home/presentation/pages/generate_ticket.dart';
import 'package:hebron_pay/features/home/presentation/pages/pending_transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/withdraw.dart';
import 'package:hebron_pay/features/home/presentation/widgets/transaction_card.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/generate_eod_cubit/generate_eod_cubit.dart';
import '../widgets/pending_transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserEntity? currentUserEntity;
  HebronPayWalletEntity? balanceDetails;
  List<PendingTransactionEntity>? pendingTransaction = [];
  List<TransactionEntity>? transaction = [];
  String? errorText;

  /// Set PIN Controller
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _setPinContoller = TextEditingController();
  final TextEditingController _confirmSetPinController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final GlobalKey<FormState> _pinFormkey = GlobalKey();

  /// Get User Details
  void _getCurrentUser() async {
    var currentUser =
        await BlocProvider.of<UserDetailsCubit>(context).userUsecase();
    currentUserEntity = currentUser;
  }

  /// Show Balance
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

  bool _isLoading = false;
  bool _showBalanceFigure = false;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
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
        title: BlocConsumer<UserDetailsCubit, UserDetailsState>(
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
            if (state is UserDetailsSuccess) {
              currentUserEntity = (state).userEntity;
            }
            return _isLoading
                ? Container()
                : currentUserEntity == null
                    ? Container()
                    : Text(
                        'Welcome, ${currentUserEntity!.firstName}',
                        style: Theme.of(context).textTheme.displaySmall,
                      );
          },
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
        child: BlocConsumer<UserDetailsCubit, UserDetailsState>(
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
              if (balanceDetails!.walletPin == 0) {
                print('Balance PIN has not been Set');

                /// Build the Transaction PIN bottomsheet when the change pin button is clicked
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _setPinBottomSheet(context);
                });
              } else {
                print('Balance PIN has been set');
              }
            }
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                _getCurrentUser();
                _showBalance();
                _getPendingTransaction();
                _getTransaction();
              },
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
                    child: _isLoading || balanceDetails == null
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(50)),
                            child: SpinKitSquareCircle(
                              color: kWhiteColor,
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
                                    .copyWith(color: kWhiteColor),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    balanceDetails == null
                                        ? nairaAmount(0)
                                        : _showBalanceFigure
                                            ? '*****'
                                            : nairaAmount(balanceDetails!
                                                .walletBalance
                                                .toDouble()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: kWhiteColor),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_showBalanceFigure == true) {
                                        setState(() {
                                          _showBalanceFigure = false;
                                        });
                                      } else {
                                        setState(() {
                                          _showBalanceFigure = true;
                                        });
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      _showBalanceFigure
                                          ? eyeIcon
                                          : eyeSlashIcon,
                                      color: kWhiteColor,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(16)),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          SizedBox(height: getProportionateScreenHeight(30)),

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
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AllTransactionsScreen(
                                        isPendingTrx: true);
                                  }));
                                },
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
                                showErrorSnackBar(
                                    context, (state).errorMessage);
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
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: SpinKitWave(
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
                                                  getProportionateScreenHeight(
                                                      10),
                                            )
                                          ],
                                        ))
                                      : ListView.builder(
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              pendingTransaction!.length < 2
                                                  ? pendingTransaction!.length
                                                  : 2,
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
                                        );
                            },
                          ),

                          /// Recent Transactions
                          SizedBox(height: getProportionateScreenHeight(15)),
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
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AllTransactionsScreen(
                                        isPendingTrx: false);
                                  }));
                                },
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
                                showErrorSnackBar(
                                    context, (state).errorMessage);
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
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: SpinKitWave(
                                          color: kPrimaryColor,
                                          size:
                                              getProportionateScreenWidth(25)),
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
                                                    .copyWith(
                                                        color: kLightGrey),
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
                                          height:
                                              getProportionateScreenHeight(315),
                                          child: ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: transaction!.length < 3
                                                  ? transaction!.length
                                                  : 3,
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
                                                        ticketAmount:
                                                            nairaAmount(
                                                                transaction![
                                                                        index]
                                                                    .amount
                                                                    .toDouble()),
                                                        isDebit:
                                                            transaction![index]
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
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Transaction PIN Modal Sheet
  void _setPinBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              return false;
            },
            child: BlocConsumer<SetPinCubit, SetPinState>(
              listener: (context, state) {
                if (state is SetPinSuccess) {
                  Navigator.pop(context);
                  showSuccessSnackBar(
                      context, 'Transaction has been set Successfully');
                }
                if (state is SetPinFailure) {
                  errorText = (state).errorMessage;
                }
              },
              builder: (context, state) {
                if (state is SetPinLoading) {
                  errorText = null;
                  _setPinContoller.clear();
                  _confirmSetPinController.clear();
                  _isLoading = true;
                } else {
                  _isLoading = false;
                }
                return Container(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(20),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20),
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: kWhiteColor,
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Set Transaction PIN',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        Text(
                          'For you to be able to perform and view Transactions, you have to set a Transaction PIN',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                        const Center(child: Text('Enter Transaction PIN')),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Center(
                          child: Pinput(
                            controller: _setPinContoller,
                            onCompleted: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Cannot be Empty';
                              }
                              return null;
                            },
                            length: 4,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            defaultPinTheme: kDefaultPin(context),
                            focusedPinTheme: kFocusedPin(context),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),

                        /// Confirm Box
                        const Center(child: Text('Confirm Transaction PIN')),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Center(
                          child: Pinput(
                            controller: _confirmSetPinController,
                            onCompleted: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Cannot be Empty';
                              }
                              return null;
                            },
                            length: 4,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            defaultPinTheme: kDefaultPin(context),
                            focusedPinTheme: kFocusedPin(context),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        GeneralButton(
                            isLoading: _isLoading,
                            text: 'Continue',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (!_formkey.currentState!.validate()) return;
                              await BlocProvider.of<SetPinCubit>(context)
                                  .setPin({
                                "walletPin": int.parse(_setPinContoller.text),
                                "confirmWalletPin":
                                    int.parse(_confirmSetPinController.text)
                              });
                            }),
                        SizedBox(height: getProportionateScreenHeight(20))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
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
