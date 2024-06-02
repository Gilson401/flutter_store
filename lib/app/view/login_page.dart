import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/auth_controller.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_store/util/assets_constants.dart';
import 'package:flutter_store/util/validator_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  final authController = Get.put(AuthController());

  @override
  void initState() {
    userNameController.text = "mor_2314";
    passwordController.text = "83r5^_";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _loginFormKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(AssetsConstants.logo),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Fake Store',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                    validator: (value) => ValidatorUtils.validateEmptyField(
                        context: context, name: value, fieldName: 'Username'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: obscureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          child: obscureText
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    validator: (value) => ValidatorUtils.validateEmptyField(
                        context: context, name: value, fieldName: 'Password'),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Obx(
                      () {
                        return authController.isLoading()
                            ? const CircularProgressIndicator()
                            : const Text('Login');
                      },
                    ),
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {

                        bool loginOk = await authController.login(
                            email: userNameController.text,
                            password: passwordController.text);
                        if (loginOk) {
                          Get.toNamed(Routes.home);
                        } else {
                          Get.snackbar("Erro ao logar", "Erro ao logar");
                        }
                      }
                    },
                  ),
                ).paddingSymmetric(vertical: 15),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton(
                      onPressed: () async {
                 
                        Get.toNamed(Routes.home);
                    
                      },
                      child: const Text('Sign in as a guest'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
