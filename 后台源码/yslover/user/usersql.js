
var userAction = {
    //增
    userregister: 'INSERT INTO `userinfo` (`username`,`userpassword`,`uregistertime`) VALUES(?,?,?)',
    usersavecollect: 'INSERT INTO `collectinfo` (uid,ID,jianjie,thumb,title,edittime,views,catename,subcatename,tags) VALUES(?,?,?,?,?,?,?,?,?,?)',
    //删
    userdelete: 'delete from userinfo where uid=?',
    userdeletecollect: 'delete from collectinfo where uid=? and ID=?',
    //改
    userupdatenickname: 'UPDATE `userinfo` SET `usernickname`=? WHERE `uid`=?',
    userupdateuserheadername: 'UPDATE `userinfo` SET `userheader`=? WHERE `uid`=?',
    userupdatephone: 'UPDATE `userinfo` SET `userphone`=? WHERE `uid`=?',
    userupdateemail: 'UPDATE `userinfo` SET `useremail`=? WHERE `uid`=?',
    userrepassword: 'UPDATE `userinfo` SET `userpassword`=? WHERE `uid`=?',
    //查
    usercollectBytag:'select * from collectinfo WHERE `uid` = ? and `ID` = ?',
    usercollectByuid:'select * from collectinfo WHERE uid = ?',
    userAll: 'select * from userinfo',
    usercheckpassword:'select * from userinfo WHERE `userpassword`=? and `uid`=?',
    userlogin: 'select * from userinfo WHERE `username`=? and `userpassword`=?',
    userByname: 'select * from userinfo where username like ?'
};

module.exports=userAction;