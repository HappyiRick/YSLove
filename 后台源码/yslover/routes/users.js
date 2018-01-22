var express = require('express');
var router = express.Router();
//关联主程序
var userlist = require('../user/user.js');

/* GET users listing. */
router.get('/', function(req, res, next) {
  // console.log("********************************hah************"+user);
    var result = {
      "title" : "yslover用户接口",
      "name" : "人本界面"
  };
  res.json(result);
});

//增
router.get('/userRegister',function(req,res,next){
    userlist.userregister(req,res,next);
});
router.get('/usersaveCollect',function (req,res,next) {
    userlist.usersaveCollect(req,res,next);
});
router.get('/userHeaderImage/:filename',function (req,res,next) {
    userlist.userPhoto(req,res,next);
});

//删
router.get('/userDelete',function(req,res,next){
    userlist.userdelete(req,res,next);
});
router.get('/userDeleteCollect',function(req,res,next){
    userlist.userDeleteCollect(req,res,next);
});
//改
router.get('/userUpdateUsernickname',function(req,res,next){
    userlist.userupdatenickname(req,res,next);
});
router.get('/userUpdateEmail',function(req,res,next){
    userlist.userupdateemail(req,res,next);
});
router.get('/userUpdatePhone',function(req,res,next){
    userlist.userupdatephone(req,res,next);
});
router.get('/userCheckPassword',function(req,res,next){
    userlist.usercheckpassword(req,res,next);
});
router.get('/userrepassword',function(req,res,next){
    userlist.userrepassword(req,res,next);
});
//查
router.get('/usersearchCollect',function (req,res,next) {
    userlist.usersearchCollect(req,res,next);
});
router.get('/userAll',function(req,res,next){
    userlist.userAll(req,res,next);
});
router.get('/userByname',function(req,res,next){
    userlist.userByname(req,res,next);
});
router.get('/userlogin',function (req,res,next) {
    userlist.userlogin(req,res,next);
});

router.post('/userUpdateheaderImage',function (req,res,next){
    userlist.userUpdateheaderImagename(req,res,next);
});


module.exports = router;
