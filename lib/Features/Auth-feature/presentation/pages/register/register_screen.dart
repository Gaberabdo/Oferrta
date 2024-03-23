import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/otp-sceen.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/feeds_screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/generated/l10n.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/helper/cache/cache_helper.dart';

import '../../../../../core/helper/component/component.dart';
import '../../../../../core/responsive_screen.dart';
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
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigatorTo(context,  LayoutScreen());
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
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(8),
                              //     color: Colors.grey.shade200,
                              //   ),
                              //   child: InternationalPhoneNumberInput(
                              //     onInputChanged: (PhoneNumber number) {
                              //       phoneController.text = number.phoneNumber ?? '';
                              //
                              //     },
                              //     inputDecoration: InputDecoration(
                              //       hintText: S.of(context).Phone,
                              //       border: InputBorder.none,
                              //       filled: true,
                              //       fillColor: Colors.transparent,
                              //     ),
                              //     selectorConfig: SelectorConfig(
                              //       selectorType: PhoneInputSelectorType.DIALOG,
                              //       showFlags: true,
                              //     ),
                              //     ignoreBlank: false,
                              //     autoValidateMode: AutovalidateMode.disabled,
                              //     selectorTextStyle: TextStyle(color: Colors.black),
                              //     initialValue: PhoneNumber(
                              //       isoCode: widget.selectrdCountery,
                              //       dialCode: '+1', // Replace with the dial code of the selected country
                              //       phoneNumber: widget.phoneNumber,
                              //     ),
                              //     keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              //   ),
                              // ),
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
                                        cubit.registerWithEmailPassword(email: "${phoneController.text}@gmail.com",
                                            password: passwordController.text,
                                            name: nameController.text,
                                            context: context,
                                            phone: phoneController.text);
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //       return OtpScreen(
                                        //         phoneNumber:phoneController.text,
                                        //         email:
                                        //         '${phoneController.text}@gmail.com',
                                        //         name: nameController.text,
                                        //         password: passwordController.text,
                                        //       );
                                        //     }));
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
                                        color: Colors.grey.shade300,
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/face.png'),
                                          fit: BoxFit.cover,

                                        ),
                                      ),
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
                                    child:  Container(
                                      height: 55,
                                      width: 55,

                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade300,

                                      ),
                                      child: Image.asset('assets/images/119930_google_512x512.png'),
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
                centerTitle: true,
              ),
              body: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SafeArea(
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
                                              // Navigator.push(context,
                                              //     MaterialPageRoute(builder: (context) {
                                              //       return OtpScreen(
                                              //         phoneNumber:
                                              //         '+20${phoneController.text}',
                                              //         email:
                                              //         '${phoneController.text}@gmail.com',
                                              //         name: nameController.text,
                                              //         password: passwordController.text,
                                              //       );
                                              //     }));
                                              cubit.registerWithEmailPassword(email: "${phoneController.text}@gmail.com",
                                                  password: passwordController.text,
                                                  name: nameController.text,
                                                  context: context,
                                                  phone: phoneController.text);
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
                                              color: Colors.grey.shade300,
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/face.png'),
                                                fit: BoxFit.cover,

                                              ),
                                            ),
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
                                          child:  Container(
                                            height: 52,
                                            width: 52,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: Colors.grey.shade300,
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/119930_google_512x512.png'),
                                                fit: BoxFit.cover,

                                              ),
                                            ),
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
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/forms-concept-illustration_114360-4957.jpg?t=st=1710853200~exp=1710856800~hmac=7b34f64122e7e728c46576a1844b1e4e72b26e6aba7fec08ab862047380d3bb6&w=740'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
