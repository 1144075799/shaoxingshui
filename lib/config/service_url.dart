const serviceUrl='http://www.sop.red:8080/';
const servicePath={
  'cityPort':serviceUrl+'city/getCity',               //名城接口
  'scenicPort':serviceUrl+'view/getAllParentView',    //全部父景区接口
  'scenicPar':serviceUrl+'/view/getViewByParentId',         //单个父景区接口
  'scenicChild':serviceUrl+'view/getSubViewByParentId',      //根据父景区id查找子景区
  'scenicSub':serviceUrl+'/view/getViewById',               //获取单个子景区
  'registerPort':serviceUrl+'user/register',          //注册接口
  'celebrityPort':serviceUrl+'famous/getAllFamousByPage', //获取名人接口
  'loginPort':serviceUrl+'user/login',                //登录接口
  'celebrityShow':serviceUrl+'/famous/getFamousById',   //获取单个名人接口
  'fuzzyQuery':serviceUrl+'/famous/getFamousByFuzzyQuery',  //名人模糊查找
  'likeView':serviceUrl+'user/like/view/add',         //关注景区接口
  'getListView':serviceUrl+'user/like/view/all',     //获取用户关注的景区
  'deleteListView':serviceUrl+'user/like/view/delete',  //删除关注的景区
  'getUserInfo':serviceUrl+'user/getInfo',            //获取用户信息的接口
  'setUserInfo':serviceUrl+'user/setinfo',            //修改用户信息的接口
  'likefamous':serviceUrl+'user/like/famous/add',    //关注名人接口
  'getListFanous':serviceUrl+'user/like/famous/all',  //获取用户关注的名人
  'deleteListFamous':serviceUrl+'user/like/famous/delete',  //删除关注的名人
  'uploadimage':serviceUrl+'user/uploadimage',              //上传头像


  
};