import 'package:flutter/material.dart';

void main() {
  // Точка входу в додаток
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Конвертер Одиниць',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Основна тема
      ),
      home: Converter(), // Вказуємо, що домашня сторінка - це віджет Converter
    );
  }
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState(); // Створюємо стан для нашого віджета
}

class _ConverterState extends State<Converter> {
  // Змінні для зберігання введених значень
  String _kilometers = '';
  String _miles = '';
  String _inches = '';
  String _centimeters = '';
  String _acres = '';
  String _hectares = '';
  String _kilograms = '';
  String _pounds = '';
  String _liters = '';
  String _gallons = '';

  // Функція для конвертації кілометрів у милі
  void _convertToMiles() {
    if (_kilometers.isNotEmpty) {
      double km = double.parse(_kilometers);
      setState(() {
        _miles = (km * 0.621371).toStringAsFixed(2);
      });
    }
  }

  // Функція для конвертації миль у кілометри
  void _convertToKilometers() {
    if (_miles.isNotEmpty) {
      double mi = double.parse(_miles);
      setState(() {
        _kilometers = (mi / 0.621371).toStringAsFixed(2);
      });
    }
  }

  // Конвертація дюймів в сантиметри
  void _convertToCentimeters() {
    if (_inches.isNotEmpty) {
      double inches = double.parse(_inches);
      setState(() {
        _centimeters = (inches * 2.54).toStringAsFixed(2);
      });
    }
  }

  // Конвертація сантиметрів в дюйми
  void _convertToInches() {
    if (_centimeters.isNotEmpty) {
      double cm = double.parse(_centimeters);
      setState(() {
        _inches = (cm / 2.54).toStringAsFixed(2);
      });
    }
  }

  // Конвертація акрів в гектари
  void _convertToHectares() {
    if (_acres.isNotEmpty) {
      double acres = double.parse(_acres);
      setState(() {
        _hectares = (acres * 0.404686).toStringAsFixed(2);
      });
    }
  }

  // Конвертація гектарів в акри
  void _convertToAcres() {
    if (_hectares.isNotEmpty) {
      double hectares = double.parse(_hectares);
      setState(() {
        _acres = (hectares / 0.404686).toStringAsFixed(2);
      });
    }
  }

  // Конвертація кілограмів в фунти
  void _convertToPounds() {
    if (_kilograms.isNotEmpty) {
      double kg = double.parse(_kilograms);
      setState(() {
        _pounds = (kg * 2.20462).toStringAsFixed(2);
      });
    }
  }

  // Конвертація фунтів в кілограми
  void _convertToKilograms() {
    if (_pounds.isNotEmpty) {
      double pounds = double.parse(_pounds);
      setState(() {
        _kilograms = (pounds / 2.20462).toStringAsFixed(2);
      });
    }
  }

  // Конвертація літрів в галони
  void _convertToGallons() {
    if (_liters.isNotEmpty) {
      double liters = double.parse(_liters);
      setState(() {
        _gallons = (liters * 0.264172).toStringAsFixed(2);
      });
    }
  }

  // Конвертація галонів в літри
  void _convertToLiters() {
    if (_gallons.isNotEmpty) {
      double gallons = double.parse(_gallons);
      setState(() {
        _liters = (gallons / 0.264172).toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертор Одиниць'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildConverterField('Кілометри', 'Мілі', _kilometers, _miles, _convertToMiles, _convertToKilometers),
            _buildConverterField('Дюйми', 'Сантиметри', _inches, _centimeters, _convertToCentimeters, _convertToInches),
            _buildConverterField('Акри', 'Гектари', _acres, _hectares, _convertToHectares, _convertToAcres),
            _buildConverterField('Кілограми', 'Фунти', _kilograms, _pounds, _convertToPounds, _convertToKilograms),
            _buildConverterField('Літри', 'Галони', _liters, _gallons, _convertToGallons, _convertToLiters),
          ],
        ),
      ),
    );
  }

  // Створює віджет для вводу і конвертації
  Widget _buildConverterField(String label1, String label2, String value1, String value2, Function convert1, Function convert2) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: label1,
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              if (label1 == 'Кілометри') _kilometers = value;
              if (label1 == 'Дюйми') _inches = value;
              if (label1 == 'Акри') _acres = value;
              if (label1 == 'Кілограми') _kilograms = value;
              if (label1 == 'Літри') _liters = value;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => convert1(),
          child: Text('Конвертувати в $label2'),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: label2,
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              if (label2 == 'Мілі') _miles = value;
              if (label2 == 'Сантиметри') _centimeters = value;
              if (label2 == 'Гектари') _hectares = value;
              if (label2 == 'Фунти') _pounds = value;
              if (label2 == 'Галони') _gallons = value;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => convert2(),
          child: Text('Конвертувати в $label1'),
        ),
        SizedBox(height: 20),
        Text(
          value2.isNotEmpty ? 'Результат: $value2 $label2' : '',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          value1.isNotEmpty ? 'Результат: $value1 $label1' : '',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}