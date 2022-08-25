<template >

  <div>
    <h2>欢迎使用包装线长在线巡检系统</h2>
    <h2>请输入姓名并选择日期时间、班次以及线号，确认后提交</h2>

    <el-dialog :visible.sync="updateRecordDialogVisible"
               center
               v-dialogDrag
               :close-on-press-escape="false"
               :show-close="false"
               :close-on-click-modal="false"
               width="580px">
      <!-- 在dialog里添加div然后把div的样式设置成height:60vh;overflow:auto这样 表示其大小为相对视窗大小 -->
      <div style="height: 640px; margin-top: -30px">
        <el-row v-for="(item, index) in handList"
                :key="index"
                :label1="item">
          <el-card style="padding-bottom: 20px">
            <span class="span1">全线通知：<br /></span>
            <el-col class="col1">{{ item.common }}</el-col>
          </el-card>
          <el-card style="margin-top: 30px; padding-bottom: 20px">
            <span class="span1">专线通知：<br /> </span>
            <el-col class="col2">{{ item.special }}</el-col>
          </el-card>
        </el-row>
      </div>

      <span slot="footer"
            class="dialog-footer">
        <el-button type="primary"
                   :disabled="disable"
                   style="width: 100px; height: 38px"
                   @click="updateRecordDialogVisible = false">已阅读 {{ this.second }}</el-button>
      </span>
    </el-dialog>

    <el-form :inline="true"
             :model="addHeaderDataForm"
             ref="addHeaderDataRef"
             :rules="addHeaderDataFormRules">
      <el-form-item prop="name">
        <el-input v-model="addHeaderDataForm.name"
                  placeholder="请输入姓名"
                  clearable
                  style="width: 150px"></el-input>
      </el-form-item>

      <el-form-item prop="date">
        <el-date-picker v-model="addHeaderDataForm.date"
                        type="date"
                        placeholder="请选择日期"
                        style="width: 150px"
                        format="yyyy-MM-dd"
                        value-format="yyyy-MM-dd">>
        </el-date-picker>
      </el-form-item>

      <el-form-item prop="shift">
        <el-select v-model="addHeaderDataForm.shift"
                   placeholder="请选择班次"
                   style="width: 150px">
          <el-option v-for="item in shiftoptions"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>

      <el-form-item prop="line">
        <el-select v-model="addHeaderDataForm.line"
                   placeholder="请选择线号"
                   style="width: 150px">
          <el-option v-for="item in lineoptions"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button @click="addHeaderData"
                   type="info"
                   plain>提交</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="headerDataList"
              border
              style="width: 642px">
      <el-table-column label="姓名"
                       prop="name"
                       width="160px"></el-table-column>
      <el-table-column label="时间"
                       prop="date"
                       width="160px"></el-table-column>
      <el-table-column label="班次"
                       prop="shift"
                       width="160px"></el-table-column>
      <el-table-column label="线号"
                       prop="line"
                       width="160px"></el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name: "timeCount",
  //这个方法是一进入页面就显示数据
  created () {
    // 调用当前的getUserList方法
    this.getHeaderDataItem();
    this.getHandoverList();

    // this.getHeaderDataName();

    // this.load()
  },

  data () {
    return {
      id: '',
      endTime: 0,
      second: 0,
      interval: null,
      disable: true,
      updateRecordDialogVisible: true,
      handList: [],

      headerDataList: [],

      addHeaderDataForm: {
        name: "",
        date: "",
        shift: "",
        line: "",
      },

      addHeaderDataFormRules: {
        name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
        date: [{ required: true, message: "请输入日期", trigger: "blur" }],
        shift: [{ required: true, message: "请输入班次", trigger: "blur" }],
        line: [{ required: true, message: "请输入线号", trigger: "blur" }],
      },

      pickerOptions: {
        disabledDate (time) {
          return time.getTime() > Date.now();
        },
      },
      datevalue: "",

      shiftoptions: [
        {
          value: "白班",
        },
        {
          value: "夜班",
        },
      ],
      shiftvalue: "",

      lineoptions: [
        {
          value: "1号线",
        },
        {
          value: "2号线",
        },
        {
          value: "3号线",
        },
        {
          value: "4号线",
        },
        {
          value: "5号线",
        },
        {
          value: "6号线",
        },
      ],
      linevalue: "",
    };
  },

  props: {
    //倒计时时间
    longTime: {
      type: Number,
      default: 1,
    },
    //弹出框标题
    messageTitle: {
      type: String,
      default: "",
    },
    //弹出框内容
    messageText: {
      type: String,
      default: "",
    },
  },

  mounted () {
    //结束时间
    this.endTime = Date.parse(new Date()) + this.longTime * 1000;
    //开始倒计时
    this.countdown();
  },
  beforeDestroy () {
    //提前结束则销毁倒计时
    clearTimeout(this.interval);
  },


  methods: {

    getHeaderDataItem() {
      this.request.get("/getHeaderData").then(res => {
        this.headerDataList = res.data
      })},

    addHeaderData () {
      this.$refs.addHeaderDataRef.validate(async (valid) => {
        if (!valid) return;
        this.request.post("/addHeaderData", this.addHeaderDataForm).then(res => {
        if (res.code === '200') {
          this.$message.success("提交成功")
          this.getHeaderDataItem()
        } else {
          this.$message.error("提交失败")
        }
      })
      });
    },

    countdown () {
      //计算运行时间
      const end = this.endTime;
      const now = Date.parse(new Date());
      const msec = end - now;
      //计算剩余时间
      this.second = (msec / 1000) % 60;
      const that = this;
      //结束则弹框
      if (msec != 0) {
        this.interval = setTimeout(that.countdown, 1000);
      } else {
        this.disable = false;
      }
    },

    async getHandoverList () {
      this.request.get("/getHandoverRecord").then(res =>{
        this.handList = res.data;
      })
      
    },
  },
};
</script>

<style lang="less" scoped>
.col1 {
  height: 240px;
  // background-color: antiquewhite;
  font-family: Microsoft YaHei;
  font-size: 18px;
  color: #606266;
  padding: 18px;
}

.col2 {
  height: 240px;
  // background-color: antiquewhite;
  font-family: Microsoft YaHei;
  font-size: 18px;
  color: #606266;
  padding: 18px;
}

.span1 {
  font-family: Microsoft YaHei;
  font-size: 25px;
  color: #606266;
}
</style>
