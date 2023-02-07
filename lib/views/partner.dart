import 'package:flutter/material.dart';

class Partner extends StatefulWidget {
  const Partner({super.key});

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text("Be Partner")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Firstname"),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Firstname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Lastname"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Lastname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Register'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushNamed(context, "/PartnerProfile");
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  dialog(context, _formKey.currentState));
                        },
                        child: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  dialog(context, formKey) {
    return AlertDialog(
        title: const Text("Reset Form?"),
        content: const Text("Reset all Form input"),
        actions: [
          ElevatedButton(
            child: const Text("reset form"),
            onPressed: () {
              formKey.reset();
              Navigator.pop(context);
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"))
        ]);
  }
}
