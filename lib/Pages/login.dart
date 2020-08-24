import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:touristaan_v1/Pages/sigup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  FirebaseAuth firebaseAuth ;
  bool hidePass=true;

//  *******FIRE BASE AUTH****
//  **************FIRE BASE AUTH***********
  bool _initialized = false;
  bool _error = false;

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

  final GoogleSignIn googleSignIn = new GoogleSignIn();
//  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  SharedPreferences preferences;
  bool loading=false;
  bool isLogedin= false;
  @override
  void initState(){
    initializeFlutterFire();
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
  setState(() {
    loading=true;
  });
  preferences = await SharedPreferences.getInstance();
  isLogedin = await googleSignIn.isSignedIn();

  if(isLogedin){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    googleSignIn.signOut();
  }
    setState(() {
      loading = false;
    });
  }
  Future handleSignin() async{

    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading= true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
//    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if(firebaseUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .get();
      final List <DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
//        insert the user to our collection
        Firestore.instance.collection("users").document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePciture": firebaseUser.photoURL,
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoURL", firebaseUser.photoURL);
      }else{
//        await preferences.setString("id", documents[0]['id']);
//        await preferences.setString("username", documents[0]["username"]);
//        await preferences.setString("photoURL", documents[0]["photoURL"]);
        await preferences.setString("id", documents[0].get("id"));
        await preferences.setString("username", documents[0].get("username"));
        await preferences.setString("photoURL", documents[0].get("photourl"));
      }

      Fluttertoast.showToast(msg: "Log In Successfull",
      timeInSecForIosWeb: 4);
      setState(() {
        loading=false;
      });
      Navigator.pushReplacement(

          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      Fluttertoast.showToast(msg: "Login failed,",
      timeInSecForIosWeb: 4);
    }

  }

//******FIRE BASE AUTH ENDS*********** FIRE


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: Stack (

        children: <Widget>[
          Image.asset("images/backgrounds/background2.jpg",
          fit: BoxFit.fill,
          width: double.infinity,
            height: MediaQuery. of(context). size. height,),



          Container (
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.topCenter,
            child: Image.asset("images/logo/logo2.png",
            width: 300.0,
            height: 300.0,),
          ),

          Padding(
            padding: const EdgeInsets.only(top:300.0),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Form(
                  key: _formKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget> [
//                    ***form***

//                  ***EMAIL FEILD*****
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left :8.0),
                            child: TextFormField(
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Ëmail :",
                                border: InputBorder.none,

                                icon: Icon(Icons.alternate_email),
//                                border: OutlineInputBorder(),


                              ),




//                    ********0Validater******

//                      ****VALIDATOR****
                        validator: (value){
                          // ignore: missing_return
                          if (value.isEmpty){
                            return "The email feild cannot me empty";}
                            Pattern pattern =
                                // ignore: missing_return
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            // ignore: missing_return, missing_return
                            if(!regex.hasMatch(value)) {
                              return "Please make sure your Email is Valid"; }
                            else
                              return null;

                          },

//                      ****VALIDATOR****


                            ),
                          ),
                        ),
                      ),
//                    ********END OF EMAIL FIELD********

//                    ************* PASSWORD FIELD**********

                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _passwordTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Password :",
                                  border: InputBorder.none,

                                  icon: Icon(Icons.lock_outline),
//                                border: OutlineInputBorder(),
                                ),

                                  obscureText: hidePass,



//                      ****VALIDATOR****
                                validator: (value){
                                  if(value.isEmpty){
                                    return "The password Feild Cannot be empty";
                                  }else if (value.length < 6){
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
//                    ***LOG IN BUTTON**
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue.withOpacity(0.9),
                          elevation: 0.0,
                          child: MaterialButton(onPressed: (){

                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),);
                            formvalidator();
//                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("Login",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.0),),),

                        ),
                      ),
//                ***LOG IN BUTTON**
                      Padding(

                     padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),

                         child:   InkWell(
                              child: Text ("Use Google Sign-In!",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,decoration: TextDecoration.underline)
                                ,
                              ),
                              onTap: (){
                                handleSignin();
                              },
                            ),



                      ),
                      Expanded(child: Container()),
                    Divider(color: Colors.white,),
//                      Text("Don't have an account, Sign-up!",style: (
//                      TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0)
//                      ),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),
                        child: RichText(text: TextSpan(
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16.0),
                              children: [
                                TextSpan(
                                  text: "Don't have an account?,"
                                ),
                                TextSpan(
                                  text:"Sign-up!",
                                  style: TextStyle(color: Colors.red),
                                )
                              ]
                        ),),
                      ),




//                      ********SIGN UP BUTTON***********
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0,8.0,40.0,8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.withOpacity(0.9),
                          elevation: 0.0,
                          child: MaterialButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Signup()));
                          },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text("Sign-UP",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.0),),),

                        ),
                      ),

//                    ********SIGN UP BUTTON ENDS********
                    ],
                  ),
                ),
              ),

            ),
          ),
          Visibility(

           visible: loading ?? true,

              child: Center(

                child: Container(

                  alignment: Alignment.center,



                  child: CircularProgressIndicator(

                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),

                  ),

                ),

              ))

        ],

      ),

//      bottomNavigationBar: Container(
//
//        child: Padding(
//
//          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
//
//          child: FlatButton(
//
//              color: Colors.red,
//
//              onPressed: () {
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
//
//
//              },
//
//              child: Text(
//
//                "Sign in / Sign up with google",
//
//                style: TextStyle(color: Colors.white),
//
//              )),
//
//        ),
//
//      ),
    );

  }

  void formvalidator() async {
    FormState formState = _formKey.currentState;

    if(formState.validate()){
      formState.reset();

      if(firebaseAuth.currentUser != null) {
        firebaseAuth.signInWithEmailAndPassword(
            email: _emailTextController.text, password: _passwordTextController.text)
            .then((user) => {
        Fluttertoast.showToast(msg: "Log-in Successful;",
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.deepPurple,
        gravity: ToastGravity.BOTTOM),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()))}
        ).catchError((x)=> {
        Fluttertoast.showToast(msg: "No Users Found;",
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.deepPurple,
        gravity: ToastGravity.BOTTOM)
        });
      }else {
//

      }
    }

    }
  }



