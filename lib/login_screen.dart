import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Sign In to your account',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 30,
                        spreadRadius: -20,
                        offset: Offset(0, 20),
                      )
                    ]
                  ),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label:const Text(
                        'E-mail',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon:const  Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 30,
                        spreadRadius: -20,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon:const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: (){},
                  child:const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.red,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    child:const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0
                      ),
                    ),
                    TextButton(
                        onPressed: (){},
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0
                          ),
                        ),
                    ),
                  ],
                ),
                const Center (
                  child: Text(
                    'or',
                    style: TextStyle(
                        fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Row(
                  children: [
                     Container(
                       decoration: const BoxDecoration(
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey,
                             blurRadius: 30,
                             spreadRadius: -5,
                             offset: Offset(0, 10),
                           ),
                         ],
                       ),
                       child:const CircleAvatar(
                         radius: 30.0,
                        backgroundColor: Colors.white70,
                        child: Text(
                            'P',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                     ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
