abstract class  CouponStates {}

class CouponInitialState extends CouponStates {}

///Add
class CouponAddedLoadinglState extends CouponStates {}
class CouponAddedScussesState extends CouponStates {}
class CouponAddedErorrState extends CouponStates {}
///get
class CouponGetLoadinglState extends CouponStates {}
class CouponGetScussesState extends CouponStates {}
class CouponGetErorrState extends CouponStates {}
///update
class SubscriptionUpdatedSuccessState extends CouponStates {}
class SubscriptionUpdatedErrorState extends CouponStates {}
///delete
class SubscriptionDeletedSuccessState extends CouponStates {}
class SubscriptionDeletedErrorState extends CouponStates {}