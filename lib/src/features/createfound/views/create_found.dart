import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_cubit.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/attachment_model.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Createfound extends StatefulWidget {
  FoundListArticleDetails? listuser;

  Createfound({super.key,this.listuser});
  
  @override
  State<Createfound> createState() => _CreatefoundState();
}

class _CreatefoundState extends State<Createfound> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';
  String serialNumber = '';

  // Group Value for Radio Button.
  int isDepositorDBEmployeeSelected = 1;
  final GlobalKey<FormState> createfoundFormKey = GlobalKey<FormState>();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController foundLocationTextController = TextEditingController();
  TextEditingController depositorEmpIdTextController = TextEditingController();
  TextEditingController additionalinformationTextController = TextEditingController();
  TextEditingController founddateTextController = TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController assettypeTextController = TextEditingController();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController depositorTextController = TextEditingController();
  String isDepositorDBEmployee = "";
  // String slnoValue = "dfwe";
  String createdByValue = "";
  String locationselectedText = "";
  EmployeeDepartment? selectedEmployeedepartment;
  ArticleList? selectedArtclelist;
  AtomStaticUser? selecteddepositorList;
  GetUserDetails? userDetails;
  Mumbai? locationSelectedlist;
  SubmitCreateFoundModel? createfoundResponse;
  SerialNumberModel? serialnumberResponse;
  List<AttachmentModel>? getAttachments;

  @override
  void initState() {
    super.initState();
    if (widget.listuser != null)
    {
      editCreatefoundItems();
    }
    _getFoundArticleList();
     _getCurrentDate();
  }
  editCreatefoundItems()
  {
    if (widget.listuser != null)
    {
    
     selecteddepositorList = AtomStaticUser(email:widget.listuser?.depositor?.email ?? "" ,id: widget.listuser?.depositor?.userId ?? 1,name: widget.listuser?.depositor?.name ?? "") ;
     selectedArtclelist = ArticleList(id: 0,name: widget.listuser?.entrySecurityName ?? "");
     userDetails = GetUserDetails(userId: widget.listuser?.entrySecurity?.userId ?? 0,lastName: widget.listuser?.entrySecurity?.lastName ?? "");
     createdByValue =  userDetails?.lastName ?? '';
     serialNumber = widget.listuser?.slNo ?? "";
     locationSelectedlist =  Mumbai(id: widget.listuser?.id ?? 0, name: widget.listuser?.locationName ?? "");
     locationselectedText = locationSelectedlist?.name ?? "";
     quantityTextController.text = widget.listuser?.quantity.toString() ?? "";
     colorTextController.text =  widget.listuser?.color.toString() ?? "";
     foundLocationTextController.text =  widget.listuser?.foundLocation.toString() ?? "";
     additionalinformationTextController.text = widget.listuser?.additionalInformation.toString() ?? "";
     founddateTextController.text = Utils.timestamptoDateConversion(
                                  widget.listuser?.foundDate ?? 0, Constants.fulldateFormat);
     dateofcreationTextController.text = Utils.timestamptoDateConversion(
                                  widget.listuser?.inputDate ?? 0, Constants.fulldateFormat);
     assettypeTextController.text = widget.listuser?.typeOfAsset.toString() ?? "";
     statusTextController.text = widget.listuser?.status.toString() ?? "";
     depositorTextController.text = widget.listuser?.depositor != null ? ((widget.listuser?.depositor?.name ?? "") + '(' + (widget.listuser?.depositor?.email ?? "") + ')') :"";
     isDepositorDBEmployeeSelected = ((widget.listuser?.depositorDbEmp ?? false) == true) ? 1 : 0;
     depositorEmpIdTextController.text = widget.listuser?.employeeId ?? '';
     selectedEmployeedepartment = EmployeeDepartment(id: 0, name:widget.listuser?.depositorDepartmentName ?? '' );
    }
  }

  Future createNewuserBody(bool isSubmit) async {
     var username = await SharedPrefs.getUsername();
    bool isDepositorDBEmployeeSelectedvalue = isDepositorDBEmployeeSelected == 1 ? true : false;
    TypeOfArticle? typeOfArticle = TypeOfArticle(id: selectedArtclelist?.id ?? 0);
    EntrySecurity? entrysecurtity = EntrySecurity(userId: userDetails?.userId ?? 0);
    Depositor? depositor = Depositor(userId: selecteddepositorList?.id ?? 1);
    CreateLocation? location = CreateLocation(id: locationSelectedlist?.id ?? 0);
    DepositorDepartment? depositordep =
        DepositorDepartment(id: selectedEmployeedepartment?.id ?? 1);
    Found? found = Found(
        slNo: serialNumber,
        typeOfAsset:  (assettypeTextController.text.toLowerCase()) == 'company' ? 1 : 0,
        typeOfArticle: typeOfArticle,
        foundLocation:
            foundLocationTextController.text.length > 0 ? foundLocationTextController.text : '',
        additionalInformation: additionalinformationTextController.text.length > 0
            ? additionalinformationTextController.text
            : '',
        quantity:
            quantityTextController.text.length > 0 ? int.parse(quantityTextController.text) : 0,
        color: colorTextController.text.length > 0 ? colorTextController.text : '',
        status: int.parse((statusTextController.text.toLowerCase() == "found")
            ? '0'
            : statusTextController.text.length > 0
                ? statusTextController.text
                : ''),
        depositorDbEmp: isDepositorDBEmployeeSelectedvalue,
        inputDate:
            dateofcreationTextController.text.length > 0 ? dateofcreationTextController.text : '',
        foundDate: founddateTextController.text.length > 0 ? founddateTextController.text : '',
        entrySecurity: entrysecurtity,
        location: location,
        depositorName: isDepositorDBEmployeeSelected == 1
            ? selecteddepositorList?.name ?? ''
            : depositorTextController.text.length > 0
                ? depositorTextController.text
                : '',
        depositor: depositor,
        depositorDepartment: depositordep,
        employeeId:
            depositorEmpIdTextController.text.length > 0 ? depositorEmpIdTextController.text : '');
    CreateFoundRequestBody requestBody = CreateFoundRequestBody(found: found);
     showLoadingDialog(context);
    await createFoundArticleCubit.createNewFoundArticle(requestBody, isSubmit, context,username);
  }

  void _getFoundArticleList() async {
    
    await createFoundArticleCubit.getUserByRoleDepositor('ATOM_STATIC_USER');
    await createFoundArticleCubit.getLocations('ATOM_LOCATIONS');
    await createFoundArticleCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
    await createFoundArticleCubit.getArticleType('ARTICLE_LIST');
    // await createFoundArticleCubit.createOrganisation(
    //     'Mobile Charger', 'ARTICLE_LIST');
    // await createFoundArticleCubit.createUser('Testing', 'Rest Api User 1',
    //     'restApiStaticUser@gmail.com', 'ATOM_STATIC_USER');
     if (widget.listuser == null)
    {
    await createFoundArticleCubit.getUserDetails('14');
    }
  }

  void _getCurrentDate() {
    String formattedDate = DateFormat(Constants.fulldateFormat).format(DateTime.now());
    print(formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    dateofcreationTextController.text = formattedDate;
    statusTextController.text = 'Found';
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  _createFoundAlert(BuildContext context, String messgae) {
    var dialog = CustomAlertDialog(
        title: 'Create Found',
        message: messgae,
        onPostivePressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: '');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
  createdraftValidations(BuildContext context)
  {
      if((locationSelectedlist?.name ?? "").isEmpty )
      {
        Validator().showToast(
        context,
        "Please enter location",
      );
      }
      else if ((selectedArtclelist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter article name",
      );
    }
    else if (isDepositorDBEmployeeSelected == 0 && depositorTextController.text.isEmpty)
    {
      if (depositorTextController.text.isEmpty) {
        Validator().showToast(context, "Please enter depositor");   
      }
    }
    else if (isDepositorDBEmployeeSelected == 1 && (((selecteddepositorList?.name ?? "").isEmpty) || (depositorEmpIdTextController.text.isEmpty) || ((selectedEmployeedepartment?.name ?? "").isEmpty)))
    {
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
      createNewuserBody(false);
    }
  }

  createfoundValidations(BuildContext context) {
    if (statusTextController.text.isEmpty &&
        createdByValue.isEmpty &&
        (locationSelectedlist?.name ?? "").isEmpty &&
        dateofcreationTextController.text.isEmpty &&
        serialNumber.isEmpty &&
        assettypeTextController.text.isEmpty &&
        (selectedArtclelist?.name ?? "").isEmpty &&
        founddateTextController.text.isEmpty &&
        foundLocationTextController.text.isEmpty &&
        additionalinformationTextController.text.isEmpty &&
        quantityTextController.text.isEmpty &&
        (((isDepositorDBEmployeeSelected == 1 && (selecteddepositorList?.name ?? "").isEmpty) &&
                depositorEmpIdTextController.text.isEmpty &&
                (selectedEmployeedepartment?.name ?? "").isEmpty) ||
            (isDepositorDBEmployeeSelected == 0 && depositorTextController.text.isEmpty))) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
    } else if (createdByValue.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator name",
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
        "Please enter article name",
      );
    } else if (founddateTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found date",
      );
    } else if (foundLocationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found location",
      );
    } else if (additionalinformationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter additional information",
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
    } 
   else {
      createNewuserBody(true);
    }
  }
  assetTypeDialog()
  {
    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomSimpleListTexts(
                                            texts: ["Personal", "company"],
                                            onTap: (String value) {
                                              print(value);
                                              assettypeTextController.text = value;
                                              setState(() {});
                                            },
                                          );
                                        });
                                  
  }
  articleTypeDialog(CreateFoundState state)
  {
    showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return CustomListTexts(
                                        articleList:
                                            state.getArticleTypeResponse?.articleList ?? [],
                                        leftimagename: AppIcon.addicon,
                                        onLeftButtonTap: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext dialogContext) {
                                                return const AddEmployeeDepartment(
                                                  title: Constants.addarticletype,
                                                );
                                              });
                                        },
                                        onTap: (ArticleList list) {
                                          print(list.name);
                                          selectedArtclelist = list;
                                          setState(() {});
                                        },
                                      );
                                    });
  }
  datePickerDialog()
  async {
    // datePickerselection(context, founddateTextController);
                                  DateTime? pickedDate = await showDateTimePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate = DateFormat('dd/MM/yyyy a HH:mm:ss')
                                      .format(pickedDate ?? DateTime.now());
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement
                                  founddateTextController.text = formattedDate;
                                  setState(() {
                                    // dateinput.text = formattedDate; //set output date to TextField value.
                                  });
  }
  colorDailog()
  {
     showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomSimpleListTexts(
                                        texts: const ["Red", "Yellow", "White", "Black", "Orange"],
                                        onTap: (String value) {
                                          print(value);
                                          colorTextController.text = value;
                                          FocusScope.of(context).unfocus();
                                          colorTextController.clear;
                                          setState(() {});
                                        },
                                      );
                                    });
                              
  }
  depositorDialog(CreateFoundState state)
  {
    showDialog(
                                          context: context,
                                          builder: (BuildContext dialogContext) {
                                            return CustomListTexts(
                                              depostorList:
                                                  state.getDepositorResponse?.atomStaticUser ?? [],
                                              leftimagename: AppIcon.addicon,
                                              onLeftButtonTap: () {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext dialogContext) {
                                                      return const CreateFoundNewUser();
                                                    });
                                              },
                                              onTap: (AtomStaticUser list) {
                                                print(list.name);
                                                selecteddepositorList = list;
                                                setState(() {});
                                              },
                                            );
                                          });
                                   
  }
  employeeDepartmentDialog(CreateFoundState state)
  {
    showDialog(
                                          context: context,
                                          builder: (BuildContext dialogContext) {
                                            return CustomListTexts(
                                              employeeDepartments: state
                                                      .getEmployeeDepartmentsResponse
                                                      ?.employeeDepartments ??
                                                  [],
                                              leftimagename: AppIcon.addicon,
                                              onLeftButtonTap: () {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext dialogContext) {
                                                      return const AddEmployeeDepartment(
                                                        title: Constants.addemployeedepartment,
                                                      );
                                                    });
                                              },
                                              onTap: (EmployeeDepartment list) {
                                                print(list.name);
                                                selectedEmployeedepartment = list;
                                                setState(() {});
                                              },
                                            );
                                          });
                                    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar: AppHeader(
          isTitleCenter: false,
          title: Constants.createfound,
          backBtn: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppIcon.backIcon, color: AppColors.backgroundWhitecolor),
          ),
          action: [
            GestureDetector(
              onTap: () {
                //for now the new param is isSubmit added, if any new params needed we can add to this.
                //createNewuserBody(false); //for save
                createdraftValidations(context);
                // createNewuserBody(false);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(
                  AppIcon.createfoundsaveicon,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //createNewuserBody(); //in this method createfoundValidations, calling the createNewuserBody
                createfoundValidations(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.send,
                  color: AppColors.backgroundWhitecolor,
                ),
                // SvgPicture.asset(
                //   AppIcon.createfoundsaveicon,
                //),
              ),
            ),
          ],
          //backgroundColor: AppColors.navigationSkybluecolor,
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
          builder: (context, state) {
            createfoundResponse = state.createFoundResponse;
            serialnumberResponse = state.getSerialnumberResponse;
            if (serialnumberResponse != null)
            {
              serialNumber = serialnumberResponse?.serialNo ?? "";
            }
            
            if (getAttachments == null || getAttachments?.length == 0) {
              getAttachments = state.loadAttachments ?? [];
            } else {
              if (state.loadAttachments != null && state.loadAttachments?.length != 0) {
                getAttachments?.addAll(state.loadAttachments ?? []);
              }
            }
            // if (createfoundResponse?.message != null) {
            //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            //     _createFoundAlert(context, createfoundResponse?.message ?? '');
            //   });
            // }

            userDetails = state.getUserDetailsResponse ?? GetUserDetails();
            if (userDetails != null)
            {
              createdByValue = userDetails?.lastName ?? '';
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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.status,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            // Status
                            FlutterInputField(
                              isEnable: false,
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

                            //created by

                            // GestureDetector(
                            //   onTap: () {
                            //     // showDialog(
                            //     //   context: context,
                            //     //   builder: (BuildContext dialogContext) {
                            //     //     return const CreateFoundNewUser();
                            //     //   },
                            //     // );
                            //   },
                            // child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    Constants.createdby,
                                    style: Styles.textStyleBlack14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      createdByValue,
                                      style: Styles.textStyleBoldGreydark14,
                                    )),
                              ],
                            ),

                            // ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // Location

                            Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.location,
                                  style: Styles.textStyleBlack14,
                                )),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    print(state.getLocationsResponse);
                                    return CustomExpansionListTexts(
                                      getLocationsresponse:
                                          state.getLocationsResponse ?? GetLocations(),
                                      onTap: (Mumbai? list) async {
                                        print(list?.name);
                                        await createFoundArticleCubit.getSerialnumberDetails(list?.id.toString() ?? '', 'AF');
                                        locationselectedText = list?.name ?? '';
                                        locationSelectedlist = list;
                                        setState(() {});
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFCACACA),
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
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // date of creation
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.dateofcreation,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: dateofcreationTextController,
                              textFormKey: Keys.dateofcreationTextController,
                              hintText: '',
                              isEnable: false,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                              // suffixWidget: GestureDetector(
                              //   onTap: () async {
                              //     // datePickerselection(context, dateofcreationTextController);

                              //     DateTime? pickedDate =
                              //         await showDateTimePicker(
                              //             context: context,
                              //             initialDate: DateTime.now(),
                              //             firstDate: DateTime(2000),
                              //             lastDate: DateTime(2101));

                              //     print(
                              //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              //     String formattedDate =
                              //         DateFormat('dd-MM-yyyy a HH:mm:ss')
                              //             .format(pickedDate ?? DateTime.now());
                              //     print(
                              //         formattedDate); //formatted date output using intl package =>  2021-03-16
                              //     //you can implement different kind of Date Format here according to your requirement
                              //     dateofcreationTextController.text =
                              //         formattedDate;
                              //     setState(() {
                              //       // dateinput.text = formattedDate; //set output date to TextField value.
                              //     });
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(20.0),
                              //     child: SvgPicture.asset(
                              //       AppIcon.calendaricon,
                              //       color: AppColors.textgreyThemecolor,
                              //       width: 20,
                              //       key: const Key(Keys.userIcon),
                              //     ),
                              //   ),
                              // ),
                              // IconButton(
                              //   icon: SvgPicture.asset(
                              //     AppIcon.userIcon,
                              //     color: AppColors.textColor,
                              //     //width: 60,
                              //     key: const Key(Keys.userIcon),
                              //   ),
                              //   onPressed: () {
                              //     datePickerselection(context);
                              //   },
                              // )
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // slno
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    Constants.slno,
                                    style: Styles.textStyleBlack14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  serialNumber,
                                  style: Styles.textStyleBoldGreydark14,
                                ),
                              ],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // asset type
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.assettype,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                             GestureDetector(
                              onTap: () {
                                assetTypeDialog();
                              },
                              child: FlutterInputField(
                                  isEnable: false,
                                  textFieldController: assettypeTextController,
                                  textFormKey: Keys.statusTextController,
                                  hintText: '',
                                  onChange: (String username) {
                                    //this.username = username;
                                    setState(() {});
                                  },
                                  onTap: ()
                                  {
                                     assetTypeDialog();
                                  },
                                  validateTextField: (String? user) {},
                                  suffixWidget: IconButton(
                                    icon:
                                        //Padding(
                                        // padding: const EdgeInsets.all(20.0),
                                        // child: SvgPicture.asset(
                                        //   //AppIcon.dropdownicon,
                                        //   AppIcon.dropdownicon,
                                        //   //fit: BoxFit.,
                                        //   color: AppColors.textgreyThemecolor,
                                        //   width: 10,
                                        //   height: 10,
                                        //   key: const Key(Keys.userIcon),
                                        // ),
                                        // ),
                                        SvgPicture.asset(
                                            width: 10,
                                            height: 10,
                                            AppIcon.dropdownicon,
                                            key: const Key('closed_eye')),
                                    onPressed: () {
                                      print('suffixIcon pressed');
                                      
                                       assetTypeDialog();
                                    }
                                  )),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // article type
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.articletype,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            TextfieldAddButton(
                              title: selectedArtclelist?.name ?? '',
                              height: 60,
                              onTap: () {
                                articleTypeDialog(state);
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // found date
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.founddate,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                           GestureDetector(
                              onTap: () {
                                 datePickerDialog();
                              },
                              child: FlutterInputField(
                                textFieldController: founddateTextController,
                                textFormKey: Keys.founddateTextController,
                                hintText: '',
                                isEnable: false,
                                onChange: (String username) {
                                  //this.username = username;
                                  print('dfwf');
                            
                                  setState(() {});
                                },
                                validateTextField: (String? user) {},
                            
                                suffixWidget: GestureDetector(
                                  onTap: () async {
                                    datePickerDialog();
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
                                // IconButton(
                                //   icon: SvgPicture.asset(
                                //     AppIcon.userIcon,
                                //     color: AppColors.textColor,
                                //     //width: 60,
                                //     key: const Key(Keys.userIcon),
                                //   ),
                                //   onPressed: () {
                                //     datePickerselection(context);
                                //   },
                                // ),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // found location

                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.foundlocation,
                                style: Styles.textStyleBlack14,
                              ),
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: foundLocationTextController,
                              textFormKey: Keys.foundLocationTextController,
                              hintText: '',
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // additional information
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.additionalinformation,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              textFieldController: additionalinformationTextController,
                              textFormKey: Keys.additionalinformationTextController,
                              hintText: Constants.informationhere,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // quantitiy
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.quantity,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              textFieldController: quantityTextController,
                              textFormKey: Keys.quantityTextController,
                              hintText: '',
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // color
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.colour,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // GestureDetector(
                            //   onTap: () {
                            // FocusScope(
                            //     child: Focus(
                            //         onFocusChange: (focus) {
                            //           showDialog(
                            //               context: context,
                            //               builder: (BuildContext context) {
                            //                 return CustomSimpleListTexts(
                            //                   texts: const [
                            //                     "Red",
                            //                     "Yellow",
                            //                     "White",
                            //                     "Black",
                            //                     "Orange"
                            //                   ],
                            //                   onTap: (String value) {
                            //             print(value);
                            //             colorTextController.text =
                            //                 value;
                            //             FocusScope.of(context)
                            //                 .unfocus();
                            //             colorTextController.clear;
                            //             setState(() {});
                            //           },
                            //         );
                            //       });
                            // },
                            //child:
                            FlutterInputField(
                              onTap: () {
                               colorDailog();
                              },
                              textFieldController: colorTextController,
                              textFormKey: Keys.colorTextController,
                              hintText: '',
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                              // )
                              //)
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // is depositor employee
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.isdepositordbemployee,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            //Container(
                            //width: width - 160,
                            // child:

                            //  Row(
                            //   // textDirection: TextDirection.rtl,
                            //   //crossAxisAlignment: CrossAxisAlignment.start,
                            //   //mainAxisAlignment: MainAxisAlignment.start,
                            //   //mainAxisSize: MainAxisSize.min,
                            //   children: <Widget>[
                            //     Expanded(
                            //       child: RadioListTile(
                            //         activeColor: AppColors.navigationSkybluecolor,
                            //         selectedTileColor:
                            //             AppColors.navigationSkybluecolor,
                            //         title: const Text(Constants.yes),
                            //         value: Constants.yes,
                            //         groupValue: isDepositorDBEmployee,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             isDepositorDBEmployee = value.toString();
                            //           });
                            //     },
                            //   ),
                            // ),
                            // Expanded(
                            //   child: RadioListTile(
                            //     activeColor: AppColors.navigationSkybluecolor,
                            //     selectedTileColor:
                            //         AppColors.navigationSkybluecolor,
                            //     title: const Text(Constants.no),
                            //     value: Constants.no,
                            //     groupValue: isDepositorDBEmployee,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         isDepositorDBEmployee = value.toString();
                            //       });
                            //     },
                            //       ),
                            //     ),
                            //   ],
                            //   //  ),
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  activeColor: AppColors.navigationSkybluecolor,
                                  // focusColor:
                                  //     AppColors.navigationSkybluecolor,

                                  value: 1,
                                  groupValue: isDepositorDBEmployeeSelected,
                                  onChanged: (val) {
                                    radioButtonItem = 'Yes';
                                    isDepositorDBEmployeeSelected = 1;
                                    setState(() {});
                                  },
                                ),
                                const Text(Constants.yes),
                                Radio(
                                  activeColor: AppColors.navigationSkybluecolor,
                                  value: 0,
                                  groupValue: isDepositorDBEmployeeSelected,
                                  onChanged: (val) {
                                    radioButtonItem = 'No';
                                    isDepositorDBEmployeeSelected = 0;
                                    setState(() {});
                                  },
                                ),
                                const Text(Constants.no),
                              ],
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // depositor
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.depositor,
                                style: Styles.textStyleBlack14,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title: selecteddepositorList?.name != null
                                        ? ((selecteddepositorList?.name ?? '') +
                                            '(' +
                                            (selecteddepositorList?.email ?? '') +
                                            ')')
                                        : '',
                                    height: 70,
                                    onTap: () {
                                      depositorDialog(state);
                                       })
                                      
                                : FlutterInputField(
                                    textFieldController: depositorTextController,
                                    textFormKey: Keys.depositorTextController,
                                    hintText: '',
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            // Depositor employee id
                            isDepositorDBEmployeeSelected == 1
                                ? Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      Constants.depositoremployeeid,
                                      style: Styles.textStyleBlack14,
                                    ),
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(height * 0.001)
                                : Container(),

                            isDepositorDBEmployeeSelected == 1
                                ? FlutterInputField(
                                    textFieldController: depositorEmpIdTextController,
                                    textFormKey: Keys.depositorEmpIdTextController,
                                    hintText: '',
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(height * 0.01)
                                : Container(),
                            // employee department
                            isDepositorDBEmployeeSelected == 1
                                ? Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      Constants.employeedepartment,
                                      style: Styles.textStyleBlack14,
                                    ),
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(height * 0.001)
                                : Container(),

                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title: selectedEmployeedepartment?.name ?? '',
                                    height: 60,
                                    onTap: () {
                                     employeeDepartmentDialog(state);
                                    },
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(height * 0.01)
                                : Container(),

                            // upload
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFCACACA),
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(8))),
                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
                                    onPressed: () {
                                      // Navigator.pushNamed(context,
                                      //     createFoundAttachmentRoute);
                                      //UploadAttachment();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext dialogContext) {
                                            return UploadAttachment();
                                          });
                                    },

                                    icon: SvgPicture.asset(
                                      //AppIcon.dropdownicon,
                                      AppIcon.uploadicon,
                                      //fit: BoxFit.,
                                      color: AppColors.backgroundWhitecolor,
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
                                      style: Styles.textStyleRegularNormalWhite12,
                                    ), // <-- Text
                                  ),
                                ),
                              ]),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            (getAttachments == null || getAttachments?.length == 0)
                                ? Container()
                                : attachmentListviews(getAttachments),
                            // ListView()
                            //                   ListView(
                            // shrinkWrap: true,)
                          ],
                        )),
                  ),
                ])));
          },
        ));
  }

  Widget attachmentListviews(List<AttachmentModel>? attachmentListviews) {
    return
        //Expanded(
        //child:
        Container(
      // width: double.maxFinite,
      //height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            AttachmentModel? item = attachmentListviews?[index];
            return Column(
              children: <Widget>[
                SizedBox(
                  // height: 50,
                  child: ListTile(
                    //trailing: Icon(Icons.download_sharp),
                    //visualDensity: VisualDensity(vertical: 0),
                    //dense: true,
                    trailing:
                        SvgPicture.asset(AppIcon.download, color: AppColors.boldgreyBackground),
                    onTap: () {
                      //widget.onTap!(item);
                      // Navigator.of(context).pop();
                    },
                    title: Expanded(child: Text(item?.name ?? '')),
                  ),
                ),
                Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );

            // ListTile(
            //   onTap: ()
            //   {
            //     //widget.onTap!(item);
            //    // Navigator.of(context).pop();
            // },
            // trailing: SvgPicture.asset(AppIcon.backIcon,
            //       color: AppColors.navigationSkybluecolor),
            //   dense: true,
            //   visualDensity: VisualDensity(vertical: 0), // to expand
            //   title:   Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: <Widget>[
            //               Align(
            //           alignment: Alignment.topLeft,
            //           child: Text(
            //             'item',
            //             style: Styles.textStyleRegularGrey16,
            //             textAlign: TextAlign.left,
            //           ),
            //         ),

            //             //Dividers.horizentalDivider(),
            //             ]),

            // );
          }),
      //   children:  List.generate(
      //       3,
      //       (index) => Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: <Widget>[
      //                 Text("data $index"),
      //                 Divider(),
      //               ])),
      // ),
      // ),
    );
  }

  Widget textHandling(String title, String desc) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: Styles.textStyleRegularNormalGrey14,
          children: <TextSpan>[
            TextSpan(text: title),
            TextSpan(
              text: desc,
              style: Styles.textStyleBoldGrey14,
            ),
          ],
        ),
      ),
    );
  }
  // void _awaitReturnValueFromSecondScreen(BuildContext context) async {

  //   // start the SecondScreen and wait for it to finish with a result
  //   // final result = await Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //       builder: (context) => SecondScreen(),
  //   //     ));

  //   // after the SecondScreen result comes back update the Text widget with it
  //   // setState(() {
  //   //   text = result;
  //   // });
  // }

  Future<void> datePickerselection(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy a HH:mm:ss').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement
      controller.text = formattedDate;
      setState(() {
        // dateinput.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
