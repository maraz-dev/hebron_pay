// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/scan/presentation/pages/confirm_ticket_payment.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scanBarcode = "Unknown";

  /// Function to Scan Image
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get Platform Version.';
      showErrorSnackBar(context, barcodeScanRes);
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmTicketScreen(reference: _scanBarcode);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return DashBoard(
              currentIndex: 0,
            );
          }), (route) => false);
          return false;
        },
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              Center(
                child: Image.asset(
                  scanImage,
                  scale: 4,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(
                'Scan QR Code to Receive \nPayment',
                style: Theme.of(context).textTheme.displayMedium!,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20)),
                child: Text(
                  "Click the button below to scan the code on the sender’s receipt using your device camera. ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kDarkGrey),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: GeneralButton(
                  text: 'Scan Code',
                  onPressed: scanQR,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
