//实现与mysql交互
var mysql=require('mysql');
var $conf=require('../conf/db.js');
var $util=require('../util/util.js');
var $sql=require('./usersql.js');
var path = require('path');
var formidable=require('formidable');
var querystring = require('querystring');
var fs = require('fs');
var moment = require('moment');

AVATAR_IP = '10.73.5.40:3000';
AVATAR_UPLOAD_FOLDER = '..\\public\\images\\';
//使用连接池
var pool  = mysql.createPool($util.extend({}, $conf.mysql));

// 向前台返回JSON方法的简单封装
var jsonWrite = function (res, ret) {
    if(typeof ret === 'undefined') {
        res.json({
            code:'1',
            msg: '操作失败'
        });
    } else {
        res.json(ret);
    }
};

module.exports = {
    //用户注册
    userregister: function (req, res, next) {
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            var registertime = moment().format("YYYY-MM-DD HH:mm:ss");
            console.log(registertime + param.username + param.userpassword);
            connection.query($sql.userregister, [param.username, param.userpassword, registertime], function(err, result) {
                if(result) {
                    result = {
                        code: 200,
                        msg:'注册成功'
                    };
                }

                // 以json形式，把操作结果返回给前台页面
                jsonWrite(res, result);

                // 释放连接
                connection.release();
            });
        });
    },
    usersaveCollect: function (req, res, next) {
        req.setEncoding = "utf-8";
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            console.log(param);
            connection.query($sql.usercollectBytag, [param.uid, param.ID], function(err, result) {
                if(result.length > 0 ) {
                    result = {
                        code: 200,
                        msg:'本文章已收藏'
                    };
                    // 以json形式，把操作结果返回给前台页面
                    jsonWrite(res, result);
                }else {
                    pool.getConnection(function(err, connections) {
                        // 获取前台页面传过来的参数
                        var param = req.query || req.params;
                        console.log(param.uid);
                        connections.query($sql.usersavecollect, [param.uid, param.ID, param.jianjie,param.thumb,param.title,param.edittime,param.views,param.catename,param.subcatename,param.tags], function(err, results){
                            console.log(param.uid + "save-----" + param.ID);
                            if(results){
                                results = {
                                    code :200,
                                    msg:'收藏成功'
                                };
                            }else {
                                console.log(err);
                            }
                            jsonWrite(res,results);

                            connections.release();
                        });
                    });
                }
                // 释放连接
                connection.release();
            });
        });
    },

    userdelete: function (req, res, next) {
        // delete by Id
        pool.getConnection(function(err, connection) {
            var uid = +req.query.uid;
            console.log("删除账号uid:---"+uid);
            connection.query($sql.userdelete, uid, function(err, result) {
                if(result.affectedRows > 0) {
                    result = {
                        code: 200,
                        msg:'删除成功'
                    };
                } else {
                    result = void 0;
                }
                jsonWrite(res, result);
                connection.release();
            });
        });
    },
    userDeleteCollect: function (req, res, next) {
        // delete by Id
        pool.getConnection(function(err, connection) {
            var param = req.query || req.params;
            connection.query($sql.userdeletecollect, [param.uid,param.ID], function(err, result) {
                if(result.affectedRows > 0) {
                    result = {
                        code: 200,
                        msg:'删除成功'
                    };
                } else {
                    result = void 0;
                }
                jsonWrite(res, result);
                connection.release();
            });
        });
    },

    usercheckpassword: function (req, res, next) {
        // update by id
        // 为了简单，要求同时传name和age两个参数
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            console.log("验证密码："+param.uid);
            connection.query($sql.usercheckpassword, [param.userpassword,param.uid], function(err, result) {
                if(result) {
                    result = {
                        code: 200,
                        msg:'验证成功'
                    };
                }

                // 以json形式，把操作结果返回给前台页面
                jsonWrite(res, result);

                // 释放连接
                connection.release();
            });
        });
    },
    userrepassword: function (req, res, next) {
        // update by id
        // 为了简单，要求同时传name和age两个参数
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            console.log("更改密码"+param.uid);
            // 建立连接，向表中插入值
            // 'INSERT INTO user(id, name, age) VALUES(0,?,?)',
            connection.query($sql.userrepassword, [param.userrepassword,param.uid], function(err, result) {
                if(result) {
                    result = {
                        code: 200,
                        msg:'修改成功'
                    };
                }

                // 以json形式，把操作结果返回给前台页面
                jsonWrite(res, result);

                // 释放连接
                connection.release();
            });
        });
    },
    userupdatenickname: function (req, res, next) {
        // update by id
        // 为了简单，要求同时传name和age两个参数
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            console.log("更改昵称"+param.uid);
            // 建立连接，向表中插入值
            // 'INSERT INTO user(id, name, age) VALUES(0,?,?)',
            connection.query($sql.userupdatenickname, [param.usernickname,param.uid], function(err, result) {
                if(result) {
                    result = {
                        code: 200,
                        msg:'修改成功'
                    };
                }

                // 以json形式，把操作结果返回给前台页面
                jsonWrite(res, result);

                // 释放连接
                connection.release();
            });
        });
    },
    userPhoto: function (req, res, next) {
        // update by id
        // 为了简单，要求同时传name和age两个参数
        console.log(req.params);
        var filePath = path.join(__dirname,AVATAR_UPLOAD_FOLDER ,req.params.filename);
        console.log(filePath);
        fs.exists(filePath, function (exists) {
            if (exists){
                console.log("1111");
                res.sendfile(filePath);
            }
        });
    },
    userUpdateheaderImagename: function (req, res, next) {
        req.setEncoding="utf-8";
        // update by id
        // 为了简单，要求同时传name和age两个参数
        var form = new formidable.IncomingForm();   //创建上传表单
        form.encoding = 'utf-8';		//设置编辑
        form.uploadDir =  AVATAR_UPLOAD_FOLDER;	 //设置上传目录
        form.keepExtensions = true;	 //保留后缀
        form.maxFieldsSize = 2 * 1024 * 1024;   //文件大小

        form.parse(req, function(err, fields, files) {

            if (err) {
                res.locals.error = err;
                res.render('index', { title: TITLE });
                return;
            }

            var extName = 'png';  //后缀名

            if(extName.length == 0){
                res.locals.error = '只支持png和jpg格式图片';
                res.render('index', { title: TITLE });
                return;
            }

            var avatarName = Date.now() + '.' + extName;
            var newPath = form.uploadDir + avatarName;
            fs.renameSync(files.upload.path,newPath);
            pool.getConnection(function(err, connection) {
                // 获取前台页面传过来的参数
                console.log("更改头像"+fields["uid"]+"--"+avatarName);
                // 建立连接，向表中插入值
                // 'INSERT INTO user(id, name, age) VALUES(0,?,?)',
                connection.query($sql.userupdateuserheadername, [avatarName,fields["uid"]], function(err, result) {
                    if(result) {
                        result = {
                            code: 200,
                            headerImage:"http://"+AVATAR_IP+"/users/userHeaderImage/"+avatarName,
                            msg:'修改成功'
                        };
                    }

                    // 以json形式，把操作结果返回给前台页面
                    jsonWrite(res, result);

                    // 释放连接
                    connection.release();
                });
            });
        });

    },
    userupdatephone: function (req, res, next) {
        // update by id
        // 为了简单，要求同时传name和age两个参数
        pool.getConnection(function(err, connection) {
            // 获取前台页面传过来的参数
            var param = req.query || req.params;
            console.log("更新userphone："+param.userphone);
            // 建立连接，向表中插入值
            // 'INSERT INTO user(id, name, age) VALUES(0,?,?)',
            connection.query($sql.userupdatephone, [param.userphone,param.uid], function(err, result) {
                if(result) {
                    result = {
                        code: 200,
                        msg:'修改成功'
                    };
                }

                // 以json形式，把操作结果返回给前台页面
                jsonWrite(res, result);

                // 释放连接
                connection.release();
            });
        });
    },
    //得到所有用户 在路由routes调用本方法，这个方法调用sql语句 ，并返回相应结果jsonwrite
    userAll: function (req, res, next) {
        pool.getConnection(function(err, connection) {
            connection.query($sql.userAll, function(err, result) {
                jsonWrite(res, result);
                connection.release();
            });
        });
    },
    userlogin: function (req, res, next) {
        var user = req.query;
        console.log("登录信息loginParam:" + user.username + user.userpassword);
        var registertime = moment().format("YYYY-MM-DD HH:mm:ss");
        console.log("登录时间："+registertime);
        pool.getConnection(function(err, connection) {
            connection.query($sql.userlogin, [user.username, user.userpassword], function(err, result) {
                if(result.length > 0) {
                    console.log(result);
                    delete result[0]["userpassword"];
                    result[0]["code"] = 200;
                    result[0]["msg"] = "登录成功";
                    var headerStr = "http://"+AVATAR_IP+"/users/userHeaderImage/"+result[0]["userheader"];
                    result[0]["userheader"] = headerStr;

                    console.log(result);

                }
                jsonWrite(res, result);
                connection.release();

            });
        });
    },
    userByname: function (req, res, next) {
        var data = req.query;
        console.log("查找用户："+data.username);
        pool.getConnection(function(err, connection) {
            connection.query($sql.userByname, ['%' + data.username + '%'], function(err, result) {
                var i = result.length;
                for(; i > 0; i--){
                    delete result[i-1]["userpassword"];
                }
                jsonWrite(res, result);

                connection.release();

            });
        });
    },
    usersearchCollect:function (req,res,next) {
        var param = req.query;
        console.log(param.uid + "de 收藏");
        pool.getConnection(function(err, connection) {
            connection.query($sql.usercollectByuid, [param.uid], function(err, result) {
                if(result.length > 0) {
                    var i = result.length;
                    for(;i>0;){
                        i--;
                        delete result[i]["collectID"];
                        delete result[i]["uid"];
                    }
                }
                var data = {
                    code: 200,
                    msg:'请求成功',
                    datas:result
                };

                console.log(data);
                jsonWrite(res, data);
                connection.release();

            });
        });
    },
};



