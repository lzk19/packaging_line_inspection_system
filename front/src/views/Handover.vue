<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检普通板块</el-breadcrumb-item>
      <el-breadcrumb-item>交接内容</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card>
      <el-button type="primary" @click="addRecordDialogVisible = true"
        >新建通知</el-button
      >

      <el-button type="primary" @click="updateRecordDialogVisible = true"
        >修改通知</el-button
      >

      <!-- <el-button type="primary" @click="refreshRecord">更新通知</el-button> -->

      <el-button type="primary">查看历史通知</el-button>

      <el-button type="primary">导出</el-button>
    </el-card>

    <el-card style="height: 210px">
      <!-- Tier1会议填写表格 stripe:斑马线格式-->
      <el-table :data="tableData1" stripe style="width: 50%">
        <el-table-column prop="problem1" width="600" label="交接内容">
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog
      title="新建通知"
      :visible.sync="addRecordDialogVisible"
      width="40%"
      @close="addRecordDialogClosed"
      v-dialogDrag
    >
      <el-card>
        <el-form :model="addRecordForm" ref="addRecordFormRef">
          <el-form-item>
            <span class="span1">通用交接内容</span>
          </el-form-item>
          <el-form-item style="margin-top: -20px" prop="common">
            <el-input
              type="textarea"
              :rows="4"
              style="width: 480px"
              :clearable="true"
              placeholder="请输入通用交接内容"
              v-model="addRecordForm.common"
            ></el-input>
          </el-form-item>

          <el-form-item>
            <span class="span1">专线交接内容</span>
          </el-form-item>
          <el-form-item style="margin-top: -20px" prop="special">
            <el-input
              type="textarea"
              :rows="4"
              style="width: 480px"
              :clearable="true"
              placeholder="请输入通用交接内容"
              v-model="addRecordForm.special"
            ></el-input>
          </el-form-item>
        </el-form>
      </el-card>

      <!-- 表单底部按钮 -->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addRecordDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="addRecord">确定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="修改通知"
      :visible.sync="updateRecordDialogVisible"
      width="40%"
      @close="updateRecordDialogClosed"
      v-dialogDrag
    >
      <el-card>
        <el-form
          :model="updateRecordForm"
          ref="updateRecordFormRef"
          v-for="(item, index) in handoverRecordList"
          :key="index"
          :label2="item"
        >
          <el-form-item>
            <span class="span1">通用交接内容</span>
          </el-form-item>
          <el-form-item style="margin-top: -20px" prop="common">
            <el-input
              type="textarea"
              :rows="4"
              style="width: 480px"
              :clearable="true"
              placeholder="请输入通用交接内容"
              v-model="updateRecordForm.common"
            ></el-input>
          </el-form-item>

          <el-form-item>
            <span class="span1">专线交接内容</span>
          </el-form-item>
          <el-form-item style="margin-top: -20px" prop="special">
            <el-input
              type="textarea"
              :rows="4"
              style="width: 480px"
              :clearable="true"
              placeholder="请输入通用交接内容"
              v-model="updateRecordForm.special"
            ></el-input>
          </el-form-item>
        </el-form>
      </el-card>

      <!-- 表单底部按钮 -->
      <span slot="footer" class="dialog-footer">
        <el-button @click="updateRecordDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updateRecordInfo">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  created() {
    // 调用当前的getUserList方法
    this.getHandoverRecordList();
  },
  data() {
    return {
      addRecordForm: {
        common: "",
        special: "",
      },
      getHeaderDataForm: {},

      addRecordDialogVisible: false, //添加记录的对话框

      updateRecordDialogVisible: false, //修改记录的对话框

      updateRecordForm: [],

      handoverRecordList: [], //记录列表

      tableData1: [
        {
          problem1: "问题1:留给下一班次的重要交接内容 (专线)",
        },
        {
          problem1: "问题2:留给下一班次的重要交接内容 (通用)",
        },
      ],
    };
  },
  methods: {

    addRecord () {
      this.$refs.addRecordFormRef.validate(async (valid) => {
        if (!valid) return;
        this.request.post("/addHandoverRecord", this.addRecordForm).then(res => {
        if (res.code === '200') {
          this.$message.success("添加记录成功！")
          this.getHandoverRecordList();
          this.addRecordDialogVisible = false;
        } else {
          this.$message.error("添加记录失败！")
        }
      })
      });
    },

    // addRecord() {
    //   this.$refs.addRecordFormRef.validate(async (valid) => {
    //     if (!valid) return;
    //     const { data: res } = await this.$http.post(
    //       "addHandoverRecord",
    //       this.addRecordForm
    //     );
    //     if (res != "success") {
    //       return this.$message.error("新建通知失败！");
    //     }
    //     this.$message.success("新建通知成功！"); //提示信息
    //     this.getHandoverRecordList();
    //     this.addRecordDialogVisible = false;
    //   });
    // },

    addRecordDialogClosed() {
      this.$refs.addRecordFormRef.resetFields();
    },

    updateRecordDialogClosed() {
      this.updateRecordDialogVisible = false; //重置信息
      this.getHandoverRecordList();
    },

        //确认修改
    updateRecordInfo () {
      this.$refs.updateRecordFormRef[0].validate(async (valid) => {
        if (!valid) return; //验证失败

        this.request.post("/updateHandoverRecord", this.updateRecordForm).then(res => {
          if (res.code === '200') {
            this.$message.success("修改记录成功！")
            this.getHandoverRecordList();
            this.updateRecordDialogVisible = false;
          } else {
            this.$message.error("修改记录失败！")
          }
          })
      });
    },

    // updateRecordInfo() {
    //   this.$refs.updateRecordFormRef[0].validate(async (valid) => {
    //     if (!valid) return; //验证失败

    //     // 发起修改请求
    //     const { data: res } = await this.$http.put(
    //       "updateHandoverRecord",
    //       this.updateRecordForm
    //     );
    //     if (res != "success") return this.$message.error("修改通知失败！");
    //     this.$message.success("修改通知成功！");
    //     this.getHandoverRecordList();
    //     //隐藏修改记录信息对话框
    //     this.updateRecordDialogVisible = false;
    //   });
    // },

    // 获取所有记录信息
    getHandoverRecordList() {
      this.request.get("/getHandoverRecord").then(res => {
        this.handoverRecordList = res.data
        this.updateRecordForm = res.data[0];
      })},

    // async getHandoverRecordList() {
    //   const { data: res } = await this.$http.get("getHandoverRecord"); //get请求方法
    //   this.handoverRecordList = res.data;
    //   this.updateRecordForm = res.data[0];
    // },

    async refreshRecord() {
      this.getHandoverRecordList();
      this.$message.success("更新通知成功！");
    },
  },
};
</script>

<style lang="less" scoped>
.span1 {
  color: #909399;
  font-size: 15px;
  font-family: Microsoft YaHei;
}
</style>
