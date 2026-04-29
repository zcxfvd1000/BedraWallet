import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/glass_card.dart';
import 'deposit_panel.dart';
import 'security_pin_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments as String? ?? '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bedra Wallet',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B2B5A), Color(0xFF081A46)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'مناف احمد صالح العامري',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                GlassCard(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الحساب الآمن',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'خيار الإرسال فقط مع حماية كاملة بالرمز السري.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildActionButton(
                            context,
                            label: 'إيداع',
                            icon: Icons.account_balance_wallet,
                            color: const Color(0xFF00B4D8),
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const DepositPanel(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildActionButton(
                            context,
                            label: 'سداد Clover',
                            icon: Icons.payments,
                            color: const Color(0xFF1E88E5),
                            onTap: () => Navigator.pushNamed(
                              context,
                              SecurityPinScreen.routeName,
                              arguments: SecurityPinArguments(
                                phone: phone,
                                transactionLabel: 'Pay for Clover',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildActionButton(
                        context,
                        label: 'تحويل الأموال',
                        icon: Icons.send,
                        color: const Color(0xFF4CAF50),
                        onTap: () => Navigator.pushNamed(
                          context,
                          SecurityPinScreen.routeName,
                          arguments: SecurityPinArguments(
                            phone: phone,
                            transactionLabel: 'Transfer',
                          ),
                        ),
                        fullWidth: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'المزايا الخاصة',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildFeatureCard(
                        title: 'وضع الإرسال فقط',
                        description: 'لا يتم معالجة أي بيانات محلياً. يتم التحقق من جميع المدخلات في الخادم.',
                        color: const Color(0xFF3DA9FC),
                      ),
                      const SizedBox(height: 14),
                      _buildFeatureCard(
                        title: 'حماية رمز PIN',
                        description: 'قبل أي تحويل أو دفع، يتم التحقق من 6 أرقام عبر Supabase.',
                        color: const Color(0xFF2FAF5F),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    return Expanded(
      flex: fullWidth ? 2 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.28),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required Color color,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
