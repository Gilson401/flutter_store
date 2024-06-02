import 'package:flutter/material.dart';
import 'package:flutter_store/app/model/user_manager.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:flutter_store/util/text_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_store/app/controller/auth_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Obx(() {
      UserManager? user = authController.user.value;

      if (user == null) {
        return const SizedBox.shrink();
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Dados do Usuário'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                user.photoUrl != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.photoUrl!),
                      )
                    : const Icon(
                        Icons.person,
                        size: 100,
                      ),
                const SizedBox(height: 20),
                Text(
                  "${user.name!.firstname!} ${user.name!.lastname}",
                  style: AppTextStyles.s40w500cGray,
                ),
                const SizedBox(height: 10),
                user.email != null
                    ? Text('Email: ${user.email}')
                    : const Text('Email indisponível'),
                const SizedBox(height: 10),
                user.phone != null
                    ? Text('Telefone: ${user.phone}')
                    : const Text('Telefone indisponível'),
                const SizedBox(height: 10),
                user.address?.city != null
                    ? Text('Cidade: ${user.address?.city}')
                    : const Text('Cidade indisponível'),
                const SizedBox(height: 10),
                user.address?.street != null
                    ? Row(
                        children: [
                          Text('Endereço: ${user.address?.street}'),
                          if (user.address?.number != null)
                            Text(' ${user.address?.number}'),
                        ],
                      )
                    : const Text('Endereço indisponível'),
                const SizedBox(height: 10),
                user.address?.zipcode != null
                    ? Text('CEP: ${user.address?.zipcode}')
                    : const Text('CEP indisponível'),
                ElevatedButton(
                    onPressed: () async {
                      await authController.logOff();
                      Get.toNamed(Routes.login);
                    },
                    child: const Text('Sair')).paddingOnly(top: 10)
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            const BottomBar(isElevated: false, isVisible: true),
      );
    });
  }
}
