<template>
  <div>
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>巡检事件板块</el-breadcrumb-item>
      <el-breadcrumb-item>主要设备问题</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card>
      <el-button type="primary" @click="addEventDialogVisible = true"
        >新建事件</el-button>
      <el-button type="primary"
                 @click="addEventDialogVisible = true">修改事件</el-button>
      <el-button type="primary" @click="addEventDialogVisible = true"
        >合并事件</el-button
      >
      <el-table :data="eventList" border stripe>
        <!-- 把列的type设置成index类型就成为了索引列 -->
        <el-table-column type="index"
                         width="50"
                         align="center">
          <template slot-scope="scope">
            <span>{{
              (eventQueryInfo.pageNum - 1) * eventQueryInfo.pageSize + (scope.$index + 1)
            }}</span>
          </template>
        </el-table-column>

        <el-table-column label="线号" prop="line"> </el-table-column>
        <el-table-column label="日期" prop="date"> </el-table-column>

        <el-table-column label="机器名" prop="machineName"> </el-table-column>

        <el-table-column label="事件名" prop="eventName"> </el-table-column>
        <el-table-column label="事件类型" prop="eventType"> </el-table-column>
        <el-table-column label="附件" prop="fileName"> </el-table-column>
        <el-table-column label="事件操作" width="180px">
          <!-- scope里封存了该行用户的所有信息 -->
          <template slot-scope="scope">
            <!-- 填写事件内容按钮 -->

            <el-tooltip content="填写事件内容" placement="top" effect="light">
              <el-button
                type="primary"
                icon="el-icon-edit"
                plain
                round
                size="mini"
                @click="showUpdateDialog(scope.row.id)"
              ></el-button>
            </el-tooltip>

            <el-tooltip content="下载附件" placement="top" effect="light">
              <el-button
                type="success"
                icon="el-icon-download"
                plain
                round
                size="mini"
                @click="downloadFile(scope.row.url)"
              ></el-button>
            </el-tooltip>

            <!-- 事件关闭按钮 -->
            <el-tooltip content="关闭事件" placement="top" effect="light">
              <el-button
                type="danger"
                icon="el-icon-delete"
                round
                plain
                size="mini"
                @click="closeEvent(scope.row.id)"
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!-- element分页组件 没有设置每页最大变化数 current-page：当前页 page-size表示每页最大数据条数 total表示总数据数-->
      <!-- 分页 -->
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page.sync="eventQueryInfo.pageNum"
        :page-size="eventQueryInfo.pageSize"
        layout="total, prev, pager, next,jumper"
        :total="total"
      >
      </el-pagination>
    </el-card>

    <!-- 新增事件区域 visible:表示是否显示对话框  @close关闭tag时触发的事件-->
    <el-dialog
      title="添加事件"
      :visible.sync="addEventDialogVisible"
      width="40%"
      @close="addEventDialogClosed"
      v-dialogDrag
    >
      <!--red:校验规则的内容 存放在addFormRef下 -->
      <!-- 添加用户对话框里的表单内容 -->
      <el-form
        :model="addEventForm"
        :rules="addEventFormRules"
        ref="addEventFormRef"
        label-width="80px"
      >
        <!-- 机器名称 -->
        <el-form-item label="线号" prop="line">
          <el-input v-model="addEventForm.line"></el-input>
        </el-form-item>
        <el-form-item label="日期" prop="date">
          <el-input v-model="addEventForm.date"></el-input>
        </el-form-item>
        <el-form-item label="机器名称" prop="machineName">
          <el-input v-model="addEventForm.machineName"></el-input>
        </el-form-item>
        <!-- 事件名称 -->
        <el-form-item label="事件名称" prop="eventName">
          <el-input v-model="addEventForm.eventName"></el-input>
        </el-form-item>
      </el-form>
      <!-- 表单底部按钮 -->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addEventDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="addEvent">确定</el-button>
      </span>
    </el-dialog>

    <!-- 填写事件内容的对话框 -->
    <el-dialog
      title="填写事件内容"
      :visible.sync="updateDialogVisible"
      width="42%"
      @close="updateDialogClosed"
      v-dialogDrag
    >
      <!--ref:校验规则的内容 updateForm -->
      <!-- 填写事件内容对话框里的表单内容 -->
      <el-form
        :model="updateForm"
        :rules="updateFormRules"
        ref="updateFormRef"
        label-width="70px"
      >
        <!-- 类型 -->
        <el-form-item label="类型" prop="eventType">
          <el-select
            v-model="updateForm.eventType"
            placeholder="请选择事件类型"
            style="width: 160px"
          >
            <el-option
              v-for="item in typeOptions"
              :key="item.value"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <!-- 描述 -->
        <el-form-item label="描述" prop="describe1">
          <el-input type="textarea" v-model="updateForm.describe1"></el-input>
        </el-form-item>
        <!-- 发生点 -->
        <el-form-item label="地点" prop="happenPlace">
          <el-input type="textarea" v-model="updateForm.happenPlace"></el-input>
        </el-form-item>
        <!-- 原因 -->
        <el-form-item label="原因" prop="reason">
          <el-input type="textarea" v-model="updateForm.reason"></el-input>
        </el-form-item>
        <!-- 问题缺陷 -->
        <el-form-item label="缺陷" prop="problemDefect">
          <el-input
            type="textarea"
            v-model="updateForm.problemDefect"
          ></el-input>
        </el-form-item>
        <!-- 行动 -->
        <el-form-item label="行动" prop="actions">
          <el-input type="textarea" v-model="updateForm.actions"></el-input>
        </el-form-item>
        <!-- 跟踪 -->
        <el-form-item label="跟踪" prop="tracks">
          <el-input type="textarea" v-model="updateForm.tracks"></el-input>
        </el-form-item>

        <!-- 上传文件 -->

        <el-form-item>
          <el-upload
            :action="'http://localhost:9090/file/uploadFile'"
            :on-success="handleFileUploadSuccess"
            ref="upload"
          >
            <el-button type="success" class="upload">上传附件</el-button>
          </el-upload>
        </el-form-item>
      </el-form>
      <!-- 表单底部按钮 -->
      <span slot="footer" class="dialog-footer">
        <el-button @click="updateDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updateEventInfo">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  //这个方法是一进入页面就显示数据
  created() {
    // 调用当前的getUserList方法
    this.getEventList();
  },
  data() {
    return {
      url: "",

      typeOptions: [
        {
          value: "操作",
        },
        {
          value: "设备",
        },
        {
          value: "来源",
        },
        {
          value: "方法",
        },
        {
          value: "环境",
        },
      ],
      typeValue: "",

      addEventDialogVisible: false, //添加事件的对话框


      addEventForm: {
        line: "",
        date: "",
        machineName: "",
        eventName: "",
      },

      eventList: [], //事件列表

      total: 0, //总记录数

      eventQueryInfo: {
        query: "", //查询信息
        pageNum: 1, //当前页
        pageSize: 4, //每页最大数
      },
      addEventFormRules: {
        line: [{ required: true, message: "请输入线号", trigger: "blur" }],
        date: [{ required: true, message: "请输入日期", trigger: "blur" }],
        machineName: [
          { required: true, message: "请输入机器名称", trigger: "blur" },
        ],
        eventName: [
          { required: true, message: "请输入事件名称", trigger: "blur" },
        ],
      },

      updateFormRules: {
        describe1: [{ message: "请输入事件描述", trigger: "blur" }],
        happenPlace: [{ message: "请输入发生点", trigger: "blur" }],
        reason: [{ message: "请输入原因", trigger: "blur" }],
        problemDefect: [{ message: "请输入问题缺陷", trigger: "blur" }],
        actions: [{ message: "请输入行动", trigger: "blur" }],
        tracks: [{ message: "请输入跟踪", trigger: "blur" }],
      },

      //修改用户信息
      updateForm: {},
      //显示隐藏修改用户栏对话框
      updateDialogVisible: false,
    };
  },
  methods: {

    

    //上传附件
    handleFileUploadSuccess(res) {
      this.updateForm.fileName = res.name;
      this.updateForm.url = res.url;
      this.$message.success("上传附件成功！");
      // console.log(this.updateForm);
      console.log(res);
    },

    //下载附件
    downloadFile(url) {
      window.open(url);
    },

    async getEventList() {
      const { data: res } = await this.request.get("getEventList", {
        params: this.eventQueryInfo,
      }); //get请求方法
      this.eventList = res.data;
      this.total = res.numbers;
    },
    
    addEvent () {
      this.$refs.addEventFormRef.validate(async (valid) => {
        if (!valid) return;
        this.request.post("/addEvent", this.addEventForm).then(res => {
        if (res.code === '200') {
          this.$message.success("新建事件成功！")
          this.getEventList();
          this.addEventDialogVisible = false;
        } else {
          this.$message.error("新建事件失败！")
        }
      })
      });
    },

    addEventDialogClosed() {
      this.$refs.addEventFormRef.resetFields();
    },

    //pageNum的触发动作
    handleCurrentChange(newPage) {
      this.eventQueryInfo.pageNum = newPage;
      this.getEventList();
    },

    //显示修改用户信息的对话框
    async showUpdateDialog(id) {
      const { data: res } = await this.request.get("getUpdateEvent?id=" + id);
      this.updateForm = res; //查询出用户信息并反填回修改表单
      this.updateDialogVisible = true; //开启编辑对话框
    },

    //关闭窗口
    updateDialogClosed() {
      this.$refs.updateFormRef.resetFields(); //重置信息
    },

    //确认修改
    updateEventInfo() {
      // this.$refs.updateFormRef.validate(async (valid) => {
      //   if (!valid) return; //验证失败

        this.request.post("/updateEvent", this.updateForm).then(res => {
          if (res.code === '200') {
            this.$message.success("完善事件内容成功！")
            this.$refs["upload"].clearFiles();
            this.getEventList();
            this.updateDialogVisible = false;
          } else {
            this.$message.error("完善事件内容失败！")
          }
          })
      // });
    },

    async closeEvent(id) {
      this.request.get("/getUpdateEvent?id="+ id).then(async res1=>{
        this.updateForm = res1;
        // console.log(this.updateForm);

        if (
        this.updateForm.data.describe1 == "" ||
        this.updateForm.data.describe1 == undefined ||
        this.updateForm.data.eventType == "" ||
        this.updateForm.data.eventType == undefined ||
        this.updateForm.data.happenPlace == "" ||
        this.updateForm.data.happenPlace == undefined ||
        this.updateForm.data.reason == "" ||
        this.updateForm.data.reason == undefined ||
        this.updateForm.data.problemDefect == "" ||
        this.updateForm.data.problemDefect == undefined ||
        this.updateForm.data.actions == "" ||
        this.updateForm.data.actions == undefined ||
        this.updateForm.data.tracks == "" ||
        this.updateForm.data.tracks == undefined
      ) {
        return this.$message.error("请先完善事件内容");
      } else {
        const confirmResult = await this.$confirm(
          "此操作将关闭事件，是否继续？",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          }
        ).catch((err) => err); //把结果信息放进了confirmResult中
        if (confirmResult != "confirm") {
          return this.$message.info("已取消关闭");
        }

        this.request.delete("/deleteEvent?id=" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.getEventList()
        } else {
          this.$message.error("删除失败")
        }
      })
      }

      })
    },
  },
};
</script>

<style lang="less" scoped>
.el-table {
  margin-top: 15px;
  font-size: 15px;
}

.upload {
  width: 150px;
}
</style>
