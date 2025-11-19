import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magicmate_user/controller/profile/ProfileUpdateController.dart';
import 'package:magicmate_user/firebase/chat_textfield.dart';
import 'package:magicmate_user/screen/auth_screen/widget/CustomButtonWithRipple.dart';
import 'package:magicmate_user/screen/profile_new/widgets/CustomTextFormFieldss.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final _formKey = GlobalKey<FormState>();
  ProfileUPdateController controller =Get.put(ProfileUPdateController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getStorevalue();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isSmallHeight = screenHeight < 700;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: screenHeight * 0.02),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                          GestureDetector(

                          child: SvgPicture.asset(
                            AppImagesssss.backbtn,
                            width: screenWidth*0.054,
                            height: screenHeight*0.054,
                          ),
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                          ),
                             Container(
                                     alignment: Alignment.center,
                                   margin: EdgeInsets.only(top: 10, left: screenWidth*0.28),
                                  child: Text(AppConstants.editprofile,
                                    textAlign: TextAlign.center,
                                    style: TextStyleClass.textcolorstyle(context, screenWidth * 0.056, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight*0.068,left: 5,),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImagesssss.background_pro,),
                        fit: BoxFit.fill
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*.15,
                          child: Divider(
                            height: screenHeight * 0.017,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Stack(
                        children: [
                          Container(
                            height: screenHeight*0.13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFFFF56A),
                                  Color(0xFFEBBD48),
                                  Color(0xFFFFFF74),
                                  Color(0xFFC89A2C),
                                ],
                                stops: [0.0, 0.1944, 0.3896, 0.899],
                              ),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(top: 20,left: 20,right: 20),
                              child: Obx((){
                                return Center(
                                  child: ClipOval(child: controller.selectedImage.value == null?Image.asset( AppImagesssss.profileimg, width: 120,
                                    height: 120,): Image.file(controller.selectedImage.value!,fit: BoxFit.cover, width: 120,
                                    height: 120,)),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Stack(
                        children: [
                          Align(
                            child: Container(
                              child: Image.asset(AppImagesssss.EditTextImage,fit: BoxFit.fill,),
                              width: 200,
                              height: 48,),
                            alignment: Alignment.center,
                          ),
                          GestureDetector(
                            onTap: () async{
                            //  _checkPermissions();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: screenWidth * 0.031),
                                  child: Icon(Icons.edit,color: Colors.white,size: 20,),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 5,top: screenWidth * 0.031),
                                  child: Text("Change Profile Picture",
                                      textAlign: TextAlign.center,
                                      style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.038, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.0,FontWeight.w400)
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.7,
                        margin: EdgeInsets.only(left: 20, right: 20,top: 50),
                        padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              offset: Offset(0, 4.55),
                              blurRadius: 50.03,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight * 0.02),
                                  Text("Name",
                                    textAlign: TextAlign.center,
                                     style: TextStyleClass.textcolorstyle(context, screenWidth * 0.04, ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                  ),),
                              SizedBox(height: screenHeight * 0.01),
                              CustomTextFormFieldss(
                                label: AppConstants.enterfirstyn,
                                hintText: AppConstants.enterfirstyn,
                                controller: controller.firstnameController,
                                validator: (value) =>
                                value == null || value.isEmpty ? 'First name is required' : null,
                              ),



                              SizedBox(height: screenHeight * 0.03),
                              Text("Email",
                                textAlign: TextAlign.center,
                                style: TextStyleClass.textcolorstyle(context, screenWidth * 0.04, ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                ),),
                              SizedBox(height: screenHeight * 0.01),
                              CustomTextFormFieldss(
                                keyboardType: TextInputType.emailAddress,
                                label: AppConstants.enterfirstyn,
                                hintText: "Enter your email",
                                controller: controller.emailController,

                                validator: (value) =>
                                value == null || value.isEmpty ? 'First name is required' : null,
                              ),



                              SizedBox(height: screenHeight * 0.03),
                              Text(AppConstants.dob,
                                textAlign: TextAlign.center,
                                style: TextStyleClass.textcolorstyle(context, screenWidth * 0.04, ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                ),),
                              SizedBox(height: screenHeight * 0.01),
                              Stack(
                                children: [
                                  Image.asset(AppImagesssss.EditTextImage,),
                                  Obx(() => TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your date of birth';
                                      }
                                      return null;
                                    },
                                    onTap: controller.pickDate,
                                    style: TextStyleClass.textcolorstyle2(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.whitecolor),1.2,FontWeight.w400),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      suffixIcon: Padding(
                                        padding:  EdgeInsets.only(right: 20),
                                        child: Icon(Icons.calendar_month_outlined, color: ColorHelperClass.getColorFromHex(ColorResources.iconcolor)),
                                      ),
                                      hintText: AppConstants.dob,
                                      hintStyle: TextStyleClass.textcolorstyle2(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.whitecolor),1.2,FontWeight.w400),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none, // Remove underline
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),

                                    ),
                                    controller: TextEditingController()
                                      ..text = controller.dobselectedDate.value,
                                  )),

                                ],
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              Text(AppConstants.sgnder,
                                textAlign: TextAlign.center,
                                style: TextStyleClass.textcolorstyle(context, screenWidth * 0.04, ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                ),),
                              SizedBox(height: screenHeight * 0.01),

                              Stack(
                                children: [
                                  Image.asset(AppImagesssss.EditTextImage,),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 30),

                                    child: Obx(
                                          () => DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: controller.selectedGender.value.isEmpty
                                              ? null
                                              : controller.selectedGender.value,
                                          hint: Text("Select Gender",style: TextStyleClass.textcolorstyle(context, screenWidth * 0.038, ColorHelperClass.getColorFromHex(ColorResources.textcolor),),),
                                          isExpanded: true,
                                          items: controller.genderOptions.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value, style: TextStyleClass.textcolorstyle(context, screenWidth * 0.038, ColorHelperClass.getColorFromHex(ColorResources.textcolor),),
                                            ));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            controller.selectedGender.value = newValue!;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              CustomButtonWithRipple(
                                child: controller.loading.value
                                    ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                ):Text(AppConstants.save,style: TextStyleClass.black ,),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if(controller.selectedGender.value!="")
                                    {
                                      // if(controller.selectedImage.value != null) {
                                        String inputDate = controller.dobselectedDate.value;
                                        DateFormat inputFormat = DateFormat('dd/MM/yyyy');
                                        DateTime date = inputFormat.parse(inputDate);

                                        // Now format the DateTime object to 'yyyy-MM-dd' format
                                        DateFormat outputFormat = DateFormat('yyyy-MM-dd');
                                        String dob = outputFormat.format(date);
                                        print("dgfydgy"+dob);
                                        controller.updateProfile(
                                            controller.firstnameController.text.toString(),
                                            controller.selectedGender.value,
                                            dob,
                                             controller.emailController.text.toString(),controller.imagePath.value);
                                      // }
                                      // else
                                      // {
                                      //   Fluttertoast.showToast(
                                      //       msg: "Please Choose Profile Picture ",
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.CENTER,
                                      //       timeInSecForIosWeb: 1,
                                      //       backgroundColor: Colors.red,
                                      //       textColor: Colors.white,
                                      //       fontSize: 16.0
                                      //   );
                                      // }
                                    }
                                    else
                                    {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Gender ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
                                },
                                height: isSmallHeight ? screenHeight * 0.075:screenHeight * 0.062,
                              ),
                              SizedBox(height: screenHeight * 0.05),






                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,   // iOS & Android 13+
      Permission.storage   // Older Android versions
    ].request();

    bool cameraGranted = statuses[Permission.camera]?.isGranted ?? false;
    bool galleryGranted = statuses[Permission.photos]?.isGranted ?? false;
    bool storageGranted = statuses[Permission.storage]?.isGranted ?? false;

    if (cameraGranted && (galleryGranted || storageGranted)) {
      print("All permissions granted!");
      _showUploadOptions();
    } else {
      print("Permissions denied!");
      Get.snackbar("Permission", "Please enable Camera & Gallery permissions in Settings.");
      openAppSettings(); // Open settings if denied permanently
    }
  }
  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Upload from Gallery'),
              onTap: () {

                Navigator.of(context).pop();
                controller.pickImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Picture'),
              onTap: () {
                Navigator.of(context).pop();
                controller.takePhotoWithCamera();
              },
            ),
          ],
        ),
      ),
    );
  }
}
