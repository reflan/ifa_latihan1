import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormInput(),
    );
  }
}

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  TextEditingController var_tanggal = TextEditingController();

  String? _jk;
  void PilihJk(String value) {
    setState(() {
      _jk = value;
    });
  }

  List<String> agama = [
    "Islam",
    "Kristen Khatolik",
    "Kristen Protestan",
    "Hindu",
    "Budha",
    "Lainnya",
  ];

  String _agama = "Islam";

  void dispose() {
    var_tanggal.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.teal, // change primary color
            hintColor: Colors.teal, // change accent color
            colorScheme: ColorScheme.dark(primary: Colors.teal),
          ), // change theme to dark
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // var_tanggal.text = DateFormat.yMd().format(selectedDate);
        var_tanggal.text = formatDate(selectedDate).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text("Form Input"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Nama Lengkap",
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 3,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: "Alamat",
                labelText: "Alamat",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
              value: "Laki-laki",
              title: Text("Laki-laki"),
              groupValue: _jk,
              onChanged: (String? value) {
                PilihJk(value!);
              },
              activeColor: Colors.teal,
              subtitle: Text("Pilih ini jika laki-laki"),
            ),
            RadioListTile(
              value: "Perempuan",
              title: Text("Perempuan"),
              groupValue: _jk,
              onChanged: (String? value) {
                PilihJk(value!);
              },
              activeColor: Colors.teal,
              subtitle: Text("Pilih ini jika perempuan"),
            ),
            DropdownButton<String>(
              value: _agama,
              items: agama.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _agama = newValue!;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: var_tanggal,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Tanggal Lahir",
                labelText: "Tanggal Lahir",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
