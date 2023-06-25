import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/ticket_details_properties.dart';
import 'package:hebron_pay/core/widgets/ticket_divider.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';
import 'package:hebron_pay/features/scan/presentation/bloc/get_scanned_trx_cubit/get_scanned_trx_cubit.dart';
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
                        : Column(
                            children: [
                              TicketDetailsProps(
                                propertyName: 'Username',
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
                                value:
                                    nairaAmount(trxDetails!.amount.toDouble()),
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
                  GeneralButton(
                    text: 'Confirm Payment',
                    onPressed: () {},
                    isLoading: _isLoading,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
