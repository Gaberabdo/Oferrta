import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/register_screen.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../core/responsive_screen.dart';
import '../../../../../generated/l10n.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({super.key});

  var phoneController = TextEditingController();
  var globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return ResponsiveScreen(
      mobileScreen: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            S.of(context).CreateAccount,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: globalFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return S.of(context).pleasePhone;
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: S.of(context).Phone,
                    labelStyle: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      // Set the border radius
                      borderSide: BorderSide.none, // Remove the border
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorStyle.primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: MaterialButton(
                    onPressed: () {
                      if (globalFormKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen(
                            phoneNumber: phoneController.text,
                          );
                        }));
                      }
                    },
                    child: Text(
                      S.of(context).completeSignUp,
                      style: GoogleFonts.tajawal(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      desktopScreen: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            S.of(context).CreateAccount,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child:  Form(
                key: globalFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return S.of(context).pleasePhone;
                          }
                          return null;
                        },
                        keyboardAppearance: Brightness.dark,
                        decoration: InputDecoration(
                          labelText: S.of(context).Phone,
                          labelStyle: GoogleFonts.tajawal(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Set the border radius
                            borderSide:
                                BorderSide.none, // Remove the border
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorStyle.primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: MaterialButton(
                          onPressed: () {
                            if (globalFormKey.currentState!.validate()) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterScreen(
                                  phoneNumber: phoneController.text,
                                );
                              }));
                            }
                          },
                          child: Text(
                            S.of(context).completeSignUp,
                            style: GoogleFonts.tajawal(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ),
            Expanded(
              flex: 3,
              child: Image(

                image: NetworkImage(
                    'https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?t=st=1710852981~exp=1710856581~hmac=b5d15464b0c1f454104d8dceb0c5e58e6af4746d399cc3eb8669b709ba9a6c17&w=740'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
