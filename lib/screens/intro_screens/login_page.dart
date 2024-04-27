// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scribe/db/functions/login_db_functions.dart';
import 'package:scribe/db/model/login_model.dart';
import 'package:scribe/screens/validations/validations.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  // Controller for controlling name
  final nameController = TextEditingController();

  // creating a key for form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // setting media query
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decoration images
              Column(
                children: [
                  Image.asset(
                    'assets/images/decoration_image_1.png',
                    // Media Query
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Spacer(),
                  Image.asset('assets/images/decoration_image_2.png',
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill),
                  Divider(
                    indent: 17,
                    endIndent: 17,
                    color: Color.fromARGB(255, 6, 0, 61),
                    thickness: 0.1,
                  )
                ],
              ),

              Column(
                children: [
                  const SizedBox(height: 193),
                  // lottie animation
                  Lottie.asset('assets/animations/hi_1.json',
                      frameRate: const FrameRate(60), width: 260),

                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What should we call you...',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,)),
                        // textfield for entering name
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            maxLength: 14,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // validation process
                            validator: (name) => Validators()
                                .validateField(name, 'Please enter any step'),
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Enter your name...',
                              labelStyle: Theme.of(context)
                                .textTheme
                                .labelLarge?.copyWith(color: Color.fromARGB(255, 153, 153, 153), fontSize: 16)
                            ),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  //** EXPLORE BUTTON
                  GestureDetector(
                    onTap: () {
                      // validation
                      _formKey.currentState!.validate();

                      // calling the checklogin function from Validators class and goto HomePage
                      Validators().checkLogin(context, nameController);

                      // Save to database
                      final userName = nameController.text.trim();
                      if (userName.isNotEmpty) {
                        final login = LoginModel(name: userName);
                        // calling the addLoginName function and passing the model
                        addLoginDetails(login);
                      }
                    },
                    child: Container(
                        width: 95,
                        height: 43,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromARGB(255, 6, 0, 61)),
                        child: Center(
                          child: Text(
                            'Explore',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18)
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
