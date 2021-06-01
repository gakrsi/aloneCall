import 'package:flutter/material.dart';

/// A form field widget which will handle form ui.
///
/// [focusNode] : FocusNode for the form field.
/// [autoFocus] : Allow auto focus for the form field if true.
/// [textEditingController] : Text editing controller for the form field
///                           to handle the text change and other stuff.
/// [isObscureText] : If true it will make the form text secure.
/// [obscureCharacter] : If [isObscureText] true this will be used for the
///                      character which will be shown.
/// [textCapitalization] : Type of text capitalization for the form field.
/// [isFilled] : If true the decoration colors will be filled.
/// [contentPadding] : Padding for the form field between the content and
///                    boundary of the form.
/// [fillColor] : The background color of the form field.
/// [hintText] : The hint text of the form field.
/// [hintStyle] : The hint style for the the form field.
/// [errorStyle] : The error style for the the form field.
/// [formBorder] : The border for the form field.
/// [errorText] : The error text of the form field.
/// [suffixIcon] : The suffix widget of the form field.
/// [prefixIcon] : The prefix widget of the form field.
/// [textInputAction] : The text input action for the form filed.
/// [textInputType] : The keyboard type of the form field.
/// [formStyle] : The style of the form field. This will be used for the style
///               of the content.
class FormFieldWidget extends StatelessWidget {
  FormFieldWidget({
    this.focusNode,
    this.autoFocus,
    this.textEditingController,
    this.isObscureText = false,
    this.obscureCharacter = ' ',
    this.textCapitalization = TextCapitalization.none,
    this.isFilled,
    this.contentPadding = EdgeInsets.zero,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.errorStyle,
    this.formBorder,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.formStyle,
    this.onChange,
    this.isReadOnly = false,
    this.onTap,
  });

  final FocusNode focusNode;
  final bool autoFocus;
  final TextEditingController textEditingController;
  final bool isObscureText;
  final String obscureCharacter;
  final TextCapitalization textCapitalization;
  final bool isFilled;
  final EdgeInsets contentPadding;
  final Color fillColor;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final OutlineInputBorder formBorder;
  final String errorText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextStyle formStyle;
  final void Function(String value) onChange;
  final bool isReadOnly;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => TextFormField(
    readOnly: isReadOnly,
    autofocus: autoFocus,
    focusNode: focusNode,
    controller: textEditingController,
    obscureText: isObscureText,
    obscuringCharacter: obscureCharacter,
    textCapitalization: textCapitalization,
    onTap: onTap,
    decoration: InputDecoration(
      filled: true,
      contentPadding: contentPadding,
      fillColor: fillColor,
      border: formBorder,
      hintText: hintText,
      hintStyle: hintStyle,
      errorText: errorText,
      errorStyle: errorStyle,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    ),
    onChanged: onChange,
    textInputAction: textInputAction,
    keyboardType: textInputType,
    style: formStyle,
  );
}
