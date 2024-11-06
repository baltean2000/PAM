import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schimb Valutar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String _fromCurrency = 'MDL';
  String _toCurrency = 'USD';
  double _exchangeRate = 17.65; // Cursul fixat
  double _amount = 0.0;
  double _convertedAmount = 0.0;

  final TextEditingController _controller = TextEditingController();

  // Funcția pentru a efectua conversia
  void _convertCurrency() {
    setState(() {
      _amount = double.tryParse(_controller.text) ?? 0.0;
      if (_fromCurrency == 'MDL' && _toCurrency == 'USD') {
        _convertedAmount = _amount / _exchangeRate;
      } else if (_fromCurrency == 'USD' && _toCurrency == 'MDL') {
        _convertedAmount = _amount * _exchangeRate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Fără umbră sub AppBar
        title: Text(
          'Schimb Valutar',
          style: TextStyle(
            color: Colors.indigo.shade800, // Culoare similară cu imaginea
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: _fromCurrency,
                          items: [
                            DropdownMenuItem(
                              value: 'MDL',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/flags/mdl.png', // Flag image for MDL
                                    width: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text('MDL'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'USD',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/flags/usd.png', // Flag image for USD
                                    width: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text('USD'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _fromCurrency = value!;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '1000.00',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.sync_alt, size: 45, color: Colors.indigo.shade800),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: _toCurrency,
                          items: [
                            DropdownMenuItem(
                              value: 'USD',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/flags/usd.png', // Flag image for USD
                                    width: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text('USD'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'MDL',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/flags/mdl.png', // Flag image for MDL
                                    width: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text('MDL'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _toCurrency = value!;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            _convertedAmount.toStringAsFixed(2),
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rata schimbului valutar',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              '1 USD = $_exchangeRate MDL',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade800, // Color similar to the image
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _convertCurrency,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                child: Text('Convert', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
