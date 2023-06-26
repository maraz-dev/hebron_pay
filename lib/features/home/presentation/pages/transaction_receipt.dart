// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:hebron_pay/size_config.dart';

class TransactionReceipt extends StatefulWidget {
  const TransactionReceipt({super.key, required this.position});
  static const id = "/transactionReceipt";
  final int position;

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
  ///Variable to hold the Pending Transaction List
  List<TransactionEntity>? transaction;

  /// Get Pending Transactions
  void _getTransaction() async {
    var res =
        await BlocProvider.of<TransactionCubit>(context).getTransactions();
    transaction = res;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTransaction();
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
          'Transaction Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),

            /// QR Image
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(90)),
              child: Image.asset(splashLogo),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),

            /// Details Box
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: kLightGrey),
              child: BlocConsumer<TransactionCubit, TransactionState>(
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
                          child: SpinKitWanderingCubes(
                            color: kPrimaryColor,
                            size: getProportionateScreenWidth(50),
                          ),
                        )
                      : Column(
                          children: [
                            TicketDetailsProps(
                              propertyName: 'Narration',
                              value: transaction![widget.position].description,
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Amount',
                              value: nairaAmount(transaction![widget.position]
                                  .amount
                                  .toDouble()),
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Reference',
                              value: transaction![widget.position].reference,
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Date/Time',
                              value:
                                  '${transaction![widget.position].date} ${transaction![widget.position].time}',
                            ),
                          ],
                        );
                },
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            // GeneralButton(text: 'Download Receipt', onPressed: () {}),
            SizedBox(height: getProportionateScreenHeight(10)),
          ],
        ),
      ),
    );
  }
}
