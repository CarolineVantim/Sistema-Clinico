import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // <<< AQUI: precisa ser nullable
  final bool isLoading;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed, // Mantido como required, mas o tipo é nullable
    this.isLoading = false,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: isLoading ? null : onPressed, // Passa null para desabilitar
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(text),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // <<< AQUI: precisa ser nullable
  final Color? foregroundColor;
  final Color? borderColor;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed, // Mantido como required, mas o tipo é nullable
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          foregroundColor: foregroundColor,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        child: Text(text),
      ),
    );
  }
}
