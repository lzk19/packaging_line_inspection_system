<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检普通板块</el-breadcrumb-item>
      <el-breadcrumb-item>效率评价</el-breadcrumb-item>
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

    <el-card>
      <!-- Tier1会议填写表格 stripe:斑马线格式-->
      <el-table :data="problemList"
                stripe
                style="width: 50%; float: left">
        <el-table-column prop="problem"
                         label="效率评价"
                         width="600px">
        </el-table-column>
      </el-table>

      <el-row v-for="(item, index) in efficiencyRecordList"
              :key="index"
              :label1="item"
              class="tier_elrow">
        <el-col class="tier_1_elcol">&nbsp;记录1:&nbsp;{{ item.effiq1answer }}</el-col>
        <el-col class="tier_2_elcol">&nbsp;记录2:&nbsp;{{ item.effiq2answer }}</el-col>
        <el-col class="tier_3_elcol">&nbsp;记录3:&nbsp;{{ item.effiq3answer }}</el-col>
        <el-col class="tier_4_elcol">&nbsp;记录4:&nbsp;{{ item.effiq4answer }}</el-col>
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
        <el-form-item label="Effi1-1"
                      prop="effiq1answer">
          <el-input v-model="addRecordForm.effiq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Effi1-2"
                      prop="effiq2answer">
          <el-input v-model="addRecordForm.effiq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Effi1-3"
                      prop="effiq3answer">
          <el-input v-model="addRecordForm.effiq3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="Effi1-4"
                      prop="effiq4answer">
          <el-input v-model="addRecordForm.effiq4answer"></el-input>
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
               v-for="(item, index) in efficiencyRecordList"
               :key="index"
               :label2="item">
        <!-- :placeholder="item.t1q1answer" -->
        <!-- Tier1会议问题1记录 -->
        <el-form-item label="Effi1-1"
                      prop="effiq1answer">
          <el-input v-model="updateRecordForm.effiq1answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题2记录 -->
        <el-form-item label="Effi1-2"
                      prop="effiq2answer">
          <el-input v-model="updateRecordForm.effiq2answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题3记录 -->
        <el-form-item label="Effi1-3"
                      prop="effiq3answer">
          <el-input v-model="updateRecordForm.effiq3answer"></el-input>
        </el-form-item>

        <!-- Tier1会议问题4记录 -->
        <el-form-item label="Effi1-4"
                      prop="effiq4answer">
          <el-input v-model="updateRecordForm.effiq4answer"></el-input>
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
      <div id="main"
           style="float:left;width:100%;height:330px"></div>
    </el-card>
    <el-divider></el-divider>
    <!-- 查看历史记录 -->
    <el-card style="height:450px"
             id="historyTable">
      <span class="historySpan">效率评价历史记录</span>
      <el-table :data="efficiencyRecordList1"
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
        <el-table-column prop="effiq1answer"
                         label="效率评价题1记录">
        </el-table-column>
        <el-table-column prop="effiq2answer"
                         label="效率评价题2记录">
        </el-table-column>
        <el-table-column prop="effiq3answer"
                         label="效率评价题3记录">
        </el-table-column>
        <el-table-column prop="effiq4answer"
                         label="效率评价题4记录">
        </el-table-column>
      </el-table>
    </el-card>

  </div>
</template>

<script>
import * as echarts from 'echarts';
export default {
  //这个方法是一进入页面就显示数据
  created () {
    // 调用当前的getUserList方法
    this.getEfficiencyRecordList();
    this.getEfficiencyRecordList1();
    this.getProblemList();
  },

  mounted () {
    var option = {
      title: {
        text: '当前产线P值'
      },
      tooltip: {},
      legend: {
        data: ['P值']

      },
      xAxis: {
        data: [],
      },
      yAxis: {},
      series: [{
        name: 'P值',
        type: 'line',
        data: [],
      }]
    }
    var chart = document.getElementById('main');
    var chartData = echarts.init(chart);

    this.request.get("getP").then(function (res) {
      option.xAxis.data = res.data.x
      option.series[0].data = res.data.y
      chartData.setOption(option, true);
    })
  },

  data () {
    return {
      addRecordDialogVisible: false, //添加记录的对话框

      updateRecordDialogVisible: false, //修改记录的对话框

      addRecordForm: {
        effiq1answer: "",
        effiq2answer: "",
        effiq3answer: "",
        effiq4answer: "",
      },

      addRecordFormRules: {
        effiq1answer: [
          {
            required: true,
            message: "请输入效率评价问题1记录",
            trigger: "blur",
          },
        ],
        effiq2answer: [
          {
            required: true,
            message: "请输入效率评价问题2记录",
            trigger: "blur",
          },
        ],
        effiq3answer: [
          {
            required: true,
            message: "请输入效率评价问题3记录",
            trigger: "blur",
          },
        ],
        effiq4answer: [
          {
            required: true,
            message: "请输入效率评价问题4记录",
            trigger: "blur",
          },
        ],
      },

      updateRecordForm: [],

      efficiencyRecordList: [], //记录列表

      problemList: [],

      efficiencyRecordList1: [],
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
        this.request.post("/addEfficiencyRecord", this.addRecordForm).then(res => {
        if (res.code === '200') {
          this.$message.success("添加记录成功！")
          this.getEfficiencyRecordList();
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
    //       "addEfficiencyRecord",
    //       this.addRecordForm
    //     );
    //     if (res != "success") {
    //       return this.$message.error("新建记录失败！");
    //     }
    //     this.$message.success("新建记录成功！"); //提示信息
    //     this.getEfficiencyRecordList();
    //     this.addRecordDialogVisible = false;
    //   });
    // },

    addRecordDialogClosed () {
      this.$refs.addRecordFormRef.resetFields();
    },

    //关闭窗口
    updateRecordDialogClosed () {
      this.updateRecordDialogVisible = false; //重置信息
      this.getEfficiencyRecordList();
    },

    //确认修改
    updateRecordInfo () {
      this.$refs.updateRecordFormRef[0].validate(async (valid) => {
        if (!valid) return; //验证失败

        this.request.post("/updateEfficiencyRecord", this.updateRecordForm).then(res => {
          if (res.code === '200') {
            this.$message.success("修改记录成功！")
            this.getEfficiencyRecordList();
            this.updateRecordDialogVisible = false;
          } else {
            this.$message.error("修改记录失败！")
          }
          })
      });
    },

    // //确认修改
    // updateRecordInfo () {
    //   this.$refs.updateRecordFormRef[0].validate(async (valid) => {
    //     if (!valid) return; //验证失败

    //     // 发起修改请求
    //     const { data: res } = await this.$http.put(
    //       "updateEfficiencyRecord",
    //       this.updateRecordForm
    //     );
    //     if (res != "success") return this.$message.error("修改记录失败！");
    //     this.$message.success("修改记录成功！");
    //     this.getEfficiencyRecordList();
    //     //隐藏修改记录信息对话框
    //     this.updateRecordDialogVisible = false;
    //   });
    // },

    // 获取所有问题信息
    getProblemList() {
      this.request.get("/getEffiProblem").then(res => {
        this.problemList = res.data
      })},

    // 获取所有记录信息
        getEfficiencyRecordList() {
      this.request.get("/getEfficiencyRecord").then(res => {
        this.efficiencyRecordList = res.data
        this.updateRecordForm = res.data[0];
        this.getEfficiencyRecordList1();
      })},

    // 获取所有记录信息(包括HeadData)
    getEfficiencyRecordList1() {
      this.request.get("/getEfficiencyRecordList").then(res => {
        this.efficiencyRecordList1 = res.data
      })},

    // async getEfficiencyRecordList () {
    //   const { data: res } = await this.$http.get("getEfficiencyRecordItem"); //get请求方法
    //   this.efficiencyRecordList = res.data;
    //   this.updateRecordForm = res.data[0];
    //   this.getEfficiencyRecordList1();
    // },

    // // 获取所有记录信息(包括HeadData)
    // async getEfficiencyRecordList1 () {
    //   const { data: res } = await this.$http.get("getEfficiencyRecordList"); //get请求方法
    //   // console.log(res);
    //   this.efficiencyRecordList1 = res.data;
    // },

    // async refreshRecord () {
    //   this.getEfficiencyRecordList();
    //   this.$message.success("更新记录成功！");
    // },

    // async statistics () {
    //   // 基于准备好的dom，初始化echarts实例
    //   var chart = document.getElementById('main');
    //   var chartData = echarts.init(chart);

    //   // 绘制图表
    //   this.$http.get('getP').then(function (res) {

    //     chartData.setOption({
    //       title: {
    //         text: '当前产线P值'
    //       },
    //       tooltip: {},
    //       legend: {
    //         data: ['P值']

    //       },
    //       xAxis: {
    //         data: res.data.x
    //       },
    //       yAxis: {},
    //       series: [{
    //         name: 'P值',
    //         type: 'line',
    //         data: res.data.y
    //       }]
    //     });
    //   })
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

  padding-right: 20px;
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
