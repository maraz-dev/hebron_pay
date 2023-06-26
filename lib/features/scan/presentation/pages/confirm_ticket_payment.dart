import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/ticket_details_properties.dart';
import 'package:hebron_pay/core/widgets/ticket_divider.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';
import 'package:hebron_pay/features/scan/presentation/bloc/confirm_payment_cubit/confirm_payment_cubit.dart';
import 'package:hebron_pay/features/scan/presentation/bloc/get_scanned_trx_cubit/get_scanned_trx_cubit.dart';
import 'package:hebron_pay/features/scan/presentation/pages/scan.dart';
import 'package:hebron_pay/size_config.dart';

class ConfirmTicketScreen extends StatefulWidget {
  const ConfirmTicketScreen({super.key, required this.reference});
  final String reference;

  @override
  State<ConfirmTicketScreen> createState() => _ConfirmTicketScreenState();
}

class _ConfirmTicketScreenState extends State<ConfirmTicketScreen> {
  GetTrxEntity? trxDetails;
  bool _isLoading = false;

  void _getTrxDetails() async {
    var response = await BlocProvider.of<GetScannedTrxCubit>(context)
        .getScannedDetails(widget.reference);
    trxDetails = response;
  }

  @override
  void initState() {
    super.initState();
    _getTrxDetails();
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
          'Confirm Payment Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(30)),
          child: BlocConsumer<GetScannedTrxCubit, GetScannedTrxState>(
            listener: (context, state) {
              if (state is GetScannedTrxFailure) {
                showErrorSnackBar(context, (state).errorMessage);
              }
            },
            builder: (context, state) {
              if (state is GetScannedTrxLoading) {
                _isLoading = true;
              } else {
                _isLoading = false;
              }
              if (state is GetScannedTrxSucccess) {
                trxDetails = (state).scannedDetails;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Confirm the Details of the Transaction you just Scanned Below:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 22),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightGrey),
                    child: _isLoading
                        ? Center(
                            child: SpinKitWanderingCubes(
                              color: kPrimaryColor,
                              size: getProportionateScreenWidth(50),
                            ),
                          )
                        : trxDetails == null
                            ? Center(
                                child: Column(
                                children: [
                                  Text(
                                    "Unable to get Transaction at this moment \n Check your Internet Connection or Scan again...",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: kBlackColor),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  )
                                ],
                              ))
                            : Column(
                                children: [
                                  TicketDetailsProps(
                                    propertyName: "Sender's Name",
                                    isImportant: true,
                                    value: trxDetails!.username,
                                  ),
                                  const TicketDivider(),
                                  TicketDetailsProps(
                                    propertyName: 'Narration',
                                    value: trxDetails!.description,
                                  ),
                                  const TicketDivider(),
                                  TicketDetailsProps(
                                    propertyName: 'Amount',
                                    isImportant: true,
                                    value: nairaAmount(
                                        trxDetails!.amount.toDouble()),
                                  ),
                                  const TicketDivider(),
                                  TicketDetailsProps(
                                    propertyName: 'Reference',
                                    value: trxDetails!.reference,
                                  ),
                                  const TicketDivider(),
                                  TicketDetailsProps(
                                    propertyName: 'Date/Time',
                                    value:
                                        '${trxDetails!.date} / ${trxDetails!.time}',
                                  ),
                                ],
                              ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  BlocConsumer<ConfirmPaymentCubit, ConfirmPaymentState>(
                    listener: (context, state) {
                      if (state is ConfirmPaymentSuccess) {
                        showSuccessSnackBar(context,
                            'Payment Confirmed and your Wallet has been Credited');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashBoard(
                            currentIndex: 1,
                          );
                        }));
                      }
                      if (state is ConfirmPaymentFailure) {
                        showErrorSnackBar(context, (state).errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is ConfirmPaymentLoading) {
                        _isLoading = true;
                      } else {
                        _isLoading = false;
                      }
                      return GeneralButton(
                        text: 'Confirm Payment',
                        onPressed: _confirmPayment,
                        isLoading: _isLoading,
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _confirmPayment() async {
    await BlocProvider.of<ConfirmPaymentCubit>(context).confirmPayment({
      "id": trxDetails!.id,
      "description": trxDetails!.description,
      "amount": trxDetails!.amount,
      "reference": trxDetails!.reference,
      "type": trxDetails!.type,
      "date": trxDetails!.date,
      "time": trxDetails!.time,
      "hebronPayWalletId": trxDetails!.id,
      "hebronPayWallet": {
        "id": 0,
        "walletBalance": 0,
        "walletPin": 0,
      }
    });
  }
}
