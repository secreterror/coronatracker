
import 'package:corona/pages/contact.dart';
import 'package:corona/pages/faq.dart';
import 'package:corona/pages/initial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent {
  HomePageClick,
  FaqClick,
  ContactClick
}
abstract class NavigationState{}
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => Initial();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event)async* {
   switch(event){
     case NavigationEvent.HomePageClick:
       yield Initial();
       break;
     case NavigationEvent.FaqClick:
       yield Faq();
       break;
     case NavigationEvent.ContactClick:
       yield Contact();
       break;
   }
  }

}