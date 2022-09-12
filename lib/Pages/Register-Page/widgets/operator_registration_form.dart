import 'package:flutter/material.dart';

import '../../../Core/Utils/nittiv-color.dart';


class OperatorRegisterationForm extends StatelessWidget {
  OperatorRegisterationForm({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final _emailCtrl = TextEditingController();
  static final _businessNameCtrl = TextEditingController();
  static final _websiteLinkCtrl = TextEditingController();

  String? _validateEmail(String? email) {
    final emailPattern =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Field cannot be blank.';
    } else if (!emailPattern.hasMatch(email)) {
      return 'Invalid email.';
    }
    return null;
  }

  static BusinessCategory? selectedCategory;
  String? _validateCategory(BusinessCategory? category) {
    if (category == null) {
      return 'Please select a category';
    }
    return null;
  }

  final List<BusinessCategory> categories = const [
    BusinessCategory(name: 'Category 1'),
    BusinessCategory(name: 'Category 2'),
    BusinessCategory(name: 'Category 3'),
    BusinessCategory(name: 'Category 4'),
    BusinessCategory(name: 'Category 5'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!,width: 1),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Business Email'),
                ),
                TextFormField(
                  controller: _emailCtrl,
                  validator: _validateEmail,
                  decoration:  InputDecoration(
                    hintText: 'email@example.com',

                    hintStyle: TextStyle(color: Colors.grey[400]),
                    label: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: NittivColors.primaryGreen, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Business Name'),
                ),
                TextFormField(
                  controller: _businessNameCtrl,
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Field cannot be blank.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Your Business Name',

                    hintStyle: TextStyle(color: Colors.grey[400]),
                    label: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: NittivColors.primaryGreen, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Business Category'),
                ),
                DropdownButtonFormField<BusinessCategory>(
                  items: categories
                      .map(
                        (category) => DropdownMenuItem<BusinessCategory>(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (selected) {
                    selectedCategory = selected;
                  },
                  borderRadius: BorderRadius.circular(10),
                  //hint: const Text('Business Category'),

                  decoration:  InputDecoration(

                  ),
                  validator: _validateCategory,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Website/Social Link.'),
                ),
                TextFormField(
                  controller: _websiteLinkCtrl,
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Field cannot be blank.';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    hintText: 'www.example.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    label: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: NittivColors.primaryGreen, width: 2.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                colors: [
                  NittivColors.primaryGreen,
                  NittivColors.secondaryGreen,
                ],
              ),
            ),
            child: TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //TODO: Send Email Verification Request

                }
              },
              style: TextButton.styleFrom(
                fixedSize: const Size(double.infinity, 40),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                primary: Colors.white,
              ),
              child: const Text('REGISTER'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                fixedSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'REGISTER WITH GOOGLE',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO: MAKE A SEPERATE FILE FOR THIS
class BusinessCategory {
  final String name;

  const BusinessCategory({
    required this.name,
  });
}
