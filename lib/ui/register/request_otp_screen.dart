import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/model/response/otp_response.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/constant/error.dart';
import 'package:shopping_conv/ui/register/request_otp_view_model.dart';
import 'package:provider/provider.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String email;

  // Pass the email to this screen for context
  OtpVerificationScreen({required this.email});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _otp = '';
  bool _isLoading = false;
  bool _isResending = false;

  // Function to handle OTP submission
  void _submitOtp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
        // Use Provider.of with listen: false
        final requestOtpViewModel = context.read<RequestOtpViewModel>();
        var success = await requestOtpViewModel.verifyOTP(context:context,email: widget.email, otp: _otp);
        if(!success){
          final errorMessage = requestOtpViewModel.errorMessage;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage ?? MessageError.errorCommon),
            ),
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Xác nhận thành công'),
            ),
          );}
    }
  }

  // Function to handle OTP resend
  void _resendOtp(BuildContext context) async {

    setState(() {
      _isResending = true;
    });
      context.read<RequestOtpViewModel>().sendOTP(context: context,email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RequestOtpViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nhập mã OTP được gửi đến địa chỉ Email: ${widget.email}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập OTP';
                  } else if (value.length != 6) {
                    return 'OTP phải có 6 ký tự';
                  }
                  return null;
                },
                onSaved: (value) => _otp = value!,
              ),
              SizedBox(height: 16),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: viewModel.isLoading ? null : () => _submitOtp(context),
                child: Text('Xác nhận'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TextButton(
                onPressed: viewModel.isLoading ? null : () => _resendOtp(context),
                child: Text('Gửi lại OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
