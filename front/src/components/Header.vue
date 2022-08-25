<template>
  <el-container class="home-container">
    <el-header>
      <div class="div1">
        <img src="../assets/柴犬.png" alt="" />
        <span>包装线长在线巡检系统</span>
      </div>

      <el-dropdown style="width: 150px; cursor: pointer; text-align: right;">
      <div  class="div2">
        <img :src="user.avatarUrl" alt=""
             style="height:60px;width: 60px; border-radius: 50%;">
        <span class="spans">{{ user.name }}</span><i class="el-icon-arrow-down" style="margin-left: 5px;color:white;font-size:10px"></i>
      </div>
      <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center;margin-right:30px">
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <router-link to="/password">修改密码</router-link>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <router-link to="/person">个人信息</router-link>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <span style="text-decoration: none" @click="logout">退出</span>
        </el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>


    </el-header>




    



  </el-container>
  

    



  
</template>

<script>
export default {
  name: "Header",
  props: {
    collapseBtnClass: String,
    user: Object
  },
  computed: {
    currentPathName () {
      return this.$store.state.currentPathName;　　//需要监听的数据
    }
  },
  data() {
    return {

    }
  },
  methods: {
    collapse() {
      // this.$parent.$parent.$parent.$parent.collapse()  // 通过4个 $parent 找到父组件，从而调用其折叠方法
      this.$emit("asideCollapse")
    },
    // logout() {
    //   window.sessionStorage.clear();
    //   this.$router.push("/login");
    // },
    logout() {
      this.$store.commit("logout")
      this.$message.success("退出成功")
    }
  }
}
</script>

<style lang="less" scoped>

.el-header {
  margin-left: -20px;
  margin-right: -20px;
  background-color: #373d41;
  display: flex;
  justify-content: space-between; // 左右贴边
  padding-left: 0%; // 左边界
  align-items: center; // 水平
  color: #fff;
  font-size: 20px;
  .div1 {
    //左侧div加布局
    display: flex;
    align-items: center;
    span {
      margin-left: 15px;
    }
  }

  .div2{
    // background: red;
    height: 60px;
    width: 220px;
    display: flex;
    align-items: center;
    margin-left: -60px;
    span {
      margin-left: 15px;
      font-size: 20px;
    }
  }
  
}

.spans{
  color: #fff;
  font-size: 18px;
}

.home-container {
  height: 100%;
}

img {
  width: 55px;
  height: 55px;
}
.iconfont {
  margin-right: 10px;
}

</style>
