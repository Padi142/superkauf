import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/login/bloc/login_state.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/countries/view/countries_picker.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';
import 'package:superkauf/library/app_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../library/app.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends Screen<String> {
  static const String name = ScreenPath.loginScreen;

  LoginScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    final supabase = Supabase.instance.client;
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        BlocProvider.of<LoginBloc>(context).add(const CreateUserProfile());

        if (widget.params == null) {
          BlocProvider.of<NavigationBloc>(context).add(const OpenProfileScreen(shouldReplace: true));
        } else {
          BlocProvider.of<LoginBloc>(context).add(GoBack(path: widget.params!));
        }
      }
      BlocProvider.of<CountriesBloc>(context).add(const GetCountries());
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    super.initState();
  }

  bool showLogin = false;
  bool showRegister = false;
  late final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   title: Text('login_page_title'.tr()),
        // ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Lottie.asset(
                    'assets/lottie/lottie_login_1.json',
                    controller: controller,
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: showLogin
                      ? const LoginView()
                      : showRegister
                          ? const RegisterView()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: constraints.maxWidth * 0.8,
                                  child: AppButton(
                                    text: 'Log in',
                                    textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                                    onClick: () {
                                      controller.forward();
                                      showLogin = true;
                                      setState(() {});
                                    },
                                    backgroundColor: App.appTheme.colorScheme.primary,
                                    radius: 8,
                                    elevation: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: constraints.maxWidth * 0.8,
                                  child: AppButton(
                                    text: 'Register',
                                    textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                                    onClick: () {
                                      controller.forward();
                                      showRegister = true;
                                      setState(() {});
                                    },
                                    backgroundColor: App.appTheme.colorScheme.primary,
                                    radius: 8,
                                    elevation: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Text('By logging in you agree to our', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey)),
                                GestureDetector(
                                  onTap: () async {
                                    final url = Uri.parse('https://superkauf-api.krejzac.cz/terms');
                                    // if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                    // } else {
                                    //   // Handle the case where the URL cannot be launched
                                    // }
                                  },
                                  child: Text('Terms of Service', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: App.appTheme.colorScheme.primary)),
                                ),
                              ],
                            ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/kauf_logo1.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const EmailLogin(),
              const SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 3,
                color: App.appTheme.colorScheme.primary,
              ),
              const SizedBox(
                height: 30,
              ),
              const AuthProviders()
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return state.maybeMap(confirmEmail: (value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      'confirm_email_text'.tr(),
                      style: App.appTheme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: AppButton(
                      text: 'open_email_button_text'.tr(),
                      textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                      radius: 8,
                      backgroundColor: App.appTheme.colorScheme.primary,
                      imagePrefix: const FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.white,
                      ),
                      onClick: () async {
                        await OpenMailApp.openMailApp();
                      },
                    ),
                  )
                ],
              );
            }, orElse: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/kauf_logo1.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const EmailRegister(),
                  const SizedBox(
                    height: 30,
                  ),
                  Divider(
                    thickness: 3,
                    color: App.appTheme.colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const AuthProviders(),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              );
            });
          }),
        ),
      ),
    );
  }
}

class AuthProviders extends StatelessWidget {
  const AuthProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 330,
          child: AppButton(
            backgroundColor: const Color(0xFF7289DA),
            radius: 6,
            imagePrefix: SvgPicture.asset('assets/images/discord-icon.svg', width: 25, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            spaceTextImage: 15,
            text: 'Discord',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
            onClick: () {
              BlocProvider.of<LoginBloc>(context).add(const DiscordLogin());
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          width: 330,
          child: AppButton(
            backgroundColor: Colors.black,
            radius: 6,
            imagePrefix: SvgPicture.asset('assets/images/apple-logo.svg', width: 25, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            spaceTextImage: 15,
            text: 'Apple',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
            onClick: () {
              BlocProvider.of<LoginBloc>(context).add(const AppleLogin());
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          width: 330,
          child: AppButton(
            backgroundColor: const Color(0xFF4285F4),
            radius: 6,
            imagePrefix: SvgPicture.asset('assets/images/google-logo.svg', width: 25, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            spaceTextImage: 15,
            text: 'Google',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
            onClick: () {
              BlocProvider.of<LoginBloc>(context).add(const GoogleLogin());
            },
          ),
        ),
      ],
    );
  }
}

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final emailController = TextEntryModel(text: '');
  final passwordController = TextEntryModel(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 330,
          child: AppTextField(
            emailController,
            context: context,
            filled: App.appTheme.colorScheme.surface,
            hint: 'E-mail',
            validators: [ValidatorEmpty(), ValidatorEmail()],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 330,
          child: AppTextField(
            passwordController,
            context: context,
            filled: App.appTheme.colorScheme.surface,
            hint: 'Password',
            validators: [ValidatorEmpty()],
            secure: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          state.maybeMap(
              error: (value) {
                BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(message: value.message));
              },
              orElse: () {});
        }, builder: (context, state) {
          return state.maybeMap(loginInProgress: (value) {
            return SizedBox(
              height: 50,
              width: 270,
              child: AppButton(
                backgroundColor: App.appTheme.colorScheme.primary,
                radius: 6,
                enabled: false,
                imagePrefix: const AppProgress(),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                onClick: () async {},
              ),
            );
          }, orElse: () {
            return SizedBox(
              height: 50,
              width: 270,
              child: AppButton(
                backgroundColor: App.appTheme.colorScheme.primary,
                radius: 6,
                text: 'login_button_text'.tr(),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                onClick: () async {
                  final valid = await TextEntryModel.validateFields([emailController, passwordController]);
                  if (!valid) {
                    setState(() {});
                    return;
                  }
                  BlocProvider.of<LoginBloc>(context).add(EmailLoginEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ));
                },
              ),
            );
          });
        }),
      ],
    );
  }
}

class EmailRegister extends StatefulWidget {
  const EmailRegister({super.key});

  @override
  State<EmailRegister> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  final emailController = TextEntryModel(text: '');
  final passwordController = TextEntryModel(text: '');
  String? pickedCountry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 330,
          child: AppTextField(
            emailController,
            context: context,
            filled: App.appTheme.colorScheme.surface,
            hint: 'E-mail',
            validators: [ValidatorEmpty(), ValidatorEmail()],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 330,
          child: AppTextField(
            passwordController,
            context: context,
            filled: App.appTheme.colorScheme.surface,
            hint: 'Password',
            validators: [ValidatorEmpty()],
            secure: true,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CountriesPicker(
          pickedCountry: pickedCountry,
          onCountryPicked: (value) {
            pickedCountry = value;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          state.maybeMap(
              error: (value) {
                BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(message: value.message));
              },
              orElse: () {});
        }, builder: (context, state) {
          return state.maybeMap(loginInProgress: (value) {
            return SizedBox(
              height: 50,
              width: 270,
              child: AppButton(
                backgroundColor: App.appTheme.colorScheme.primary,
                radius: 6,
                enabled: false,
                imagePrefix: const AppProgress(),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                onClick: () async {},
              ),
            );
          }, orElse: () {
            return SizedBox(
              height: 50,
              width: 270,
              child: AppButton(
                backgroundColor: App.appTheme.colorScheme.primary,
                radius: 6,
                text: 'register_button_text'.tr(),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                onClick: () async {
                  final valid = await TextEntryModel.validateFields([emailController, passwordController]);
                  if (!valid) {
                    setState(() {});
                    return;
                  }
                  BlocProvider.of<LoginBloc>(context).add(EmailRegisterEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ));
                },
              ),
            );
          });
        }),
      ],
    );
  }
}
