import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Paletas predefinidas ─────────────────────────────────────────────────────
class ColorOption {
  final String label;
  final Color color;
  const ColorOption({required this.label, required this.color});
}

class AthlosColorPalettes {
  static const List<ColorOption> primaryOptions = [
    ColorOption(label: 'Azul',      color: Color(0xFF2563EB)),
    ColorOption(label: 'Roxo',      color: Color(0xFF7C3AED)),
    ColorOption(label: 'Rosa',      color: Color(0xFFDB2777)),
    ColorOption(label: 'Vermelho',  color: Color(0xFFDC2626)),
    ColorOption(label: 'Laranja',   color: Color(0xFFEA580C)),
    ColorOption(label: 'Verde',     color: Color(0xFF16A34A)),
    ColorOption(label: 'Teal',      color: Color(0xFF0D9488)),
    ColorOption(label: 'Índigo',    color: Color(0xFF4338CA)),
  ];

  static const List<ColorOption> backgroundOptions = [
    ColorOption(label: 'Branco',        color: Color(0xFFF8FAFC)),
    ColorOption(label: 'Cinza Claro',   color: Color(0xFFF1F5F9)),
    ColorOption(label: 'Creme',         color: Color(0xFFFAF7F2)),
    ColorOption(label: 'Verde Suave',   color: Color(0xFFF0FDF4)),
    ColorOption(label: 'Azul Suave',    color: Color(0xFFEFF6FF)),
    ColorOption(label: 'Roxo Suave',    color: Color(0xFFF5F3FF)),
    ColorOption(label: 'Escuro',        color: Color(0xFF0F172A)),
    ColorOption(label: 'Grafite',       color: Color(0xFF1E293B)),
  ];
}

// ─── Notifier ─────────────────────────────────────────────────────────────────
class ThemeNotifier extends ChangeNotifier {
  Color _primaryColor = const Color(0xFF2563EB);
  Color _backgroundColor = const Color(0xFFF8FAFC);
  bool _isDark = false;

  Color get primaryColor => _primaryColor;
  Color get backgroundColor => _backgroundColor;
  bool get isDark => _isDark;

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    // Se escolher fundo escuro, ativa dark mode automaticamente
    final luminance = color.computeLuminance();
    _isDark = luminance < 0.2;
    notifyListeners();
  }

  ThemeData buildTheme() {
    final isDarkMode = _isDark;
    final surface = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final textPrimary = isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final borderColor = isDarkMode ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    final surfaceVariant = isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);

    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: _backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: _primaryColor,
        surface: surface,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayMedium: GoogleFonts.inter(
          fontSize: 24, fontWeight: FontWeight.w700, color: textPrimary,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13, color: textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12, color: isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 17, fontWeight: FontWeight.w600, color: textPrimary,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF94A3B8)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: _primaryColor,
        unselectedItemColor: isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: DividerThemeData(color: borderColor, thickness: 1, space: 0),
      extensions: [
        AthlosThemeExtension(
          primaryColor: _primaryColor,
          backgroundColor: _backgroundColor,
          surfaceColor: surface,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          borderColor: borderColor,
          surfaceVariant: surfaceVariant,
          isDark: isDarkMode,
        ),
      ],
    );
  }
}

// ─── Theme Extension (acesso fácil às cores customizadas) ─────────────────────
class AthlosThemeExtension extends ThemeExtension<AthlosThemeExtension> {
  final Color primaryColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderColor;
  final Color surfaceVariant;
  final bool isDark;

  const AthlosThemeExtension({
    required this.primaryColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.borderColor,
    required this.surfaceVariant,
    required this.isDark,
  });

  @override
  AthlosThemeExtension copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? borderColor,
    Color? surfaceVariant,
    bool? isDark,
  }) {
    return AthlosThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      borderColor: borderColor ?? this.borderColor,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  AthlosThemeExtension lerp(AthlosThemeExtension? other, double t) {
    if (other == null) return this;
    return AthlosThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      isDark: isDark,
    );
  }
}

// ─── Helper de acesso ─────────────────────────────────────────────────────────
extension ThemeContextExtension on BuildContext {
  AthlosThemeExtension get athlos =>
      Theme.of(this).extension<AthlosThemeExtension>() ??
      AthlosThemeExtension(
        primaryColor: const Color(0xFF2563EB),
        backgroundColor: const Color(0xFFF8FAFC),
        surfaceColor: Colors.white,
        textPrimary: const Color(0xFF0F172A),
        textSecondary: const Color(0xFF64748B),
        borderColor: const Color(0xFFE2E8F0),
        surfaceVariant: const Color(0xFFF1F5F9),
        isDark: false,
      );
}
