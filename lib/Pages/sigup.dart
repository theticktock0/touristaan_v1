import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'home.dart';
import '../db/users.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _loading = false;
  FirebaseAuth firebaseAuth ;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController =
      TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  String groupValue = "male";
  String gender;
  bool hidePass= true;
  bool hideconfirmPass=true;
  SharedPreferences preferences;
  bool loading=false;
  bool isLogedin= false;
  bool _initialized = false;
  bool _error = false;
  void initState(){

    initializeFlutterFire();
    super.initState();
    isSignedIn();
  }
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        firebaseAuth = FirebaseAuth.instance;

      });
    } catch(x) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    if(isLogedin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }


  Widget build(BuildContext context) {

    return Scaffold (
      resizeToAvoidBottomPadding: false,

//      appBar: AppBar(
//
//        backgroundColor: Colors.white,
//
//        centerTitle: true,
//
//        title: new Text(
//
//          "Login",
//
//          style: TextStyle(color: Colors.red.shade900),
//
//        ),
//
//      ),

      body: Stack(

        children: <Widget>[
          Image.asset(
            "images/backgrounds/background5.jpg",
            fit: BoxFit.fill,
            width: double.infinity,
//            height: double.infinity,
            height: MediaQuery. of(context). size. height,
          ),

          Container(
            color: Colors.black.withOpacity(0.3),
            alignment: Alignment.topCenter,
            child: Image.asset(
              "images/logo/logo2.png",
              width: double.infinity,
//
              height: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Form(
                  key: _formKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget>[
//                    ***form***
//                  *FIRST NAME*
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFormField(
                              controller: _nameTextController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Enter Name :",
                                border: InputBorder.none,
                                icon: Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                      ),

//


//                    *** MALE / FEMALE OPTION*****
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 4.0, 40.0, 4.0),
                        child: new Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: ListTile(
                                      title: Text(
                                        "Male",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: Radio(
                                          value: "male",
                                          groupValue: groupValue,
                                          onChanged: (e) => valueChanged(e)))),
                              Expanded(
                                  child: ListTile(
                                      title: Text(
                                        "Female",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: Radio(
                                          value: "female",
                                          groupValue: groupValue,
                                          onChanged: (e) => valueChanged(e)))),
                            ],
                          ),
                        ),
                      ),

//                    *** MALE / FEMALE OPTION*****

//                    **EMAIL FIELD*
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFormField(
                              controller: _emailTextController,

                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email :",
                                border: InputBorder.none,

                                icon: Icon(Icons.alternate_email),
//                                border: OutlineInputBorder(),
                              ),

//                    ********0Validater******

//                      ****VALIDATOR****
                              validator: (value) {
                                // ignore: missing_return
                                if (value.isEmpty) {
                                  return "The email feild cannot me empty";
                                }
                                Pattern pattern =
                                    // ignore: missing_return
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                // ignore: missing_return, missing_return
                                if (!regex.hasMatch(value)) {
                                  return "Please make sure your Email is Valid";
                                } else
                                  return null;
                              },

//                      ****VALIDATOR****
                            ),
                          ),
                        ),
                      ),

//                  *** END   EMAIL FEILD*****

//

//                    ************* PASSWORD FIELD**********

                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _passwordTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Password :",
                                  border: InputBorder.none,

                                  icon: Icon(Icons.lock),
//                                border: OutlineInputBorder(),
                                ),
                                obscureText: hidePass,

//                      ****VALIDATOR****
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The password Feild Cannot be empty";
                                  } else if (value.length < 6) {
                                    return "The password should be atleast 6 characters long";
                                  }
                                  return null;
                                },
//                      ****VALIDATOR****
                              ),
                              trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                setState(() {
                                  if(hidePass){
                                    hidePass = false;
                                  }
                                  else
                                    hidePass=true;
                                });
                              },),
                            ),
                          ),
                        ),
                      ),

//                    ***END OF PASSWORD FEILD******

//                    ***** CONFIRM PASSWORD******
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _confirmpasswordTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password :",
                                  border: InputBorder.none,

                                  icon: Icon(Icons.lock_outline),
//                                border: OutlineInputBorder(),
                                ),
                                obscureText: hideconfirmPass,

//                      ****VALIDATOR****
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The password Feild Cannot be empty";
                                  } else if (value.length < 6) {
                                    return "The password should be atleast 6 characters long";
                                  }else if (_passwordTextController.text != value.toString()){
                                    return "Passwords do no match";
                                  }
                                  return null;
                                }
//                      ****VALIDATOR****
                              ),
                              trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                                setState(() {
                                  if(hideconfirmPass){
                                    hideconfirmPass = false;
                                  }
                                  else
                                    hideconfirmPass=true;
                                });
                              },),

                            ),
                          ),
                        ),
                      ),
//                        **** END OF CONFIRM PASSWORD******
//                    ***register BUTTON**
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue.withOpacity(0.9),
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
//                              child:
//                              CircularProgressIndicator(
//                                valueColor:
//                                    AlwaysStoppedAnimation<Color>(Colors.red),
//                              );
//                              Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => Login()));
                            validateForm();
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
//                *** end Register BUTTON**
                      Expanded(child: Container()),
                      Divider(
                        color: Colors.white,
                      ),
//                      Text("Don't have an account, Sign-up!",style: (
//                      TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0)
//                      ),),

//                    ******SIGN IN TEXT*****





//
                      Container(

                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 20),
                        child: Row(
                          children: <Widget>[
                            Text("Already have An Account?,",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0),
                            ),
                            InkWell(
                              child: Text ("LOG-IN!",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                              },
                            ),

                          ],
                        ),
                      )

                //**************SIGN IN TEXT END ******

//                      ********SIGN in BUTTON***********
//                      Padding(
//                        padding:
//                            const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
//                        child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          color: Colors.red.withOpacity(0.9),
//                          elevation: 0.0,
//                          child: MaterialButton(
//                            onPressed: () {
//
//                              Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => Login()));
//                            },
//                            minWidth: MediaQuery.of(context).size.width,
//                            child: Text(
//                              "Sign-In",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 22.0),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ********SIGN in BUTTON ENDS********


                    ],
                  ),
                ),
              ),
            ),
          ),


        ],


      ),

//
    );
  }

  valueChanged(e) {
    setState(() {
      if (e=="male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender= e ;
      }
    });
  }

  Future validateForm() async{
    FormState formState = _formKey.currentState;

    if(formState.validate()){
      formState.reset();
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
     if(firebaseAuth.currentUser !=  null){
       firebaseAuth.createUserWithEmailAndPassword(
           email: _emailTextController.text, password: _passwordTextController.text,)
           .then((user) => {
             _userServices.createUser(
                 {

                 "username": _nameTextController.text,
                 "email": _emailTextController.text,
                  "userId": firebaseAuth.currentUser.uid,
               "gender": gender,


             }) .catchError((err)=> {
               Fluttertoast.showToast(msg: err.toString(),
                   timeInSecForIosWeb: 4,
                   backgroundColor: Colors.deepPurple,
                   gravity: ToastGravity.CENTER)
             }),
//
       Fluttertoast.showToast(msg: "Account Created",
       timeInSecForIosWeb: 4,
       backgroundColor: Colors.deepPurple,
       gravity: ToastGravity.CENTER),
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()))}
       );

            Fluttertoast.showToast(msg: "Email Already Exists",
           timeInSecForIosWeb: 4,
           backgroundColor: Colors.blueGrey,
           gravity: ToastGravity.CENTER);

     }


    }
  }
}
