import 'dart:typed_data';

import 'package:amritha_ayurveda/gen/assets.gen.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Data class holding all info needed to generate a receipt PDF.
class ReceiptData {
  final String patientName;
  final String address;
  final String whatsappNumber;
  final String bookedOnDate;
  final String bookedOnTime;
  final String treatmentDate;
  final String treatmentTime;
  final Branch branch;
  final List<ReceiptTreatmentItem> treatments;
  final String totalAmount;
  final String discountAmount;
  final String advanceAmount;
  final String balanceAmount;

  const ReceiptData({
    required this.patientName,
    required this.address,
    required this.whatsappNumber,
    required this.bookedOnDate,
    required this.bookedOnTime,
    required this.treatmentDate,
    required this.treatmentTime,
    required this.branch,
    required this.treatments,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
  });
}

class ReceiptTreatmentItem {
  final String name;
  final String price;
  final int maleCount;
  final int femaleCount;
  final String total;

  const ReceiptTreatmentItem({
    required this.name,
    required this.price,
    required this.maleCount,
    required this.femaleCount,
    required this.total,
  });
}

class ReceiptPdfGenerator {
  ReceiptPdfGenerator._();

  static Future<Uint8List> generate(ReceiptData data) async {
    // Load fonts
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/poppins/Poppins-Regular.ttf'),
    );
    final medium = pw.Font.ttf(
      await rootBundle.load('assets/fonts/poppins/Poppins-Medium.ttf'),
    );
    final semiBold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/poppins/Poppins-SemiBold.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/poppins/Poppins-Bold.ttf'),
    );

    // Load SVG logo
    final svgLogo = await rootBundle.loadString(Assets.svgs.splashLogo);

    final green = PdfColor.fromHex('#006837');
    final grey = PdfColor.fromHex('#666666');
    final lightGrey = PdfColor.fromHex('#999999');
    final darkText = PdfColor.fromHex('#333333');

    final formatter = NumberFormat('#,##0', 'en_IN');

    String formatAmount(String amount) {
      final parsed = double.tryParse(amount) ?? 0;
      return formatter.format(parsed.toInt());
    }

    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColor.fromHex('#4CAF50'),
                width: 2,
              ),
            ),
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // ─── Header ───────────────────────────────────────────
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Logo
                    pw.Container(
                      width: 80,
                      height: 85,
                      child: pw.SvgImage(svg: svgLogo),
                    ),
                    pw.Spacer(),
                    // Branch details
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          data.branch.name.toUpperCase(),
                          style: pw.TextStyle(
                            font: bold,
                            fontSize: 14,
                            color: darkText,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          data.branch.address,
                          style: pw.TextStyle(
                            font: regular,
                            fontSize: 8,
                            color: grey,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'e-mail: ${data.branch.mail}',
                          style: pw.TextStyle(
                            font: regular,
                            fontSize: 8,
                            color: grey,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'Mob: ${data.branch.phone}',
                          style: pw.TextStyle(
                            font: regular,
                            fontSize: 8,
                            color: grey,
                          ),
                        ),
                        if (data.branch.gst.isNotEmpty) ...[
                          pw.SizedBox(height: 2),
                          pw.Text(
                            'GST No: ${data.branch.gst}',
                            style: pw.TextStyle(
                              font: medium,
                              fontSize: 8,
                              color: darkText,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300, height: 0.5),
                pw.SizedBox(height: 16),

                // ─── Patient Details ──────────────────────────────────
                pw.Text(
                  'Patient Details',
                  style: pw.TextStyle(
                    font: semiBold,
                    fontSize: 13,
                    color: green,
                  ),
                ),
                pw.SizedBox(height: 12),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Left column: patient info
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _labelValue(
                            'Name',
                            data.patientName,
                            medium,
                            regular,
                            darkText,
                            grey,
                          ),
                          pw.SizedBox(height: 6),
                          _labelValue(
                            'Address',
                            data.address,
                            medium,
                            regular,
                            darkText,
                            grey,
                          ),
                          pw.SizedBox(height: 6),
                          _labelValue(
                            'WhatsApp Number',
                            data.whatsappNumber,
                            medium,
                            regular,
                            darkText,
                            grey,
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    // Right column: dates
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                'Booked On',
                                style: pw.TextStyle(
                                  font: medium,
                                  fontSize: 9,
                                  color: darkText,
                                ),
                              ),
                              pw.SizedBox(width: 12),
                              pw.Text(
                                data.bookedOnDate,
                                style: pw.TextStyle(
                                  font: regular,
                                  fontSize: 9,
                                  color: grey,
                                ),
                              ),
                              pw.SizedBox(width: 8),
                              pw.Text(
                                '|',
                                style: pw.TextStyle(
                                  font: regular,
                                  fontSize: 9,
                                  color: lightGrey,
                                ),
                              ),
                              pw.SizedBox(width: 8),
                              pw.Text(
                                data.bookedOnTime,
                                style: pw.TextStyle(
                                  font: regular,
                                  fontSize: 9,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 6),
                          _labelValue(
                            'Treatment Date',
                            data.treatmentDate,
                            medium,
                            regular,
                            darkText,
                            grey,
                          ),
                          pw.SizedBox(height: 6),
                          _labelValue(
                            'Treatment Time',
                            data.treatmentTime,
                            medium,
                            regular,
                            darkText,
                            grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300, height: 0.5),
                pw.SizedBox(height: 16),

                // ─── Treatments Table ─────────────────────────────────
                // Header row
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Treatment',
                          style: pw.TextStyle(
                            font: semiBold,
                            fontSize: 11,
                            color: green,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          'Price',
                          style: pw.TextStyle(
                            font: semiBold,
                            fontSize: 11,
                            color: green,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          'Male',
                          style: pw.TextStyle(
                            font: semiBold,
                            fontSize: 11,
                            color: green,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          'Female',
                          style: pw.TextStyle(
                            font: semiBold,
                            fontSize: 11,
                            color: green,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(
                            font: semiBold,
                            fontSize: 11,
                            color: green,
                          ),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 4),

                // Treatment rows
                ...data.treatments.map((t) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            t.name,
                            style: pw.TextStyle(
                              font: regular,
                              fontSize: 10,
                              color: darkText,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            '\u20B9${formatAmount(t.price)}',
                            style: pw.TextStyle(
                              font: regular,
                              fontSize: 10,
                              color: darkText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            t.maleCount.toString(),
                            style: pw.TextStyle(
                              font: regular,
                              fontSize: 10,
                              color: darkText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            t.femaleCount.toString(),
                            style: pw.TextStyle(
                              font: regular,
                              fontSize: 10,
                              color: darkText,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            '\u20B9${formatAmount(t.total)}',
                            style: pw.TextStyle(
                              font: regular,
                              fontSize: 10,
                              color: darkText,
                            ),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                pw.SizedBox(height: 16),
                pw.Divider(color: PdfColors.grey300, height: 0.5),
                pw.SizedBox(height: 16),

                // ─── Totals Section ───────────────────────────────────
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 220,
                      child: pw.Column(
                        children: [
                          _totalRow(
                            'Total Amount',
                            formatAmount(data.totalAmount),
                            semiBold,
                            bold,
                            darkText,
                          ),
                          pw.SizedBox(height: 6),
                          _totalRow(
                            'Discount',
                            formatAmount(data.discountAmount),
                            regular,
                            regular,
                            grey,
                          ),
                          pw.SizedBox(height: 6),
                          _totalRow(
                            'Advance',
                            formatAmount(data.advanceAmount),
                            regular,
                            regular,
                            grey,
                          ),
                          pw.SizedBox(height: 10),
                          pw.Divider(color: PdfColors.grey300, height: 0.5),
                          pw.SizedBox(height: 10),
                          _totalRow(
                            'Balance',
                            formatAmount(data.balanceAmount),
                            semiBold,
                            bold,
                            darkText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.Spacer(),

                // ─── Footer ───────────────────────────────────────────
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'Thank you for choosing us',
                        style: pw.TextStyle(
                          font: semiBold,
                          fontSize: 16,
                          color: green,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        "Your well-being is our commitment, and we're honored",
                        style: pw.TextStyle(
                          font: regular,
                          fontSize: 8,
                          color: lightGrey,
                        ),
                      ),
                      pw.Text(
                        "you've entrusted us with your health journey",
                        style: pw.TextStyle(
                          font: regular,
                          fontSize: 8,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 30),
                // Dashed divider line
                pw.Container(
                  width: double.infinity,
                  height: 0.5,
                  child: pw.Row(
                    children: List.generate(80, (i) {
                      return pw.Expanded(
                        child: pw.Container(
                          height: 0.5,
                          color: i.isEven ? PdfColors.grey400 : PdfColors.white,
                        ),
                      );
                    }),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    '"Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment"',
                    style: pw.TextStyle(
                      font: regular,
                      fontSize: 7,
                      color: lightGrey,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _labelValue(
    String label,
    String value,
    pw.Font labelFont,
    pw.Font valueFont,
    PdfColor labelColor,
    PdfColor valueColor,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 110,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              font: labelFont,
              fontSize: 9,
              color: labelColor,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: pw.TextStyle(
              font: valueFont,
              fontSize: 9,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _totalRow(
    String label,
    String amount,
    pw.Font labelFont,
    pw.Font amountFont,
    PdfColor color,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(font: labelFont, fontSize: 10, color: color),
        ),
        pw.Text(
          '\u20B9$amount',
          style: pw.TextStyle(font: amountFont, fontSize: 10, color: color),
        ),
      ],
    );
  }
}
