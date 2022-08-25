<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检普通板块</el-breadcrumb-item>
      <el-breadcrumb-item>指导抽查</el-breadcrumb-item>
    </el-breadcrumb>

    <!-- z-index属性 -->
    <el-card>
      <el-button type="primary"
                 @click="addRecordDialogVisible = true">新建记录</el-button>

      <el-button type="primary"
                 @click="updateRecordDialogVisible = true">修改记录</el-button>

      <!-- <el-button type="primary"
                 @click="refreshRecord">更新记录</el-button> -->
      <!-- onclick="document.getElementById('historyTable').style.display = 'block'" -->
      <el-button type="primary"
                 @click="showTable">查看历史记录</el-button>

      <el-button type="primary">导出</el-button>
    </el-card>

    <!-- item.gdq3answer -->
    <!-- guidanceRecordList -->

    <el-card>
      <!-- Tier1会议填写表格 stripe:斑马线格式-->
      <el-table :data="problemList"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         label="指导抽查"
                         width="600px">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in guidanceRecordList"
              :key="index"
              :label1="item"
              class="tier_elrow">
        <el-col class="tier_1_elcol">&nbsp;记录1:&nbsp;{{ item.gdq1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.gdq2answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录3:&nbsp;{{ item.gdq3answer }}</el-col>
      </el-row>
    </el-card>

    <!-- 新增Tier记录区域 visible:表示是否显示对话框  @close关闭tag时触发的事件-->
    <el-dialog title="新建记录"
               :visible.sync="addRecordDialogVisible"
               width="40%"
               @close="addRecordDialogClosed"
               v-dialogDrag>
      <!--red:校验规则的内容 存放在addFormRef下 -->
      <!-- 添加记录对话框里的表单内容 -->
      <el-form :model="addRecordForm"
               :rules="addRecordFormRules"
               ref="addRecordFormRef"
               label-width="70px">
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="Gd1-1"
                      prop="gdq1answer">
          <el-input v-model="addRecordForm.gdq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Gd1-2"
                      prop="gdq2answer">
          <el-input v-model="addRecordForm.gdq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Gd1-3"
                      prop="gdq3answer">
          <el-input v-model="addRecordForm.gdq3answer"></el-input>
        </el-form-item>
      </el-form>

      <!-- 表单底部按钮 -->
      <span slot="footer"
            class="dialog-footer">
        <el-button @click="addRecordDialogVisible = false">取消</el-button>
        <el-button type="primary"
                   @click="addRecord">确定</el-button>
      </span>
    </el-dialog>

    <!-- 修改记录信息的对话框 -->
    <el-dialog title="修改记录"
               :visible.sync="updateRecordDialogVisible"
               width="40%"
               @close="updateRecordDialogClosed"
               v-dialogDrag>
      <!--ref:校验规则的内容 updateForm -->
      <!-- 修改记录信息对话框里的表单内容 -->
      <el-form :model="updateRecordForm"
               :rules="addRecordFormRules"
               ref="updateRecordFormRef"
               label-width="70px"
               v-for="(item, index) in guidanceRecordList"
               :key="index"
               :label2="item">
        <!-- :placeholder="item.t1q1answer" -->
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="Gd1-1"
                      prop="gdq1answer">
          <el-input v-model="updateRecordForm.gdq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Gd1-2"
                      prop="gdq2answer">
          <el-input v-model="updateRecordForm.gdq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Gd1-3"
                      prop="gdq3answer">
          <el-input v-model="updateRecordForm.gdq3answer"></el-input>
        </el-form-item>
      </el-form>

      <!-- 表单底部按钮 -->
      <span slot="footer"
            class="dialog-footer">
        <el-button @click="updateRecordDialogVisible = false">取消</el-button>
        <el-button type="primary"
                   @click="updateRecordInfo">确定</el-button>
      </span>
    </el-dialog>

    <!-- 分割线 -->
    <el-divider></el-divider>

    <!-- 查看历史记录 -->
    <el-card id="historyTable"
             style="height:450px">
      <span class="historySpan">指导抽查历史记录</span>
      <el-table :data="guidanceRecordList1"
                stripe
                height="295"
                :header-row-style="{ height: '60px' }">
        <el-table-column prop="name"
                         label="姓名"
                         style="margin-top: 20px">
        </el-table-column>
        <el-table-column prop="date"
                         label="日期"> </el-table-column>
        <el-table-column prop="shift"
                         label="班次"> </el-table-column>
        <el-table-column prop="line"
                         label="线号"> </el-table-column>
        <el-table-column prop="gdq1answer"
                         label="指导抽查题1记录">
        </el-table-column>
        <el-table-column prop="gdq2answer"
                         label="指导抽查题2记录">
        </el-table-column>
        <el-table-column prop="gdq3answer"
                         label="指导抽查题3记录">
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  //这个方法是一进入页面就显示数据
  created () {
    // 调用当前的getUserList方法
    this.getGuidanceRecordList();
    this.getGuidanceRecordList1();
    this.getProblemList();
  },
  data () {
    return {
      addRecordDialogVisible: false, //添加记录的对话框

      updateRecordDialogVisible: false, //修改记录的对话框

      updateProblemDialogVisible: false,

      addRecordForm: {
        gdq1answer: "",
        gdq2answer: "",
        gdq3answer: "",
      },

      addRecordFormRules: {
        gdq1answer: [
          {
            required: true,
            message: "请输入指导抽查问题1记录",
            trigger: "blur",
          },
        ],
        gdq2answer: [
          {
            required: true,
            message: "请输入指导抽查问题2记录",
            trigger: "blur",
          },
        ],
        gdq3answer: [
          {
            required: true,
            message: "请输入指导抽查问题3记录",
            trigger: "blur",
          },
        ],
      },

      updateRecordForm: [],

      guidanceRecordList: [], //记录列表

      guidanceRecordList1: [],

      problemList: [],
    };
  },

  methods: {
    showTable () {
      var zt = document.getElementById('historyTable')
      if (zt.style.display != "block") {
        zt.style.display = 'block'
      } else if (zt.style.display != "none") {
        zt.style.display = 'none'
      }
    },

    addRecord () {
      this.$refs.addRecordFormRef.validate(async (valid) => {
        if (!valid) return;
        this.request.post("/addGuidanceRecord", this.addRecordForm).then(res => {
        if (res.code === '200') {
          this.$message.success("添加记录成功！")
          this.getGuidanceRecordList();
          this.addRecordDialogVisible = false;
        } else {
          this.$message.error("添加记录失败！")
        }
      })
      });
    },



    // addRecord () {
    //   this.$refs.addRecordFormRef.validate(async (valid) => {
    //     if (!valid) return;
    //     const { data: res } = await this.$http.post(
    //       "addGuidanceRecord",
    //       this.addRecordForm
    //     );
    //     if (res != "success") {
    //       return this.$message.error("新建记录失败！");
    //     }
    //     this.$message.success("新建记录成功！"); //提示信息
    //     this.getGuidanceRecordList();
    //     this.addRecordDialogVisible = false;
    //   });
    // },

    //关闭添加记录窗口
    addRecordDialogClosed () {
      this.$refs.addRecordFormRef.resetFields();
    },

    //关闭修改记录窗口
    updateRecordDialogClosed () {
      this.updateRecordDialogVisible = false; //重置信息
      this.getGuidanceRecordList();
    },

    //确认修改记录
        updateRecordInfo () {
      this.$refs.updateRecordFormRef[0].validate(async (valid) => {
        if (!valid) return; //验证失败

        this.request.post("/updateGuidanceRecord", this.updateRecordForm).then(res => {
          if (res.code === '200') {
            this.$message.success("修改记录成功！")
            this.getGuidanceRecordList();
            this.updateRecordDialogVisible = false;
          } else {
            this.$message.error("修改记录失败！")
          }
          })
      });
    },

    // updateRecordInfo () {
    //   this.$refs.updateRecordFormRef[0].validate(async (valid) => {
    //     if (!valid) return; //验证失败

    //     // 发起修改请求
    //     const { data: res } = await this.$http.put(
    //       "updateGuidanceRecord",
    //       this.updateRecordForm
    //     );
    //     if (res != "success") return this.$message.error("修改记录失败！");
    //     this.$message.success("修改记录成功！");
    //     //隐藏修改记录信息对话框
    //     this.updateRecordDialogVisible = false;
    //     this.getGuidanceRecordList();
    //   });
    // },

    getGuidanceRecordList() {
      this.request.get("/getGuidanceRecord").then(res => {
        this.guidanceRecordList = res.data
        this.updateRecordForm = res.data[0];
        this.getGuidanceRecordList1();
      })},

    // 获取所有记录信息(包括HeadData)
    getGuidanceRecordList1() {
      this.request.get("/getGuidanceRecordList").then(res => {
        this.guidanceRecordList1 = res.data
      })},

    // // 获取所有记录信息(包括HeadData)
    // async getGuidanceRecordList1 () {
    //   const { data: res } = await this.$http.get("getGuidanceRecordList"); //get请求方法
    //   this.guidanceRecordList1 = res.data;
    // },

    // // 获取所有记录信息
    // async getGuidanceRecordList () {
    //   const { data: res } = await this.$http.get("getGuidanceRecordItem"); //get请求方法
    //   this.guidanceRecordList = res.data;
    //   this.updateRecordForm = res.data[0];
    //   this.getGuidanceRecordList1();
    // },




    // 获取所有问题信息
    getProblemList() {
      this.request.get("/getGuiProblem").then(res => {
        this.problemList = res.data
      })},

    // async refreshRecord () {
    //   this.getGuidanceRecordList();
    //   this.$message.success("更新记录成功！");
    // },
  },
};
</script>

<style lang="less" scoped>
#historyTable {
  display: none;
}

.historySpan {
  padding-left: 10px;
  font-family: Microsoft YaHei;
  font-size: 14px;
  color: #909399;
  font-weight: bold;
}

.tier_elrow {
  display: block;
  float: left;
  width: 50%;
  height: 300px;
}

.tier_1_elcol {
  height: 49px;
  // background: red;
  margin-top: 47px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  border: solid 1px lightgray;
  border-left-style: none;
  border-right-style: none;
  color: #606266;
}

.tier_2_elcol {
  height: 47px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  color: #606266;
  background: #fafafa;
}

.tier_3_elcol {
  height: 49px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  border: solid 1px lightgray;
  border-left-style: none;
  border-right-style: none;
  color: #606266;
}
</style>
