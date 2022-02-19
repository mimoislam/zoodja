
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/generated/l10n.dart';
import 'package:zoodja/models/keyValueRecordType.dart';
import 'package:zoodja/repositories/lang.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/condition.dart';
import 'package:zoodja/ui/pages/login.dart';
import 'package:zoodja/ui/pages/onBording.dart';
import 'package:zoodja/ui/pages/profile.dart';
import 'package:zoodja/ui/pages/splash.dart';
import 'package:zoodja/ui/pages/verify.dart';
import 'package:zoodja/ui/widgets/tabs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Home extends StatelessWidget {
  final UserRepository _userRepository;
   Home({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;



  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (context) => Lang(),
      builder:(context,child) {
        final lang=Provider.of<Lang>(context);

        return MaterialApp(

        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],  supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // Spanish, no country code
      ],
        locale:  lang.locale,

        home:BlocBuilder<AuthenticationBloc,AuthenticationState>(
          builder: (context,state){

            love=[
              KeyValueRecordType(key: "Film", value: AppLocalizations.of(context).films),
              KeyValueRecordType(key: "voyages", value: AppLocalizations.of(context).voyages),
              KeyValueRecordType(key: "sport", value: AppLocalizations.of(context).sport),
              KeyValueRecordType(key: "TV", value: "TV"),
              KeyValueRecordType(key: "Cuisine", value: AppLocalizations.of(context).cuisine),
            ];
            eyesColor=[
              KeyValueRecordType(key: "Brown", value: AppLocalizations.of(context).brown),
              KeyValueRecordType(key: "Blue", value: AppLocalizations.of(context).blue),
              KeyValueRecordType(key: "Hazel", value: AppLocalizations.of(context).hazelnut),
              KeyValueRecordType(key: "Gray", value: AppLocalizations.of(context).gray),
              KeyValueRecordType(key: "Green", value:AppLocalizations.of(context).greens),
            ];

            if (state is Uninitialised){
              return Splash();
            }if(state is Authenticated){
              return Tabs(userId: state.userId,);
            }


            if(state is AuthenticatedButNoSet1){
              return Condition(userId: state.userId);
            }


            if(state is AuthenticatedButNoSet){
              return Profile(userRepository: _userRepository,userId: state.userId,);
            }
            if(state is UnAuthenticated) {
              return Login(userRepository: _userRepository);
            }
            if (state is Confirm){

              return Verify(userRepository: _userRepository,verification: state.verification,);
            }
            if (state is OnBoarding){
              return OnBoardingScreen(userRepository: _userRepository);

            }

            else
              return Container();

          },
        ) ,);

    },);
  }
}
