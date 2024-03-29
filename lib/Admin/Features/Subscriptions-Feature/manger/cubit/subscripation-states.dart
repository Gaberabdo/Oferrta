abstract class SubscripationStates {}

class SubscripationInitialState extends SubscripationStates {}

///Add
class SubscripationAddedLoadinglState extends SubscripationStates {}
class SubscripationAddedScussesState extends SubscripationStates {}
class SubscripationAddedErorrState extends SubscripationStates {}
///get
class SubscripationGetLoadinglState extends SubscripationStates {}
class SubscripationGetScussesState extends SubscripationStates {}
class SubscripationGetErorrState extends SubscripationStates {}
///update
class SubscriptionUpdatedSuccessState extends SubscripationStates {}
class SubscriptionUpdatedErrorState extends SubscripationStates {}
///delete
class SubscriptionDeletedSuccessState extends SubscripationStates {}
class SubscriptionDeletedErrorState extends SubscripationStates {}