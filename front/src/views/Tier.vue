<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检普通板块</el-breadcrumb-item>
      <el-breadcrumb-item>Tier会议</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card>
      <el-button type="primary"
                 @click="addRecordDialogVisible = true">新建记录</el-button>

      <el-button type="primary"
                 @click="updateRecordDialogVisible = true">修改记录</el-button>

      <!-- <el-button type="primary"
                 @click="refreshRecord">更新记录</el-button> -->

      <el-button type="primary"
                 @click="showHistoryTable=!showHistoryTable">查看历史记录</el-button>

      <el-button type="primary" @click="expAll">普通板块所有记录导出</el-button>
      <el-button type="primary" @click="exp">Tier会议记录导出</el-button>
    </el-card>

    <el-card>
      <!-- Tier1会议填写表格 stripe:斑马线格式-->
      <el-table :data="problemList1"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         label="Tier1会议"
                         width="600px">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in tierRecordList"
              :key="index"
              :label1="item"
              class="tier_elrow">
        <el-col class="tier_1_elcol">&nbsp;记录1:&nbsp;{{ item.t1q1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.t1q2answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录3:&nbsp;{{ item.t1q3answer }}</el-col>
        <el-col class="tier_4_elcol">&nbsp;记录4:&nbsp;{{ item.t1q4answer }}</el-col>
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
        <el-form-item label="Tier1-1"
                      prop="t1q1answer">
          <el-input v-model="addRecordForm.t1q1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Tier1-2"
                      prop="t1q2answer">
          <el-input v-model="addRecordForm.t1q2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Tier1-3"
                      prop="t1q3answer">
          <el-input v-model="addRecordForm.t1q3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="Tier1-4"
                      prop="t1q4answer">
          <el-input v-model="addRecordForm.t1q4answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题1记录 -->
        <el-form-item label="Tier2-1"
                      prop="t2q1answer">
          <el-input v-model="addRecordForm.t2q1answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题2记录 -->
        <el-form-item label="Tier2-2"
                      prop="t2q2answer">
          <el-input v-model="addRecordForm.t2q2answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题3记录 -->
        <el-form-item label="Tier2-3"
                      prop="t2q3answer">
          <el-input v-model="addRecordForm.t2q3answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题4记录 -->
        <el-form-item label="Tier2-4"
                      prop="t2q4answer">
          <el-input v-model="addRecordForm.t2q4answer"></el-input>
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
               v-for="(item, index) in tierRecordList"
               :key="index"
               :label2="item">
        <!-- :placeholder="item.t1q1answer" -->
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="Tier1-1"
                      prop="t1q1answer">
          <el-input v-model="updateRecordForm.t1q1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Tier1-2"
                      prop="t1q2answer">
          <el-input v-model="updateRecordForm.t1q2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Tier1-3"
                      prop="t1q3answer">
          <el-input v-model="updateRecordForm.t1q3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="Tier1-4"
                      prop="t1q4answer">
          <el-input v-model="updateRecordForm.t1q4answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题1记录 -->
        <el-form-item label="Tier2-1"
                      prop="t2q1answer">
          <el-input v-model="updateRecordForm.t2q1answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题2记录 -->
        <el-form-item label="Tier2-2"
                      prop="t2q2answer">
          <el-input v-model="updateRecordForm.t2q2answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题3记录 -->
        <el-form-item label="Tier2-3"
                      prop="t2q3answer">
          <el-input v-model="updateRecordForm.t2q3answer"></el-input>
        </el-form-item>

        <!-- Tier2会议问题4记录 -->
        <el-form-item label="Tier2-4"
                      prop="t2q4answer">
          <el-input v-model="updateRecordForm.t2q4answer"></el-input>
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

    <el-card>
      <!-- Tier2会议填写表格 -->
      <el-table :data="problemList2"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         width="600"
                         label="Tier2会议">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in tierRecordList"
              :key="index"
              :label2="item"
              class="tier_elrow">
        <el-col class="tier_1_elcol"
                @>&nbsp;记录1:&nbsp;{{ item.t2q1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.t2q2answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录3:&nbsp;{{ item.t2q3answer }}</el-col>
        <el-col class="tier_4_elcol">&nbsp;记录4:&nbsp;{{ item.t2q4answer }}</el-col>
      </el-row>
    </el-card>

    <!-- 分割线 -->
    <el-divider></el-divider>

    <!-- 查看历史记录 -->
    <el-card style="height:450px"
             id="historyTable" v-if="showHistoryTable==true">
      <span class="historySpan">Tier历史记录</span>
      <el-table :data="tierRecordList1"
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
        <el-table-column prop="t1q1answer"
                         label="会议1题1记录">
        </el-table-column>
        <el-table-column prop="t1q2answer"
                         label="会议1题2记录">
        </el-table-column>
        <el-table-column prop="t1q3answer"
                         label="会议1题3记录">
        </el-table-column>
        <el-table-column prop="t1q4answer"
                         label="会议1题4记录">
        </el-table-column>
        <el-table-column prop="t2q1answer"
                         label="会议2题1记录">
        </el-table-column>
        <el-table-column prop="t2q2answer"
                         label="会议2题2记录">
        </el-table-column>
        <el-table-column prop="t2q3answer"
                         label="会议2题3记录">
        </el-table-column>
        <el-table-column prop="t2q4answer"
                         label="会议2题4记录">
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import {serverIp} from "../../public/config";
export default {
  //这个方法是一进入页面就显示数据
  created () {
    // 调用当前的getUserList方法
    this.getTierRecordList();
    this.getTierRecordList1();
    this.getProblemList1();
    this.getProblemList2();
  },
  data () {
    return {
      showHistoryTable:false,
      addRecordDialogVisible: false, //添加记录的对话框

      updateRecordDialogVisible: false, //修改记录的对话框

      addRecordForm: {
        t1q1answer: "",
        t1q2answer: "",
        t1q3answer: "",
        t1q4answer: "",
        t2q1answer: "",
        t2q2answer: "",
        t2q3answer: "",
        t2q4answer: "",
      },

      addRecordFormRules: {
        t1q1answer: [
          {
            required: true,
            message: "请输入Tier1会议问题1记录",
            trigger: "blur",
          },
        ],
        t1q2answer: [
          {
            required: true,
            message: "请输入Tier1会议问题2记录",
            trigger: "blur",
          },
        ],
        t1q3answer: [
          {
            required: true,
            message: "请输入Tier1会议问题3记录",
            trigger: "blur",
          },
        ],
        t1q4answer: [
          {
            required: true,
            message: "请输入Tier1会议问题4记录",
            trigger: "blur",
          },
        ],
        t2q1answer: [
          {
            required: true,
            message: "请输入Tier2会议问题1记录",
            trigger: "blur",
          },
        ],
        t2q2answer: [
          {
            required: true,
            message: "请输入Tier2会议问题2记录",
            trigger: "blur",
          },
        ],
        t2q3answer: [
          {
            required: true,
            message: "请输入Tier2会议问题3记录",
            trigger: "blur",
          },
        ],
        t2q4answer: [
          {
            required: true,
            message: "请输入Tier2会议问题4记录",
            trigger: "blur",
          },
        ],
      },

      updateRecordForm: [],

      tierRecordList: [], //记录列表
      tierRecordList1: [], //记录列表

      problemList1: [],
      problemList2: [],
    };
  },

  methods: {

    addRecord () {
      this.$refs.addRecordFormRef.validate(async (valid) => {
        if (!valid) return;
        this.request.post("/addTierRecord", this.addRecordForm).then(res => {
        if (res.code === '200') {
          this.$message.success("添加记录成功！")
          this.getTierRecordList();
          this.addRecordDialogVisible = false;
        } else {
          this.$message.error("添加记录失败！")
        }
      })
      });
    },

    addRecordDialogClosed () {
      this.$refs.addRecordFormRef.resetFields();
    },

    //关闭窗口
    updateRecordDialogClosed () {
      this.updateRecordDialogVisible = false;
      this.getTierRecordList();
    },

    //确认修改
    updateRecordInfo () {
      this.$refs.updateRecordFormRef[0].validate(async (valid) => {
        if (!valid) return; //验证失败

        this.request.post("/updateTierRecord", this.updateRecordForm).then(res => {
          if (res.code === '200') {
            this.$message.success("修改记录成功！")
            this.getTierRecordList();
            this.updateRecordDialogVisible = false;
          } else {
            this.$message.error("修改记录失败！")
          }
          })
      });
    },

    // 获取所有问题信息
    getProblemList1() {
      this.request.get("/getTier1Problem").then(res => {
        this.problemList1 = res.data
      })},

    getProblemList2() {
      this.request.get("/getTier2Problem").then(res => {
        this.problemList2 = res.data
      })},

    getTierRecordList() {
      this.request.get("/getTierRecord").then(res => {
        this.tierRecordList = res.data
        this.updateRecordForm = res.data[0];
        this.getTierRecordList1();
      })},

    // 获取所有记录信息(包括HeadData)
    getTierRecordList1() {
      this.request.get("/getTierRecordList").then(res => {
        this.tierRecordList1 = res.data
      })},

      exp() {
      window.open(`http://localhost:9090/tier/export`)
    },

    // async refreshRecord () {
    //   this.getTierRecordList();
    //   this.$message.success("更新记录成功！");
    // },
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
  // padding-left: 20px;
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
</style>
