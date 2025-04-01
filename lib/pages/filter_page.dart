import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/diamond_bloc.dart';
import '../bloc/diamond_event.dart';
import 'result_page.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _caratFromController = TextEditingController();
  final _caratToController = TextEditingController();
  String _lab = '';
  String _shape = '';
  String _color = '';
  String _clarity = '';

  @override
  void initState() {
    super.initState();
    context.read<DiamondBloc>().add(LoadDiamonds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter Diamonds')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _caratFromController,
                decoration: InputDecoration(labelText: 'Carat From'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _caratToController,
                decoration: InputDecoration(labelText: 'Carat To'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Lab'),
                items: ['GIA', 'In-House', 'HRD'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => _lab = value ?? '',
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Shape'),
                items: ['BR', 'CU', 'EM', 'MQ', 'OV', 'PR', 'PS', 'RAD', 'HS'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => _shape = value ?? '',
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Color'),
                items: ['D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => _color = value ?? '',
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Clarity'),
                items: ['IF', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2', 'I1'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => _clarity = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<DiamondBloc>().add(FilterDiamonds(
                    caratFrom: double.tryParse(_caratFromController.text) ?? 0,
                    caratTo: double.tryParse(_caratToController.text) ?? double.infinity,
                    lab: _lab,
                    shape: _shape,
                    color: _color,
                    clarity: _clarity,
                  ));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage()));
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}