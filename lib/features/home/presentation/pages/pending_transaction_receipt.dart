// ignore_for_file: deprecated_member_use

import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_pending_transactions_cubit/pending_transactions_cubit.dart';
import 'package:hebron_pay/size_config.dart';

class PendingTransactionReceipt extends StatefulWidget {
  PendingTransactionReceipt({super.key, required this.position});
  static const id = "/pendingTransactionReceipt";
  final int position;

  @override
  State<PendingTransactionReceipt> createState() =>
      _PendingTransactionReceiptState();
}

class _PendingTransactionReceiptState extends State<PendingTransactionReceipt> {
  ///Variable to hold the Pending Transaction List
  List<PendingTransactionEntity>? pendingTransaction;

  /// Get Pending Transactions
  void _getPendingTransaction() async {
    var res = await BlocProvider.of<PendingTransactionsCubit>(context)
        .getPendingTransactions();
    pendingTransaction = res;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getPendingTransaction();
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
          'Pending Transaction Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: BlocConsumer<PendingTransactionsCubit, PendingTransactionsState>(
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
                    child: SpinKitWanderingCubes(
                      color: kPrimaryColor,
                      size: getProportionateScreenWidth(50),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(20)),

                      /// QR Image
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: pendingTransaction![widget.position].reference,
                          width: getProportionateScreenWidth(220),
                          height: getProportionateScreenHeight(220),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),

                      /// Details Box
                      Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kLightGrey),
                        child: Column(
                          children: [
                            TicketDetailsProps(
                              propertyName: 'Narration',
                              value: pendingTransaction![widget.position]
                                  .description,
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Amount',
                              value: nairaAmount(
                                  pendingTransaction![widget.position]
                                      .amount
                                      .toDouble()),
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Reference',
                              value: pendingTransaction![widget.position]
                                  .reference,
                            ),
                            const TicketDivider(),
                            TicketDetailsProps(
                              propertyName: 'Date/Time',
                              value:
                                  '${pendingTransaction![widget.position].date} ${pendingTransaction![widget.position].time}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      GeneralButton(text: 'Download Receipt', onPressed: () {}),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      DeleteReceiptButton(
                          text: 'Delete Receipt', onPressed: () {})
                    ],
                  );
          },
        ),
      ),
    );
  }
}
