<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检普通板块</el-breadcrumb-item>
      <el-breadcrumb-item>巡检</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card>
      <el-button type="primary"
                 @click="addRecordDialogVisible = true">新建记录</el-button>

      <el-button type="primary"
                 @click="updateRecordDialogVisible = true">修改记录</el-button>

      <!-- <el-button type="primary"
                 @click="refreshRecord">更新记录</el-button> -->

      <el-button type="primary"
                 @click="showTable">查看历史记录</el-button>

      <el-button type="primary">导出</el-button>
    </el-card>

    <el-card style="height: 260px">
      <!-- 安全巡检填写表格 stripe:斑马线格式-->
      <el-table :data="problemList1"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         label="安全巡检"
                         width="600px">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in inspectRecordList"
              :key="index"
              :label1="item"
              class="inspect_elrow">
        <el-col class="tier_1_elcol">&nbsp;记录1:&nbsp;{{ item.sfq1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.sfq2answer }}</el-col>
        <el-col class="sf_inspect_3_elcol">&nbsp;记录3:&nbsp;{{ item.sfq3answer }}</el-col>
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
               label-width="80px">
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="安检1-1"
                      prop="sfq1answer">
          <el-input v-model="addRecordForm.sfq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="安检1-2"
                      prop="sfq2answer">
          <el-input v-model="addRecordForm.sfq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="安检1-3"
                      prop="sfq3answer">
          <el-input v-model="addRecordForm.sfq3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="质检1-1"
                      prop="qlq1answer">
          <el-input v-model="addRecordForm.qlq1answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题1记录 -->
        <el-form-item label="质检1-2"
                      prop="qlq2answer">
          <el-input v-model="addRecordForm.qlq2answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题2记录 -->
        <el-form-item label="质检1-3"
                      prop="qlq3answer">
          <el-input v-model="addRecordForm.qlq3answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题3记录 -->
        <el-form-item label="质检1-4"
                      prop="qlq4answer">
          <el-input v-model="addRecordForm.qlq4answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题4记录 -->
        <el-form-item label="质检1-5"
                      prop="qlq5answer">
          <el-input v-model="addRecordForm.qlq5answer"></el-input>
        </el-form-item>

        <el-form-item label="质检1-6"
                      prop="qlq6answer">
          <el-input v-model="addRecordForm.qlq6answer"></el-input>
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
               label-width="80px"
               v-for="(item, index) in inspectRecordList"
               :key="index"
               :label2="item">
        <!-- :placeholder="item.t1q1answer" -->
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="安检1-1"
                      prop="sfq1answer">
          <el-input v-model="updateRecordForm.sfq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="安检1-2"
                      prop="sfq2answer">
          <el-input v-model="updateRecordForm.sfq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="安检1-3"
                      prop="sfq3answer">
          <el-input v-model="updateRecordForm.sfq3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="质检1-1"
                      prop="qlq1answer">
          <el-input v-model="updateRecordForm.qlq1answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题1记录 -->
        <el-form-item label="质检1-2"
                      prop="qlq2answer">
          <el-input v-model="updateRecordForm.qlq2answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题2记录 -->
        <el-form-item label="质检1-3"
                      prop="qlq3answer">
          <el-input v-model="updateRecordForm.qlq3answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题3记录 -->
        <el-form-item label="质检1-4"
                      prop="qlq4answer">
          <el-input v-model="updateRecordForm.qlq4answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题4记录 -->
        <el-form-item label="质检1-5"
                      prop="qlq5answer">
          <el-input v-model="updateRecordForm.qlq5answer"></el-input>
        </el-form-item>

        <el-form-item label="质检1-6"
                      prop="qlq6answer">
          <el-input v-model="updateRecordForm.qlq6answer"></el-input>
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

    <el-card style="height: 410px">
      <!-- Tier2会议填写表格 -->
      <el-table :data="problemList2"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         width="600"
                         label="质量巡检">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in inspectRecordList"
              :key="index"
              :label2="item"
              class="inspect_elrow">
        <el-col class="tier_1_elcol">&nbsp;记录1:&nbsp;{{ item.qlq1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.qlq2answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录3:&nbsp;{{ item.qlq3answer }}</el-col>
        <el-col class="ql_inspect_4_elcol">&nbsp;记录4:&nbsp;{{ item.qlq4answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录5:&nbsp;{{ item.qlq5answer }}</el-col>
        <el-col class="tier_4_elcol">&nbsp;记录6:&nbsp;{{ item.qlq6answer }}</el-col>
      </el-row>
    </el-card>

    <!-- 分割线 -->
    <el-divider></el-divider>

    <!-- 查看历史记录 -->
    <el-card style="height:450px"
             id="historyTable">
      <span class="historySpan">巡检管理历史记录</span>
      <el-table :data="inspectRecordList1"
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
        <el-table-column prop="sfq1answer"
                         label="安检题1记录"> </el-table-column>
        <el-table-column prop="sfq2answer"
                         label="安检题2记录"> </el-table-column>
        <el-table-column prop="sfq3answer"
                         label="安检题3记录"> </el-table-column>
        <el-table-column prop="qlq1answer"
                         label="质检题1记录"> </el-table-column>
        <el-table-column prop="qlq2answer"
                         label="质检题2记录"> </el-table-column>
        <el-table-column prop="qlq3answer"
                         label="质检题3记录"> </el-table-column>
        <el-table-column prop="qlq4answer"
                         label="质检题4记录"> </el-table-column>
        <el-table-column prop="qlq5answer"
                         label="质检题5记录"> </el-table-column>
        <el-table-column prop="qlq6answer"
                         label="质检题6记录"> </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  //这个方法是一进入页面就显示数据
  created () {
    // 调用当前的getUserList方法
    this.getInspectRecordList();
    this.getInspectRecordList1();
    this.getProblemList1();
    this.getProblemList2();
  },
  data () {
    return {
      addRecordDialogVisible: false, //添加记录的对话框

      updateRecordDialogVisible: false, //修改记录的对话框

      addRecordForm: {
        sfq1answer: "",
        sfq2answer: "",
        sfq3answer: "",
        qlq1answer: "",
        qlq2answer: "",
        qlq3answer: "",
        qlq4answer: "",
        qlq5answer: "",
        qlq6answer: "",
      },

      addRecordFormRules: {
        sfq1answer: [
          {
            required: true,
            message: "请输入安全巡检问题1记录",
            trigger: "blur",
          },
        ],
        sfq2answer: [
          {
            required: true,
            message: "请输入安全巡检问题2记录",
            trigger: "blur",
          },
        ],
        sfq3answer: [
          {
            required: true,
            message: "请输入安全巡检问题3记录",
            trigger: "blur",
          },
        ],
        qlq1answer: [
          {
            required: true,
            message: "请输入质量巡检问题1记录",
            trigger: "blur",
          },
        ],
        qlq2answer: [
          {
            required: true,
            message: "请输入质量巡检问题2记录",
            trigger: "blur",
          },
        ],
        qlq3answer: [
          {
            required: true,
            message: "请输入质量巡检问题3记录",
            trigger: "blur",
          },
        ],
        qlq4answer: [
          {
            required: true,
            message: "请输入质量巡检问题4记录",
            trigger: "blur",
          },
        ],
        qlq5answer: [
          {
            required: true,
            message: "请输入质量巡检问题5记录",
            trigger: "blur",
          },
        ],
        qlq6answer: [
          {
            required: true,
            message: "请输入质量巡检问题6记录",
            trigger: "blur",
          },
        ],
      },

      updateRecordForm: [],

      inspectRecordList: [], //记录列表
      inspectRecordList1: [], //记录列表

      problemList1: [],
      problemList2: [],
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
        this.request.post("/addInspectRecord", this.addRecordForm).then(res => {
        if (res.code === '200') {
          this.$message.success("添加记录成功！")
          this.getInspectRecordList();
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
    //       "addInspectRecord",
    //       this.addRecordForm
    //     );
    //     if (res != "success") {
    //       return this.$message.error("新建记录失败！");
    //     }
    //     this.$message.success("新建记录成功！"); //提示信息
    //     this.getInspectRecordList();
    //     this.addRecordDialogVisible = false;
    //   });
    // },

    addRecordDialogClosed () {
      this.$refs.addRecordFormRef.resetFields();
    },

    //关闭窗口
    updateRecordDialogClosed () {
      this.updateRecordDialogVisible = false; //重置信息
      this.getInspectRecordList();
    },

    //确认修改
    updateRecordInfo () {
      this.$refs.updateRecordFormRef[0].validate(async (valid) => {
        if (!valid) return; //验证失败

        this.request.post("/updateInspectRecord", this.updateRecordForm).then(res => {
          if (res.code === '200') {
            this.$message.success("修改记录成功！")
            this.getInspectRecordList();
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
    //       "updateInspectRecord",
    //       this.updateRecordForm
    //     );
    //     if (res != "success") return this.$message.error("修改记录失败！");
    //     this.$message.success("修改记录成功！");
    //     //隐藏修改记录信息对话框
    //     this.updateRecordDialogVisible = false;
    //     this.getInspectRecordList();
    //   });
    // },

    // 获取所有问题信息
    getProblemList1() {
      this.request.get("/getInspect1Problem").then(res => {
        this.problemList1 = res.data
      })},

    getProblemList2() {
      this.request.get("/getInspect2Problem").then(res => {
        this.problemList2 = res.data
      })},


    // 获取所有记录信息
    getInspectRecordList() {
      this.request.get("/getInspectRecord").then(res => {
        this.inspectRecordList = res.data
        this.updateRecordForm = res.data[0];
        this.getInspectRecordList1();
      })},

    // 获取所有记录信息(包括HeadData)
    getInspectRecordList1() {
      this.request.get("/getInspectRecordList").then(res => {
        this.inspectRecordList1 = res.data
      })},

    // async getInspectRecordList () {
    //   const { data: res } = await this.$http.get("getInspectRecordItem"); //get请求方法
    //   this.inspectRecordList = res.data;
    //   this.updateRecordForm = res.data[0];
    //   this.getInspectRecordList1();
    // },

    // // 获取所有记录信息(包括HeadData)
    // async getInspectRecordList1 () {
    //   const { data: res } = await this.$http.get("getInspectRecordList"); //get请求方法
    //   this.inspectRecordList1 = res.data;
    // },

    async refreshRecord () {
      this.getInspectRecordList();
      this.$message.success("更新记录成功！");
    },
  },
};
</script>

<style lang="less" scoped>
.Tier1Box {
  //下面这四条语句可以让div板块居中
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

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

.inspect_elrow {
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
  border-bottom-style: none;
  color: #606266;
}

.tier_4_elcol {
  height: 50px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  border: solid 1px lightgray;
  border-left-style: none;
  border-right-style: none;
  color: #606266;
  background: #fafafa;
  margin-top: -1px;
}

.ql_inspect_4_elcol {
  height: 50px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  border: solid 1px lightgray;
  border-left-style: none;
  border-right-style: none;
  border-bottom-style: none;
  color: #606266;
  background: #fafafa;
  margin-top: -1px;
}

.sf_inspect_3_elcol {
  height: 49px;
  padding-top: 12px;
  font: 14px, Microsoft YaHei;
  border: solid 1px lightgray;
  border-left-style: none;
  border-right-style: none;
  color: #606266;
}
</style>
