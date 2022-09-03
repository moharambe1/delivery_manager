import 'package:delivery_manager/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class LeadingPage extends StatefulWidget {
  const LeadingPage({super.key});

  @override
  State<LeadingPage> createState() => _LeadingPageState();
}

class _LeadingPageState extends State<LeadingPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(TryLoginEvent());
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 34),
                child: Image(
                  image: const AssetImage("assets/image/logo(1).png"),
                  width: 70.w,
                  height: 70.w,
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSiccafluid) print("hello world");
                },
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: CircularProgressIndicator(),
                ),
              ),
            ]),
      ),
    );
  }
}
