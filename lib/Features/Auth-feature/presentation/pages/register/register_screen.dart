import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/otp-sceen.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/feeds_screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/generated/l10n.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/helper/cache/cache_helper.dart';

import '../../../../../core/helper/component/component.dart';
import '../login/login_screen.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({required this.phoneNumber});

  String phoneNumber;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    print(widget.phoneNumber);
    phoneController.text = widget.phoneNumber;
    super.initState();
  }

  var globalFormKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessRegisterState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Register success',
              ),
            );
            CacheHelper.saveData(key: 'uId', value:state.uId);
            navigatorTo(context, const LayoutScreen());
          }
          if (state is ErrorVerifyState) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.errorMessage!,
              ),
            );
          }
          if (state is ErrorRegisterState) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: 'Error in Register',
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                S.of(context).CreateAccount,
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return S.of(context).pleaseName;
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                labelText: S.of(context).Name,
                                labelStyle: GoogleFonts.tajawal(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
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
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return S.of(context).pleaseEmail;
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                labelText: S.of(context).Email,
                                labelStyle: GoogleFonts.tajawal(
                                    fontSize: 20, color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
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
                              height: 10,
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
                                    fontSize: 20, color: Colors.black),
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
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: passwordController,
                              obscureText: cubit.isPassword,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return S.of(context).pleasePassword;
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                labelText: S.of(context).Password,
                                labelStyle: GoogleFonts.tajawal(
                                    fontSize: 20, color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    cubit.suffix,
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
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
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoadingRegisterState,
                              builder: (context) => Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorStyle.primaryColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (globalFormKey.currentState!
                                        .validate()) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return OtpScreen(
                                          phoneNumber:
                                              '+20${phoneController.text}',
                                          email:
                                              '${phoneController.text}@gmail.com',
                                          name: nameController.text,
                                          password: passwordController.text,
                                        );
                                      }));
                                    }
                                  },
                                  child: Text(
                                    S.of(context).CreateAccount,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black54,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).alreadyHaveAccount,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  },
                                  child: Text(S.of(context).signIn,
                                      style: GoogleFonts.tajawal(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  S.of(context).Or,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.signInWithFacebook(
                                        phoneNumber: phoneController.text);
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade300),
                                    child: const Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 35,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.signInWithGoogle(
                                        phoneNumber: phoneController.text);
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade300),

                                    child: const Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 30,
                                    )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
