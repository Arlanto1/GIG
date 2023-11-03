import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_cubit.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/network_handler.dart' as network_handler;
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../common_widgets/app_button.dart';
import '../../../models/base_user.dart';
import '../../../models/organisation.dart';
import '../models/user.dart';

class CreateFound extends StatefulWidget {
  final FoundListArticleDetails? model;
  final int? eventId;

  const CreateFound({super.key, this.model, this.eventId});

  @override
  State<CreateFound> createState() => _CreateFoundState();
}

class _CreateFoundState extends State<CreateFound> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = '';
  String serialNumber = '';

  // Group Value for Radio Button.
  int isDepositorDBEmployeeSelected = 1;
  int isClaimantDBEmployeeSelected = 1;
  int isClaimantAcceptedtoSignSelected = 0;
  int isClaimantAcceptedByemail = 1;
  final GlobalKey<FormState> createfoundFormKey = GlobalKey<FormState>();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController foundLocationTextController = TextEditingController();
  TextEditingController depositorEmpIdTextController = TextEditingController();
  TextEditingController claimantEmpIdTextController = TextEditingController();
  TextEditingController additionalinformationTextController =
      TextEditingController();
  TextEditingController foundDateTextController = TextEditingController();
  TextEditingController handedoverdatedateTextController =
      TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController assettypeTextController = TextEditingController();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController depositorTextController = TextEditingController();
  TextEditingController claimantTextController = TextEditingController();
  String isDepositorDBEmployee = "";

  // String slnoValue = "dfwe";
  String createdByValue = "";
  String itemhandoverByValue = "";
  String locationselectedText = "";
  Organisation? selectedEmployeedepartment;
  Organisation? selectedClaimdepartment;
  String claimantDepartmentName = '';
  String claimant = '';
  Organisation? selectedArtclelist;
  BaseUser? selecteddepositorList;
  BaseUser? selectedClaimList;
  User? userDetails;
  Organisation? locationSelectedlist;
  SubmitCreateFoundModel? createfoundResponse;
  SerialNumberModel? serialnumberResponse;
  List<CreateImage> getFiles = [];
  List<FoundImage> getAttachments = [];

  SignatureController claimantSignature = SignatureController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      populateData();
    }
    BlocProvider.of<CreateFoundArticleCubit>(context).initializeValues();
    _getFoundArticleList();
    _getCurrentDate();
  }

  populateData() async {
    if (widget.model != null) {
      await SharedPrefs.setFoundId(widget.model?.id ?? 0);
      selecteddepositorList = widget.model?.depositor != null
          ? BaseUser(
              email: widget.model?.depositor?.email ?? "",
              id: widget.model?.depositor?.userId ?? 0,
              name: widget.model?.depositor?.name ?? "")
          : BaseUser();
      selectedArtclelist = widget.model?.typeOfArticle != null
          ? Organisation(
              id: widget.model?.typeOfArticle?.id ?? 1,
              name: widget.model?.typeOfArticle?.name ?? "")
          : Organisation();
      userDetails = widget.model?.entrySecurity != null
          ? User(
              userId: widget.model?.entrySecurity?.userId ?? 1,
              lastName: widget.model?.entrySecurity?.lastName ?? "")
          : User();
      createdByValue = userDetails?.name != null ? userDetails?.name ?? '' : '';
      serialNumber = widget.model?.slNo != null ? widget.model?.slNo ?? "" : '';
      locationSelectedlist = widget.model?.location != null
          ? Organisation(
              id: widget.model?.location?.id ?? 0,
              name: widget.model?.location?.name ?? "")
          : Organisation();
      locationselectedText = locationSelectedlist?.name != null
          ? locationSelectedlist?.name ?? ""
          : '';
      quantityTextController.text = widget.model?.quantity != null
          ? widget.model?.quantity.toString() ?? ""
          : '';
      colorTextController.text = widget.model?.color != null
          ? widget.model?.color.toString() ?? ""
          : '';
      foundLocationTextController.text = widget.model?.foundLocation != null
          ? widget.model?.foundLocation.toString() ?? ""
          : '';
      additionalinformationTextController.text =
          widget.model?.additionalInformation != null
              ? widget.model?.additionalInformation.toString() ?? ""
              : '';
      foundDateTextController.text =
          widget.model?.foundDate != null && widget.model?.foundDate != '0'
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.model?.foundDate ?? '0'),
                  Constants.fulldateFormat)
              : '';
      dateofcreationTextController.text =
          widget.model?.inputDate != null && widget.model?.inputDate != '0'
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.model?.inputDate ?? '0'),
                  Constants.fulldateFormat)
              : dateofcreationTextController.text;
      assettypeTextController.text = widget.model?.typeOfAsset != null
          ? (widget.model?.typeOfAsset == 0 ? "Personal" : "Company")
          : '';
      statusTextController.text = widget.model?.status == 0
          ? "Found"
          : widget.model?.status == 1
              ? "Under Security Custody"
              : "Handover";
      depositorTextController.text = widget.model?.depositorName != null
          ? widget.model?.depositorName ?? ""
          : '';
      isDepositorDBEmployeeSelected =
          ((widget.model?.depositorDbEmp ?? false) == true) ? 1 : 0;
      isClaimantAcceptedtoSignSelected =
          ((widget.model?.claimantNoSign ?? false) == true) ? 1 : 0;
      isClaimantAcceptedByemail =
          ((widget.model?.claimantConfirmByEmail ?? false) == true) ? 1 : 0;
      isClaimantDBEmployeeSelected =
          ((widget.model?.claimantDbEmp ?? false) == true) ? 1 : 0;
      depositorEmpIdTextController.text = widget.model?.employeeId != null
          ? widget.model?.employeeId ?? ''
          : '';
      selectedEmployeedepartment = widget.model?.depositorDepartment != null
          ? Organisation(
              id: widget.model?.depositorDepartment?.id ?? 0,
              name: widget.model?.depositorDepartment?.name ?? '')
          : Organisation();
      getAttachments =
          widget.model?.images != null ? widget.model?.images ?? [] : [];
      claimantDepartmentName = widget.model?.claimantDepartmentName != null
          ? widget.model?.claimantDepartmentName ?? ''
          : '';
      handedoverdatedateTextController.text = widget.model?.handoverDate != null
          ? Utils.timestamptoDateConversion(
              int.parse(widget.model?.handoverDate ?? '0'),
              Constants.fulldateFormat)
          : handedoverdatedateTextController.text.isEmpty
              ? ''
              : handedoverdatedateTextController.text;
      claimantEmpIdTextController.text = widget.model?.claimantEmployeeId ?? '';
      claimant = widget.model?.claimant?.lastName != null
          ? widget.model?.claimant?.lastName ?? ''
          : '';
      itemhandoverByValue = widget.model?.handoverSecurity?.name ?? '';

      log('---widget.model?.claimant?.lastName-----${widget.model?.claimant?.lastName}----');
      claimantTextController.text = widget.model?.claimant?.name != null
          ? widget.model?.claimant?.name ?? ''
          : '';
      selectedClaimdepartment = widget.model?.claimantDepartment != null
          ? Organisation(
              id: widget.model?.claimantDepartment?.id ?? 0,
              name: widget.model?.claimantDepartment?.name ?? '')
          : Organisation();
      selectedClaimList = widget.model?.claimant != null
          ? BaseUser(
              email: widget.model?.claimant?.email ?? "",
              id: widget.model?.claimant?.userId ?? 0,
              name: widget.model?.claimant?.lastName ?? "")
          : BaseUser();
    }
  }

  createFoundBody(bool isSubmit, int isFoundId) async {
    log('-createFoundBody-----');

    bool isDepositorDBEmployeeSelectedValue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    // int statusValue = 0;
    // if (statusTextController.text.toLowerCase() == "found") {
    //   statusValue = 0;
    // } else if (statusTextController.text.toLowerCase() ==
    //     "under security custody") {
    //   statusValue = 0;
    // } else {
    //   statusValue = 2;
    // }

    int foundDate = Utils.dateToTimestampConversion(
        foundDateTextController.text, Constants.fulldateFormat);
    // int inputDate = Utils.dateToTimestampConversion(
    //     dateofcreationTextController.text, Constants.fulldateFormat);
    int inputdate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    Map<String, dynamic> entrySecurityBody = {
      "userId": userDetails?.userId ?? 0,
    };
    Map<String, dynamic> locationBody = {
      "id": locationSelectedlist?.id ?? 0,
      "name": locationSelectedlist?.name ?? ''
    };
    Map<String, dynamic> depositorBody = {
      "userId": selecteddepositorList?.id ?? 1,
      "userName": selecteddepositorList?.name ?? '',
      "email": selecteddepositorList?.email ?? '',
    };
    Map<String, dynamic> articleBody = {
      "id": selectedArtclelist?.id ?? 0,
    };
    Map<String, dynamic> depositorDeptBody = {
      "id": selectedEmployeedepartment?.id ?? 1,
    };
    Map<String, dynamic> foundBody = {
      "status": widget.model?.status ?? 0,
      "typeOfAsset": assettypeTextController.text.isEmptyOrNull
          ? ((assettypeTextController.text.toLowerCase()) == 'company' ? 1 : 0)
          : null,
      "color":
          colorTextController.text.isNotEmpty ? colorTextController.text : '',
      "slNo": serialNumber,
      "typeOfArticle": articleBody,
      "entrySecurity": entrySecurityBody,
      "foundLocation": foundLocationTextController.text,
      "quantity": quantityTextController.text.isNotEmpty
          ? int.parse(quantityTextController.text)
          : 0,
      "additionalInformation": additionalinformationTextController.text,
      "depositorDbEmp": isDepositorDBEmployeeSelectedValue,
      "inputDate": inputdate,
      "foundDate": foundDate,
      "location": locationBody,
      "depositorName": isDepositorDBEmployeeSelected == 1
          ? selecteddepositorList?.name ?? ''
          : depositorTextController.text.isNotEmpty
              ? depositorTextController.text
              : '',
      "employeeId": depositorEmpIdTextController.text.isNotEmpty
          ? depositorEmpIdTextController.text
          : '',
      "depositorDepartment": depositorDeptBody,
      "depositor": depositorBody,
      "eventProtection": widget.eventId,
      "images": getFiles
    };
    Map<String, dynamic> requestBody = {
      "found": foundBody,
    };
    var username = await SharedPrefs.getUsername();
    showLoadingDialog(context);
    await createFoundArticleCubit.createFoundArticleHandle(
        requestBody,
        isSubmit,
        context,
        username,
        widget.model != null ? Constants.editfound : Constants.createfound);
  }

  /// Submit Form
  Future submitForm(bool isSubmit, int isFoundId, {CreateFoundState? state}) async {
    log('-createRequestBody-----');
    int foundDate = Utils.dateToTimestampConversion(
        foundDateTextController.text, Constants.fulldateFormat);
    // int inputDate = Utils.dateToTimestampConversion(
    //     dateofcreationTextController.text, Constants.fulldateFormat);
    int inputDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    int handoverDate = Utils.dateToTimestampConversion(
        handedoverdatedateTextController.text, Constants.fulldateFormat);
    var username = await SharedPrefs.getUsername();
    bool isDepositorDBEmployeeSelectedValue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    bool isClaimDBEmployeeSelectedValue =
        isClaimantDBEmployeeSelected == 1 ? true : false;
    bool isClaimSignSelectedValue =
        isClaimantAcceptedtoSignSelected == 1 ? true : false;
    bool isClaimantSelectedByEmail =
        isClaimantAcceptedByemail == 1 ? true : false;
    Organisation? articleType = Organisation(
        id: selectedArtclelist?.id ?? widget.model?.typeOfArticle?.id);
    User? entrySecurity = User(
        userId: userDetails?.userId ?? widget.model?.entrySecurity?.userId);
    User? depositor = User(
        userId: selecteddepositorList?.id ?? widget.model?.depositor?.userId);
    Organisation? location = Organisation(
        id: locationSelectedlist?.id ?? widget.model?.location?.id);
    Organisation? depositorDepartment =
        selectedEmployeedepartment ?? widget.model?.depositorDepartment;
    List<CreateImage>? images = getFiles;
    Organisation? claimantDepartment =
        selectedClaimdepartment ?? widget.model?.claimantDepartment;

    isClaimantDBEmployeeSelected;
    User? claimant = widget.model?.claimant;
    if (selectedClaimList != null) {
      claimant = User(
        userId: selectedClaimList?.id,
        name: selectedClaimList?.name,
      );
    }
    log('--2222-state?.loggedInUser-${state?.loggedInUser}--');
    User? handoverSecurity;
    if(widget.model?.status == 1) {
      log('---state?.loggedInUser-${state?.loggedInUser}--');
      handoverSecurity = state?.loggedInUser;
    }
    // int statusValue = 0;
    // if (statusTextController.text.toLowerCase() == "found") {
    //   statusValue = 0;
    // } else if (statusTextController.text.toLowerCase() ==
    //     "under security custody") {
    //   statusValue = 0;
    // } else {
    //   statusValue = 2;
    // }

    log('-assettypeTextController.text---${assettypeTextController.text}----');
    log('---condition type assest---${!assettypeTextController.text.isEmptyOrNull ? ((assettypeTextController.text.toLowerCase()) == 'company' ? 1 : 0) : null}----');
    Found? found = Found(
        claimantConfirmByEmail: isClaimantSelectedByEmail,
        id: widget.model?.id,
        claimantDepartment: claimantDepartment,
        claimant: claimant,
        claimantDbEmp: isClaimDBEmployeeSelectedValue,
        claimantNoSign: isClaimSignSelectedValue,
        handoverSecurity: handoverSecurity,
        handoverDate: handoverDate,
        claimantEmployeeId: claimantEmpIdTextController.text.isEmpty
            ? 0
            : int.parse(claimantEmpIdTextController.text),
        slNo: serialNumber,
        images: images,
        typeOfAsset: !assettypeTextController.text.isEmptyOrNull
            ? ((assettypeTextController.text.toLowerCase()) == 'company'
                ? 1
                : 0)
            : null,
        typeOfArticle: articleType,
        foundLocation: foundLocationTextController.text.isNotEmpty
            ? foundLocationTextController.text
            : '',
        additionalInformation:
            additionalinformationTextController.text.isNotEmpty
                ? additionalinformationTextController.text
                : '',
        quantity: quantityTextController.text.isNotEmpty
            ? int.parse(quantityTextController.text)
            : 0,
        color:
            colorTextController.text.isNotEmpty ? colorTextController.text : '',
        status: widget.model?.status ?? 0,
        depositorDbEmp: isDepositorDBEmployeeSelectedValue,
        inputDate: inputDate,
        foundDate: foundDate,
        entrySecurity: entrySecurity,
        location: location,
        depositorName: isDepositorDBEmployeeSelected == 1
            ? selecteddepositorList?.name ?? ''
            : depositorTextController.text.isNotEmpty
                ? depositorTextController.text
                : '',
        depositor: depositor,
        depositorDepartment: depositorDepartment,
        employeeId: depositorEmpIdTextController.text.isNotEmpty
            ? depositorEmpIdTextController.text
            : '');
    found.eventProtection = widget.eventId;
    CreateFoundRequestBody requestBody = CreateFoundRequestBody(found: found);
    showLoadingDialog(context);
    await createFoundArticleCubit.createNewFoundArticle(
      requestBody,
      isSubmit,
      context,
      username,
      widget.model != null ? Constants.editfound : Constants.createfound,
    );
  }

  void _getFoundArticleList() async {
    var userid = await SharedPrefs.getUserId();
    final bool isActive = await network_handler.networkChecking(context);
    if (isActive) {
      await createFoundArticleCubit.getUserByRoleDepositor(
          'ATOM_STATIC_USER', context);
      await createFoundArticleCubit.getLocations('ATOM_LOCATIONS', context);
      await createFoundArticleCubit.getEmployeeDepartments(
          'EMPLOYEE_DEPARTMENTS', context);
      await createFoundArticleCubit.getArticleType('ARTICLE_LIST', context);
      if (widget.model == null) {
        await createFoundArticleCubit.getUserDetails(userid, context);
      }
    } else {
      Utils.showAlertMessage("No Network connection", context);
    }
  }

  void _getCurrentDate() {
    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(currentDate);
    //you can implement different kind of Date Format here according to your requirement
    dateofcreationTextController.text = formattedDate;
    statusTextController.text = 'Found';
    handedoverdatedateTextController.text = formattedDate;
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  createFoundValidations(BuildContext context, CreateFoundState state) {
    if (statusTextController.text.isEmpty &&
        createdByValue.isEmpty &&
        (locationSelectedlist?.name ?? "").isEmpty &&
        dateofcreationTextController.text.isEmpty &&
        serialNumber.isEmpty &&
        assettypeTextController.text.isEmpty &&
        (selectedArtclelist?.name ?? "").isEmpty &&
        foundDateTextController.text.isEmpty &&
        foundLocationTextController.text.isEmpty &&
        additionalinformationTextController.text.isEmpty &&
        // quantityTextController.text.isEmpty &&
        (((isDepositorDBEmployeeSelected == 1 &&
                    (selecteddepositorList?.name ?? "").isEmpty) &&
                depositorEmpIdTextController.text.isEmpty &&
                (selectedEmployeedepartment?.name ?? "").isEmpty) ||
            (isDepositorDBEmployeeSelected == 0 &&
                depositorTextController.text.isEmpty))) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
    } else if ((locationSelectedlist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter location",
      );
    } else if (dateofcreationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator date",
      );
    } else if (serialNumber.isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (assettypeTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter asset type",
      );
    } else if ((selectedArtclelist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter article type",
      );
    } else if (foundDateTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found date",
      );
    } else if (foundLocationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found location",
      );
    } else if (quantityTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter quantity",
      );
    } else if (colorTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter colour",
      );
    } else if (isDepositorDBEmployeeSelected == 0 &&
        depositorTextController.text.isEmpty) {
      Validator().showToast(context, "Please enter depositor");
    } else if (isDepositorDBEmployeeSelected == 1 &&
        (((selecteddepositorList?.name ?? "").isEmpty) ||
            (depositorEmpIdTextController.text.isEmpty) ||
            ((selectedEmployeedepartment?.name ?? "").isEmpty))) {
      if ((selecteddepositorList?.name ?? "").isEmpty) {
        Validator().showToast(
          context,
          "Please enter depositor",
        );
      } else if (depositorEmpIdTextController.text.isEmpty) {
        Validator().showToast(
          context,
          "Please enter depositor employee id",
        );
      } else if ((selectedEmployeedepartment?.name ?? "").isEmpty) {
        Validator().showToast(
          context,
          "Please enter employee department",
        );
      }
    } else {
      //createNewuserBody(true, widget.listuser?.id ?? 0);
      if (widget.model != null && widget.model?.status != 0) {
        if (isClaimantDBEmployeeSelected == 1 &&
            ((claimant.isEmpty) ||
                (claimantEmpIdTextController.text.isEmpty) ||
                (claimantDepartmentName.isEmpty))) {
          if (claimant.isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant",
            );
          } else if (claimantEmpIdTextController.text.isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant employee id",
            );
          } else if ((selectedClaimdepartment?.name ?? '').isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant department",
            );
          }
        } else if (widget.model?.status != 0 &&
            isClaimantDBEmployeeSelected == 0 &&
            claimantTextController.text.isEmpty) {
          log('--isClaimantDBEmployeeSelected--$isClaimantDBEmployeeSelected-------');
          if (claimant.isEmptyOrNull) {
            Validator().showToast(context, "Please enter claim");
          }
        } else {
          submitForm(true, widget.model?.id ?? 0, state: state);
        }
      } else {
        submitForm( true, widget.model?.id ?? 0, state: state);
      }
    }
  }

  assetTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSimpleListTexts(
          texts: const ["Personal", "company"],
          onTap: (String value) {
            assettypeTextController.text = value;
            setState(() {});
          },
        );
      },
    );
  }

  articleTypeDialog(CreateFoundState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateArticleList:
                state.getArticleTypeResponse?.articleList ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addarticletype,
                      createFoundState: state,
                    );
                  });
            },
            onTap: (Organisation list) {
              selectedArtclelist = list;
              setState(() {});
            },
          );
        });
  }

  datePickerDialog(TextEditingController textfield) async {
    // datePickerselection(context, founddateTextController);
    DateTime? pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    //you can implement different kind of Date Format here according to your requirement
    if (textfield == foundDateTextController) {
      foundDateTextController.text = formattedDate;
    } else if (textfield == handedoverdatedateTextController) {
      handedoverdatedateTextController.text = formattedDate;
    }
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  depositorDialog(CreateFoundState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateDepostorList:
                state.getDepositorResponse?.atomStaticUser ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return CreateFoundNewUser(
                      title: Constants.createnewuser,
                      createoundstate: state,
                    );
                  });
            },
            onTap: (BaseUser list) {
              if (name.toLowerCase() == 'depositor') {
                selecteddepositorList = list;
              } else {
                selectedClaimList = list;
              }
              setState(() {});
            },
          );
        });
  }

  employeeDepartmentDialog(CreateFoundState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateEmployeeDepartments:
                state.getEmployeeDepartmentsResponse?.employeeDepartments ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addemployeedepartment,
                      createFoundState: state,
                    );
                  });
            },
            onTap: (Organisation department) {
              if (name == Constants.employeedepartment) {
                log('--department--${department.name}--');
                selectedEmployeedepartment = department;

                log('--selectedEmployeedepartment--${selectedEmployeedepartment?.name}--');
              } else {
                selectedClaimdepartment = department;
              }
              setState(() {});
            },
          );
        });
  }

  initiallyLocationandSerialnumberdataset(CreateFoundState state) async {
    if (locationSelectedlist == null &&
        state.getLocationsResponse != null &&
        widget.model == null) {
      locationSelectedlist = Organisation(id: 24, name: "DLF Square");
      locationselectedText = 'DLF Square';
      await createFoundArticleCubit.getSerialnumberDetails('24', 'AF', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
        appBar: AppHeader(
          isTitleCenter: false,
          title: widget.model != null
              ? Constants.editfound
              : Constants.createfound,
          backBtn: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppIcon.backIcon,
                color: AppColors.backgroundWhitecolor),
          ),

          action: [
            Visibility(
              visible: widget.model?.status != 2,
              child: GestureDetector(
                onTap: () {
                  //for now the new param is isSubmit added, if any new params needed we can add to this.
                  //createNewuserBody(false); //for save
                  //createdraftValidations(context);
                  submitForm( false, 0);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(
                    AppIcon.createfoundsaveicon,
                  ),
                ),
              ),
            ),
          ],
          //backgroundColor: AppColors.navigationSkybluecolor,
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
          builder: (context, state) {
            createfoundResponse = state.createFoundResponse;

            if (state.stateType == CreateFoundStateType.addattachment) {
              // if (getFiles == null || getFiles?.length == 0) {
              getFiles = state.loadAttachments ?? [];
              // } else {
              //   if (state.loadAttachments != null && state.loadAttachments?.length != 0) {
              //     getFiles?.addAll(state.loadAttachments ?? []);
              //   }
              //  }
            }
            // if (createfoundResponse?.message != null) {
            //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            //     _createFoundAlert(context, createfoundResponse?.message ?? '');
            //   });
            // }
            initiallyLocationandSerialnumberdataset(state);
            if (widget.model == null) {
              userDetails = state.loggedInUser ?? User();
              if (userDetails != null) {
                createdByValue =
                    '${userDetails?.firstName ?? ''} ${userDetails?.lastName ?? ''}';
              }
              serialnumberResponse = state.getSerialnumberResponse;
              if (serialnumberResponse != null) {
                serialNumber = serialnumberResponse?.serialNo ?? "";
              }
            } else {
              claimantDepartmentName = selectedClaimdepartment?.name ?? '';
              claimant = selectedClaimList?.name ?? '';
            }
            return Container(
                color: AppColors.navigationSkybluecolor,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    height: height * 0.01,
                    color: AppColors.navigationSkybluecolor,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const ShapeDecoration(
                        color: AppColors.backgroundWhitecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        )),
                    child: Form(
                        key: createfoundFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                Constants.status, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFieldController: statusTextController,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                              suffixWidget: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                    //AppIcon.dropdownicon,
                                    AppIcon.dropdownicon,
                                    //fit: BoxFit.,
                                    color: AppColors.textgreyThemecolor,
                                    width: 10,
                                    height: 10,
                                    key: const Key(Keys.userIcon),
                                  ),
                                ),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///created by

                            CommonWidgets.horizentaltextHandling(
                                Constants.createdby,
                                isMandatory: true,
                                '${state.loggedInUser?.firstName ?? ''} ${state.loggedInUser?.lastName ?? ''}'),

                            // ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location

                            CommonWidgets.textDisplay(
                                Constants.location, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// date of creation
                            CommonWidgets.textDisplay(Constants.dateofcreation,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// slno

                            CommonWidgets.horizentaltextHandling(
                                Constants.slno, serialNumber,
                                isMandatory: true),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// asset type
                            CommonWidgets.textDisplay(
                                Constants.assettype, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (widget.model?.status == 0 ||
                                    widget.model == null) {
                                  assetTypeDialog();
                                }
                              },
                              child: FlutterInputField(
                                  isEnable: false,
                                  isDisableColor:
                                      widget.model?.status == 0 ? false : true,
                                  textFieldController: assettypeTextController,
                                  textFormKey: Keys.statusTextController,
                                  hintText: '',
                                  onChange: (String username) {
                                    //this.username = username;
                                    setState(() {});
                                  },
                                  onTap: () {
                                    if (widget.model?.status == 0 ||
                                        widget.model == null) {
                                      assetTypeDialog();
                                    }
                                  },
                                  validateTextField: (String? user) {},
                                  suffixWidget: IconButton(
                                      icon: SvgPicture.asset(
                                          width: 10,
                                          height: 10,
                                          AppIcon.dropdownicon,
                                          key: const Key('closed_eye')),
                                      onPressed: () {
                                        assetTypeDialog();
                                      })),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// article type
                            CommonWidgets.textDisplay(
                                Constants.articleType, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            articleaddButtonwidgetLoading(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// found date
                            CommonWidgets.textDisplay(
                                Constants.founddate, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datepickerWidgetLoading(foundDateTextController),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// found location

                            CommonWidgets.textDisplay(Constants.foundlocation,
                                Styles.textStyleBlack14,
                                isMandatory: true),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: foundLocationTextController,
                              textFormKey: Keys.foundLocationTextController,
                              hintText: '',
                              isEnable: widget.model?.status == 0 ||
                                      widget.model == null
                                  ? true
                                  : false,
                              isDisableColor:
                                  widget.model?.status == 0 ? false : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// additional information
                            CommonWidgets.textDisplay(
                                Constants.additionalinformation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              showBorder: true,
                              lineHeight: 6,
                              textFieldController:
                                  additionalinformationTextController,
                              textFormKey:
                                  Keys.additionalinformationTextController,
                              hintText: Constants.informationhere,
                              isEnable: widget.model?.status == 0 ||
                                      widget.model == null
                                  ? true
                                  : false,
                              isDisableColor: widget.model?.status == 0 ||
                                      widget.model == null
                                  ? false
                                  : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// quantitiy
                            CommonWidgets.textDisplay(
                                Constants.quantity, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              textFieldController: quantityTextController,
                              textFormKey: Keys.quantityTextController,
                              hintText: '',
                              isEnable: widget.model?.status == 0 ||
                                      widget.model == null
                                  ? true
                                  : false,
                              isDisableColor:
                                  widget.model?.status == 0 ? false : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// color
                            CommonWidgets.textDisplay(
                                Constants.colour, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: colorTextController,
                              textFormKey: Keys.colorTextController,
                              hintText: '',
                              isEnable: widget.model?.status == 0 ||
                                      widget.model == null
                                  ? true
                                  : false,
                              isDisableColor:
                                  widget.model?.status == 0 ? false : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// is Depositor DBEmployee
                            CommonWidgets.textDisplay(
                                Constants.isdepositordbemployee,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            radioButtonHandling(isDepositorDBEmployeeSelected,
                                Constants.isdepositordbemployee,
                                isDisableColor: (widget.model?.status == null ||
                                        widget.model?.status == 0)
                                    ? false
                                    : true),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// depositor
                            CommonWidgets.textDisplay(
                                Constants.depositor, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title: selecteddepositorList?.name != null
                                        ? ('${selecteddepositorList?.name ?? ''}(${selecteddepositorList?.email ?? ''})')
                                        : '',
                                    height: 70,
                                    isDisableColor: widget.model?.status == 1 ||
                                            widget.model?.status == 2
                                        ? true
                                        : false,
                                    onTap: () {
                                      if (widget.model?.status == 0 ||
                                          widget.model == null) {
                                        depositorDialog(
                                            state, Constants.depositor);
                                      }
                                    })
                                : FlutterInputField(
                                    textFieldController:
                                        depositorTextController,
                                    textFormKey: Keys.depositorTextController,
                                    hintText: '',
                                    isEnable: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status != 0
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Depositor Employee id
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.textDisplay(
                                    Constants.depositoremployeeid,
                                    Styles.textStyleBlack14,
                                    isMandatory: true)
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),

                            isDepositorDBEmployeeSelected == 1
                                ? FlutterInputField(
                                    textFieldController:
                                        depositorEmpIdTextController,
                                    textFormKey:
                                        Keys.depositorEmpIdTextController,
                                    hintText: '',
                                    isEnable: (widget.model?.status == null ||
                                            widget.model?.status == 0)
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status != 0
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),

                            /// Employee department
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.textDisplay(
                                    Constants.employeedepartment,
                                    Styles.textStyleBlack14,
                                    isMandatory: true)
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title:
                                        selectedEmployeedepartment?.name ?? '',
                                    height: 60,
                                    isDisableColor: widget.model?.status == 1 ||
                                            widget.model?.status == 2
                                        ? true
                                        : false,
                                    onTap: () {
                                      if (widget.model == null ||
                                          widget.model?.status == 0) {
                                        employeeDepartmentDialog(state,
                                            Constants.employeedepartment);
                                      }
                                    },
                                  )
                                : Container(),
                            widget.model != null &&
                                    isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),

                            if (widget.model?.status == 1 ||
                                widget.model?.status == 2) ...[
                              /// is claimant db employee
                              widget.model != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantdbemployee,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              widget.model != null
                                  ? radioButtonHandling(
                                      isClaimantDBEmployeeSelected,
                                  isDisableColor: (
                                      widget.model?.status == 2)
                                      ? true
                                      : false,
                                      Constants.isclaimantdbemployee,
                                     )
                                  : Container(),

                              /// claimant
                              widget.model != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimant,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 0
                                  ? FlutterInputField(
                                      textFieldController:
                                          claimantTextController,
                                      textFormKey: Keys.claimantTextController,
                                      hintText: claimant,
                                      isEnable: widget.model?.status != 2
                                          ? true
                                          : (widget.model != null &&
                                                  (widget.model?.claimant
                                                              ?.lastName ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor:
                                          (widget.model?.status != 2 &&
                                                  (widget.model?.claimant
                                                              ?.lastName ??
                                                          '')
                                                      .isEmpty)
                                              ? false
                                              : true,
                                      onChange: (String username) {
                                        //this.username = username;
                                        claimant = username;
                                        setState(() {});
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : widget.model != null
                                      ? TextfieldAddButton(
                                          title: selectedClaimList?.name ?? '',
                                          height: 60,
                                          isDisableColor:
                                              widget.model?.status != 2
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            if (widget.model?.status != 2) {
                                              depositorDialog(
                                                  state, Constants.claimant);
                                            }
                                          },
                                        )
                                      : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.model != null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              /// Claimant employee id

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimantemployeeid,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? FlutterInputField(
                                      keyboardType: TextInputType.number,
                                      textFieldController:
                                          claimantEmpIdTextController,
                                      textFormKey:
                                          Keys.claimantEmpIdTextController,
                                      isEnable: widget.model?.status != 2
                                          ? true
                                          : (widget.model != null &&
                                                  (widget.model
                                                              ?.claimantEmployeeId ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor:
                                          (widget.model?.status != 2)
                                              ? false
                                              : true,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                        setState(() {});
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : Container(),

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              /// claimant department

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimantdepartment,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? TextfieldAddButton(
                                      title:
                                          (selectedClaimdepartment?.name ?? ''),
                                      height: 60,
                                isDisableColor:
                                widget.model?.status != 2
                                    ? false
                                    : true,
                                      onTap: () {
                                        if (widget.model?.status != 2) {
                                          employeeDepartmentDialog(state,
                                              Constants.claimantdepartment);
                                        }
                                      },
                                    )
                                  : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              /// is claimant accepted by email

                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantacceptedbyemail,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              widget.model != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? radioButtonHandling(
                                      isClaimantAcceptedByemail,
                                  isDisableColor: (
                                      widget.model?.status == 2)
                                      ? true
                                      : false,
                                      Constants.isclaimantacceptedbyemail)
                                  : Container(),

                              /// is claimant accepted to sign

                              widget.model != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantacceptedtosign,
                                      Styles.textStyleBlack14,
                                      isMandatory: true)
                                  : Container(),
                              widget.model != null
                                  ? radioButtonHandling(
                                      isClaimantAcceptedtoSignSelected,
                                  isDisableColor: (
                                      widget.model?.status == 2)
                                      ? true
                                      : false,
                                      Constants.isclaimantacceptedtosign)
                                  : Container(),

                              ///TODO: Need to work on signature
                              /// Claimant Signature
                              // widget.model != null &&
                              //         isClaimantAcceptedtoSignSelected == 1
                              //     ? CommonWidgets.textDisplay(
                              //         Constants.claimantsignature,
                              //         Styles.textStyleBlack14,
                              //         isMandatory: true)
                              //     : Container(),
                              // widget.model != null &&
                              //         isClaimantAcceptedtoSignSelected == 1
                              //     ? CommonWidgets.verticalSpacerWidget(
                              //         height * 0.001)
                              //     : Container(),
                              // widget.model != null &&
                              //         isClaimantAcceptedtoSignSelected == 1
                              //     ? FlutterInputField(
                              //         lineHeight: 6,
                              //         textFieldController:
                              //             claimantsignatureTextController,
                              //         isEnable: false,
                              //         textFormKey:
                              //             Keys.claimantsignatureTextController,
                              //         isDisableColor: true,
                              //         hintText: '',
                              //         onChange: (String username) {
                              //           //this.username = username;
                              //           setState(() {});
                              //         },
                              //         validateTextField: (String? user) {},
                              //       )
                              //     : Container(),
                              // widget.model != null
                              //     ? CommonWidgets.verticalSpacerWidget(
                              //         height * 0.01)
                              //     : Container(),
                            ],
                            // if (widget.model?.status == 1 ||
                            //     widget.model?.status == 2) ...[
                            //   buildSignature(
                            //     controller: claimantSignature,
                            //     label: Constants.claimantsignature,
                            //     spaceHeight: height,
                            //     state: state,
                            //   ),
                            // ],
                            /// Item Handover By
                            if (widget.model?.status == 2) ...[
                              CommonWidgets.horizentaltextHandling(
                                  Constants.itemhandoverby, itemhandoverByValue,
                                  isMandatory: true),

                              /// Handed over date
                              CommonWidgets.textDisplay(
                                Constants.handedoverdate,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datepickerWidgetLoading(
                                  handedoverdatedateTextController),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload
                            widget.model == null
                                ? Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFCACACA),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize:
                                                      const Size(140, 50)),
                                              onPressed: () {
                                                // Navigator.pushNamed(context,
                                                //     createFoundAttachmentRoute);
                                                //UploadAttachment();
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return UploadAttachment(
                                                        userdetails:
                                                            userDetails,
                                                        getFiles: getFiles,
                                                        createoundstate: state,
                                                      );
                                                    });
                                              },

                                              icon: SvgPicture.asset(
                                                //AppIcon.dropdownicon,
                                                AppIcon.uploadicon,
                                                //fit: BoxFit.,
                                                color: AppColors
                                                    .backgroundWhitecolor,
                                                width: 13,
                                                height: 13,
                                                key: const Key(Keys.userIcon),
                                              ),
                                              // const Icon(
                                              //   // <-- Icon
                                              //   Icons.upload,
                                              //   color: AppColors.backgroundWhitecolor,
                                              //   size: 24.0,
                                              // ),
                                              label: const Text(
                                                Constants.clicktoupload,
                                                style: Styles
                                                    .textStyleRegularNormalWhite12,
                                              ), // <-- Text
                                            ),
                                          ),
                                        ]),
                                  )
                                : Container(),

                            getFiles.isNotEmpty || getAttachments.isNotEmpty
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),
                            (getAttachments.isEmpty || widget.model == null)
                                ? getFiles.isEmpty
                                    ? Container()
                                    : attachmentListviews(
                                        getFiles, getAttachments)
                                : attachmentListviews(getFiles, getAttachments),

                            // TODO: Need to use this to view the attachments
                            // if (!getAttachments.isEmptyOrNull ) ...[
                            //   BaseImageUpload().getAttachment(
                            //     height: height,
                            //     attachments: getAttachments,
                            //     files: getFiles,
                            //     showDownloadIcon:
                            //         widget.model != null ? true : false,
                            //   ),
                            // ],

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (widget.model?.status != 2) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  cancelButtonDisplay(),
                                  submitButtonDisplay(state)
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),
                            ],
                          ],
                        )),
                  ),
                ])));
          },
        ));
  }

  Column buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required CreateFoundState state,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidgets.textDisplay(
              label,
              Styles.textStyleBlack14,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  iconSize: 20,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh),
                ),
                // IconButton(
                //   onPressed: onDoneTap,
                //   iconSize: 20,
                //   color: Colors.grey,
                //   icon: const Icon(Icons.done_outlined),
                // ),
              ],
            ),
          ],
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
        ClipRect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                color: AppColors.gerylightBackground,
                width: 1, // Border width
              ),
            ),
            height: 100,
            width: double.infinity,
            child: Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
      ],
    );
  }

  Widget submitButtonDisplay(CreateFoundState state) {
    return // Login button
        AppButton(
      width: 150,
      // disableColor: isHandedOver,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        createFoundValidations(context, state);
      },
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget locationWidgetdislay(CreateFoundState state) {
    return GestureDetector(
      onTap: () {
        //if (widget.listuser == null || locationselectedText.isEmpty)
        {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return CustomExpansionListTexts(
                getLocationsresponse:
                    state.getLocationsResponse ?? GetLocations(),
                onTap: (Organisation? list) async {
                  await createFoundArticleCubit.getSerialnumberDetails(
                      list?.id.toString() ?? '', 'AF', context);
                  locationselectedText = list?.name ?? '';
                  locationSelectedlist = list;
                  setState(() {});
                },
              );
            },
          );
        }
      },
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFCACACA),
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: locationselectedText.isEmpty
              ? Container()
              : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.normaltextBackground),
                        ),
                        onPressed: () {},
                        child: Text(
                          locationselectedText,
                          style: Styles.textStyleBlack14,
                        ),
                      ),
                    ),
                  )
                ])),
    );
  }

  Widget datecreateWidgetdisplay() {
    return FlutterInputField(
      textFieldController: dateofcreationTextController,
      textFormKey: Keys.dateofcreationTextController,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String username) {
        //this.username = username;
        //setState(() {});
      },
      validateTextField: (String? user) {},
    );
  }

  Widget radioButtonHandling(
    int selectedValue,
    String name, {
    bool? isDisableColor = false,
  }) {
    isDisableColor ??= widget.model?.status == 1 || widget.model?.status == 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: isDisableColor
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          // focusColor:
          //     AppColors.navigationSkybluecolor,

          value: 1,
          groupValue: selectedValue,
          onChanged: (val) {
            radioButtonItem = 'Yes';
            selectedValue = 1;
            if (name == Constants.isclaimantacceptedtosign &&
                widget.model?.status != 2) {
              isClaimantAcceptedtoSignSelected = selectedValue;
            } else if (name == Constants.isclaimantacceptedbyemail &&
                widget.model?.status != 2) {
              isClaimantAcceptedByemail = selectedValue;
            } else if (name == Constants.isclaimantdbemployee &&
                widget.model?.status != 2) {
              isClaimantDBEmployeeSelected = selectedValue;
            } else if (name == Constants.isdepositordbemployee &&
                widget.model?.status != 1 &&
                widget.model?.status != 2) {
              isDepositorDBEmployeeSelected = selectedValue;
            }
            setState(() {});
          },
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: isDisableColor
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          value: 0,
          groupValue: selectedValue,
          onChanged: (val) {
            radioButtonItem = 'No';
            selectedValue = 0;
            if (name == Constants.isclaimantacceptedtosign&&
                widget.model?.status != 2) {
              isClaimantAcceptedtoSignSelected = selectedValue;
            } else if (name == Constants.isclaimantacceptedbyemail &&
                widget.model?.status != 2) {
              isClaimantAcceptedByemail = selectedValue;
            } else if (name == Constants.isclaimantdbemployee &&
                widget.model?.status != 2) {
              isClaimantDBEmployeeSelected = selectedValue;
            } else if (name == Constants.isdepositordbemployee &&
                widget.model?.status != 1 &&
                widget.model?.status != 2)  {
              isDepositorDBEmployeeSelected = selectedValue;
            }
            setState(() {});
          },
        ),
        const Text(Constants.no),
      ],
    );
    //return Container();
  }

  Widget articleaddButtonwidgetLoading(CreateFoundState state) {
    return TextfieldAddButton(
      title: selectedArtclelist?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status == 1 || widget.model?.status == 2
          // widget.model != null
          ? true
          : false,
      onTap: () {
        if (widget.model?.status == 0 || widget.model == null) {
          articleTypeDialog(state);
        }
      },
    );
  }

  Widget datepickerWidgetLoading(TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        log('-widget.listuser?.status----${widget.model?.status}----');
        if (widget.model?.status == null || widget.model?.status == 0) {
          datePickerDialog(controller);
        }
      },
      child: FlutterInputField(
        textFieldController: controller,
        textFormKey: controller == foundDateTextController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor: widget.model?.status != 0 ? false : true,
        onChange: (String username) {
          //this.username = username;
          setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (widget.model == null ||
                controller.text.isEmpty ||
                widget.model?.status == 0) {
              datePickerDialog(controller);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (attachmentListviews1?.length ?? 0) >
                (attachmentListviews?.length ?? 0)
            ? attachmentListviews1?.length
            : attachmentListviews?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          CreateImage? imageData;
          FoundImage? imageData1;
          if (widget.model != null) {
            imageData1 = attachmentListviews1?[index];
          } else {
            imageData = attachmentListviews?[index];
          }
          return Column(
            children: <Widget>[
              ListTile(
                trailing: widget.model != null
                    ? SvgPicture.asset(AppIcon.download,
                        color: AppColors.boldgreyBackground)
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                onTap: () {
                  DownloadImage().saveImage(
                      context, imageData1?.id ?? 0, imageData1?.title ?? '');
                },
                title: widget.model != null
                    ? Text(imageData1?.title ?? '')
                    : Text(imageData?.title ?? ''),
              ),

              const Divider(
                color: Color(0xFFCACACA),
                thickness: 1,
              ), //
            ],
          );
        },
      ),
    );
  }
}
