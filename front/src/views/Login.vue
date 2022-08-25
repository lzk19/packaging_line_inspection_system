<template>
  <div class="login_container">
    <div class="login_box">
      <div class="avatar_box">
        <img src="../assets/柴犬.png"
             alt="" />
      </div>
      <!-- 在规定完校验规则以后需要在表单框架中双向绑定数据，:v-model="login_form" -->
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef" class="login_form"
               label-width="0px">
        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user" v-model="loginForm.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" show-password
                    v-model="loginForm.password" type="password"></el-input>
        </el-form-item>

        <el-form-item>
          <div style="display:flex">
            <el-input prefix-icon="el-icon-key"
                      v-model="loginForm.validCode"
                      style="width:50%;"
                      placeholder="请输入验证码" @keyup.enter.native="login">
            </el-input>
            <ValidCode @input="createValidCode"
                       style="margin-left:20px;border:1px solid lightgray;
                       border-radius:5px;height:38px;width:45%" />
          </div>
        </el-form-item>

        <!-- 按钮 -->
        <el-form-item class="btns">
          <el-button type="primary"
                     @click="login" >登录</el-button>
          <el-button type="info"
                     @click="resetLoginForm">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import ValidCode from "../views/ValidCode.vue"
import {setRoutes} from "@/router";

export default {
  name: "Login",
  components: {
    ValidCode,
  },
  data() {
    return {

      ValidCode: '',

      loginForm: {
        username: "admin",
        password: "admin",
        validCode: '',
      },

      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 10, message: '长度不小于四个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 1, max: 20, message: '长度不小于四个字符', trigger: 'blur'}
        ],
      }
    }
  },
  methods: {

    //接收验证码组件提交的4位验证码
    createValidCode (data) {
      this.ValidCode = data
    },



    //重置表单内容即重置按钮功能
    resetLoginForm () {
      this.$refs.loginFormRef.resetFields(); //resetFilelds是重置表单的一个方法
      this.loginForm.validCode = ''
    },

    login() {
      this.$refs['loginFormRef'].validate((valid) => {
        if (valid) {  // 表单校验合法
          if (!this.loginForm.validCode) {
            this.$message.error("请填写验证码")
            return
          }
          
          this.request.post("/user/login", this.loginForm).then(res => {
            if (res.code === '200') {
              localStorage.setItem("user", JSON.stringify(res.data))  // 存储用户信息到浏览器
              localStorage.setItem("menus", JSON.stringify(res.data.menus))  // 存储用户信息到浏览器
              // 动态设置当前用户的路由
              setRoutes()
              this.$message.success("登录成功")

              if (res.data.role === 'ROLE_STUDENT') {
                this.$router.push("/front/home")
              } else {
                this.$router.push("/")
              }
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      });
    }
  }
}
</script>

<style lang="less" scoped>
.login_container {
  background-color: #2b4b6b;
  height: 100%;
}

.login_box {
  width: 400px;
  height: 350px;
  background-color: #fff;
  border-radius: 3px;
  position: absolute; //绝对定位
  //left:50%和top:50%是让该框的左上顶点位于屏幕的正中心
  left: 50%;
  top: 50%;
  //translate在不知道自身宽高的情况下往上(X轴)、左(Y轴)移动自身长宽的50%
  transform: translate(-50%, -50%);
  .avatar_box {
    width: 130px;
    height: 130px;
    border: 1px solid #eee;
    border-radius: 50%;
    padding: 5px;
    // box-shadow: 0 0 20px #ddd;
    position: absolute;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    img {
      width: 100%;
      height: 100%;
      border-radius: 50%;
      background-color: #eee;
    }
  }
}
.btns {
  display: flex; //flex表示弹性布局
  justify-content: flex-end; //flex-end表示右对齐，flex-start为左对齐(默认值)，center为居中
}
.login_form {
  position: absolute;
  bottom: 0%;
  width: 100%;
  padding: 0 10px;
  box-sizing: border-box; //box-sizing: border-box就是将border和padding数值包含在width和height之内，这样的好处就是修改border和padding数值盒子的大小不变
}
</style>

