// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/const/app_padding.dart';
// import 'package:social_media_app/core/const/app_sizedbox.dart';
// import 'package:social_media_app/core/theme/color/app_colors.dart';
// import 'package:social_media_app/features/auth/presentation/bloc/bloc/auth_bloc.dart';
// import 'package:social_media_app/features/auth/presentation/widgets/auth_button.dart';
// import 'package:social_media_app/features/auth/presentation/widgets/auth_form.dart';
// import 'package:social_media_app/features/auth/presentation/widgets/welcome_msg/welcome_msg.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(AppPadding.authPadding),
//           child: LayoutBuilder(builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minWidth: constraints.maxWidth,
//                   minHeight: constraints.maxHeight,
//                 ),
//                 child: BlocConsumer<AuthBloc, AuthState>(
//                   listener: (context, state) {
//                     if (state is AuthFailure) {
//                       ScaffoldMessenger.of(context)
//                         ..hideCurrentMaterialBanner()
//                         ..showSnackBar(
//                           SnackBar(
//                             content: Text(state.errorMsg),
//                           ),
//                         );
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is AuthLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     return IntrinsicHeight(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const WelcomeMessage(
//                               title1: 'Login to your', title2: 'Account'),
//                           AppSizedBox.sizedBox40H,
//                           AuthForm(
//                             formKey: _formKey,
//                             emailController: _emailController,
//                             passwordController: _passwordController,
//                           ),
//                           AppSizedBox.sizedBox10H,
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 'Forgot password?',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium
//                                     ?.copyWith(
//                                         color: AppDarkColor()
//                                             .secondaryPrimaryText),
//                               ),
//                             ),
//                           ),
//                           AuthButton(
//                             title: 'Log In',
//                             onClick: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<AuthBloc>().add(
//                                       AuthSignUp(
//                                         email: _emailController.text.trim(),
//                                         password:
//                                             _passwordController.text.trim(),
//                                       ),
//                                     );
//                               }
//                             },
//                           ),
//                           AppSizedBox.sizedBox10H,
//                           Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(
//                                       color:
//                                           AppDarkColor().secondaryBackground),
//                                 ),
//                                 AppSizedBox.sizedBox10W,
//                                 const Text(
//                                   'or',
//                                   style: TextStyle(),
//                                 ),
//                                 AppSizedBox.sizedBox10W,
//                                 Expanded(
//                                   child: Divider(
//                                       color:
//                                           AppDarkColor().secondaryBackground),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           AppSizedBox.sizedBox10H,
//                           AuthButton(
//                             isGoogleAuth: true,
//                             title: 'Continue with google',
//                             onClick: () {},
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     'Don\'t have an account?',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {},
//                                     child: Text(
//                                       'Sign up',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium
//                                           ?.copyWith(
//                                               color: AppDarkColor()
//                                                   .secondaryPrimaryText),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
