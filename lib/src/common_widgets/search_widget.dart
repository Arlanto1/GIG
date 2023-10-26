import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    this.border = AppColors.navigationSkybluecolor,
    this.hintText,
    this.leadingIcon,
    this.isReadOnly = false,
    this.onTap,
    this.focusChange,
    this.onChange,
    this.controller,
    this.onValid,
    this.onSubmit,
    this.onValidator,
    this.suffixIcon,
    this.textInputFieldKey,
    this.isEnabled = false,
  }) : super(key: key);
  final String? hintText;
  final String? leadingIcon;
  final Color border;
  final bool isReadOnly;
  final Function? onTap;
  final Function? focusChange;
  final Function? onChange;
  final Function? onValid;
  final Function? onSubmit;
  final Function? onValidator;
  final TextEditingController? controller;
  final String? textInputFieldKey;
  final Widget? suffixIcon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: circularBorderRadius10,
        color: AppColors.searchBarFillBorder,
        border: Border.all(
          color: border,
          width: 1,
        ),
      ),
      child: Focus(
        onFocusChange: (bool focus) {
          if (focusChange != null) {
            // ignore: void_checks
            return focusChange!(focus);
          }
        },
        child: TextFormField(
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          key: Key(textInputFieldKey ?? ''),
          controller: controller,
          onTap: onTap as void Function()?,
          readOnly: isReadOnly,
          autofocus: isEnabled,
          onChanged: (String query) {
            if (onChange != null) {
              onChange!(query);
            }
          },
          onFieldSubmitted: (String text) {
            if (onSubmit != null) {
              onSubmit!(text);
            }
          },
          validator: (val) {
            if (onValidator != null) {
              return onValidator!(val);
            } else {
              return val;
            }
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Styles.textStyleRegularGrey16,
            prefixIcon: Container(
              padding: allMargin16,
              child: SvgPicture.asset(leadingIcon!),
            ),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
