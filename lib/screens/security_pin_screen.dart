import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/supabase_service.dart';

class SecurityPinArguments {
  final String phone;
  final String transactionLabel;

  SecurityPinArguments({required this.phone, required this.transactionLabel});
}

class SecurityPinScreen extends StatefulWidget {
  static const routeName = '/security-pin';

  const SecurityPinScreen({super.key});

  @override
  State<SecurityPinScreen> createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  Future<void> _verifyPin(SecurityPinArguments args) async {
    if (_pinController.text.trim().length != 6) {
      setState(() {
        _errorText = 'يجب أن يتكون الرمز من 6 أرقام';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final response = await SupabaseService.verifyTransactionPin(
        args.phone,
        _pinController.text,
      );

      final bool valid = response['valid'] == true;
      final bool blocked = response['blocked'] == true;
      final String? message = response['message'] as String?;

      if (blocked) {
        setState(() {
          _errorText = message ?? 'محظور لمدة ساعة واحدة';
        });
        return;
      }

      if (!valid) {
        setState(() {
          _errorText = message ?? 'الرمز غير صحيح، حاول مرة أخرى';
        });
        return;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم التحقق من PIN بنجاح — ${args.transactionLabel}')),
      );
      Navigator.pop(context);
    } catch (error) {
      setState(() {
        _errorText = error.toString();
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SecurityPinArguments;

    return Scaffold(
      backgroundColor: const Color(0xFF061537),
      appBar: AppBar(
        title: Text('رمز الأمان', style: GoogleFonts.inter()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أدخل رمز الأمان المكون من 6 أرقام لإتمام ${args.transactionLabel}',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white, letterSpacing: 14, fontSize: 24),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '••••••',
                  hintStyle: const TextStyle(color: Colors.white24, letterSpacing: 14),
                  filled: true,
                  fillColor: const Color(0xFF11214A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_errorText != null) ...[
                const SizedBox(height: 10),
                Text(
                  _errorText!,
                  style: const TextStyle(color: Color(0xFFFB8C00)),
                ),
              ],
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _verifyPin(args),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'تحقق الآن',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'إذا أخطأت 3 مرات، يتم حظر الحساب لمدة ساعة حسب سياسة الخادم.',
                style: GoogleFonts.inter(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
