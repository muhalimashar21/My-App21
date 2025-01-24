import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const kTextGray = Color(0xFF787878);
const baseUrl2 = 'https://api.connectis.my.id/';
const baseUrl = 'https://mysolonet.connectis.my.id/';

const kPrimaryColor = Color(0xFF27B2D1);
const kColorUtama =  Color(0xFF27B2D1);

String formatRupiah(int amount) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  return formatter.format(amount);
}

String formatAngka(int amount) {
  final formatter = NumberFormat.decimalPattern('id_ID');
  return formatter.format(amount);
}