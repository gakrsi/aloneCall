import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class TermsAndConditionsView extends StatefulWidget {
  @override
  _TermsAndConditionsViewState createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  Future loadDocument() async {
    document = await PDFDocument.fromAsset('assets/pdf/terms.pdf');
    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) => MaterialApp(
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Terms and conditions'),
            ),
            body: Center(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PDFViewer(
                scrollDirection: Axis.vertical,
                document: document,
                zoomSteps: 1,
              ),
            ),
          ),
        ),
      ),
    );
}