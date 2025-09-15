// travel_booklet_generator.dart
//
// Single-file PDF booklet generator for a Travel entity (A5 pages).
// Uses `package:pdf` (pdf: ^ version compatible).

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../entities/travel.dart';
import '../entities/vehicles.dart';

/// Main entry: generate the PDF bytes and optionally save to disk.
Future<Uint8List> generateTravelBookletPdf(
  Travel travel, {
  String? savePath,
}) async {
  final pdfDoc = pw.Document();

  // --- Helper: preload image or return placeholder ---
  Future<pw.Widget> loadImage(
    String? path, {
    double? height,
    double? width,
  }) async {
    if (path == null || path.isEmpty) {
      return pw.Container(
        height: height ?? 80,
        width: width ?? 80,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
        child: pw.Text('No photo', style: pw.TextStyle(fontSize: 10)),
      );
    }
    try {
      final bytes = await File(path).readAsBytes();
      final img = pw.MemoryImage(bytes);
      return pw.Image(img, height: height, width: width, fit: pw.BoxFit.cover);
    } catch (_) {
      return pw.Container(
        height: height ?? 80,
        width: width ?? 80,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
        child: pw.Text('No photo', style: pw.TextStyle(fontSize: 10)),
      );
    }
  }

  // --- Preload all images ---
  final mainPictureWidget = await loadImage(
    travel.mainPicture,
    height: 150,
    width: 200,
  );
  final participantImages = await Future.wait(
    travel.membersList.map(
      (p) => loadImage(p.profilePicture, height: 80, width: 80),
    ),
  );
  final stopImages = await Future.wait(
    travel.travelStopList.map(
      (s) => loadImage(s.stopPicture, height: 120, width: 160),
    ),
  );

  // --- Helper: format DateTime ---
  String formatDate(DateTime? d) {
    if (d == null) return '-';
    return '${d.year.toString().padLeft(4,
        '0')}-${d.month.toString().padLeft(2,
        '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  // --- Helper: vehicle label ---
  String vehicleLabel(Vehicles v) {
    switch (v) {
      case Vehicles.car:
        return 'Car';
      case Vehicles.boat:
        return 'Boat';
      case Vehicles.train:
        return 'Train';
      case Vehicles.bus:
        return 'Bus';
      case Vehicles.airplane:
        return 'Airplane';
      default:
        return 'Not selected';
    }
  }

  // --- Cover page ---
  pdfDoc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a5,
      margin: const pw.EdgeInsets.all(16),
      build: (context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            mainPictureWidget,
            pw.SizedBox(height: 12),
            pw.Text(
              travel.travelName,
              style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Period: ${formatDate(travel.origin.departureDate)} '
                  '— ${formatDate(travel.finish.arrivalDate)}',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              'Transport: ${vehicleLabel(travel.desiredVehicle)}',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.Spacer(),
            pw.Text(travel.description, textAlign: pw.TextAlign.center),
          ],
        );
      },
    ),
  );

  // --- Participants page ---
  pdfDoc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: const pw.EdgeInsets.all(12),
      footer: (context) => pw.Text('Participants — page ${context.pageNumber}'),
      build: (context) {
        final children = <pw.Widget>[];
        children.add(pw.Header(level: 1, text: 'Participants'));
        children.add(pw.SizedBox(height: 6));

        const cols = 3;
        final rows = <pw.Widget>[];
        for (var i = 0; i < travel.membersList.length; i += cols) {
          final rowChildren = <pw.Widget>[];
          for (var c = 0; c < cols; c++) {
            final index = i + c;
            if (index < travel.membersList.length) {
              rowChildren.add(
                pw.Expanded(
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      participantImages[index],
                      pw.SizedBox(height: 6),
                      pw.Text(
                        travel.membersList[index].name,
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              rowChildren.add(pw.Expanded(child: pw.Container()));
            }
          }
          rows.add(pw.Row(children: rowChildren));
        }

        if (travel.membersList.isEmpty) {
          children.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12),
              child: pw.Text('No participants available'),
            ),
          );
        } else {
          children.addAll(rows);
        }

        return children;
      },
    ),
  );

  // For stops:
  for (var i = 0; i < travel.travelStopList.length; i++) {
    final stop = travel.travelStopList[i];
    final stopImage = stopImages[i];

    pdfDoc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(12),
        footer: (context) =>
            pw.Text('Stop ${i + 1} — page ${context.pageNumber}'),
        build: (context) {
          final widgets = <pw.Widget>[];
          widgets.add(
            pw.Header(
              level: 2,
              text: 'Stop ${i + 1}: ${stop.destination.city}',
            ),
          );
          widgets.add(
            pw.Text(
              'Period: ${formatDate(stop.arrival)} —'
                  ' ${formatDate(stop.departure)}',
            ),
          );
          widgets.add(pw.SizedBox(height: 8));
          widgets.add(
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(flex: 2, child: stopImage),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Description:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(stop.description),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Comments:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 6),
                      if (stop.comments.isEmpty)
                        pw.Text('No comments for this stop.')
                      else
                        for (final c in stop.comments)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                '${c.person.name} (${c.person.age})',
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                c.text,
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(height: 6),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          );
          return widgets;
        },
      ),
    );
  }

  // --- Final page ---
  pdfDoc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a5,
      margin: const pw.EdgeInsets.all(16),
      build: (context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            mainPictureWidget,
            pw.SizedBox(height: 12),
            pw.Text(
              '“A trip is not measured in miles,'
                  ' but in moments. Each page of this booklet keeps more than '
                  'landscapes: they are spontaneous smiles, '
                  'unexpected discoveries, conversations that '
                  'stayed in the soul and silences that spoke louder '
                  'than words.”',
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 12),
            pw.Text(
              '- Marcelo',
              style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
            ),
          ],
        );
      },
    ),
  );

  final bytes = await pdfDoc.save();

  if (savePath != null && savePath.isNotEmpty) {
    try {
      await File(savePath).writeAsBytes(bytes);
    } catch (_) {}
  }

  return bytes;
}
