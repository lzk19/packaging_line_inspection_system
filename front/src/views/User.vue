<template>
  <div>

    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>员工管理</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card>

      <!-- el-row:gutter设置两个el-col之间的间隙 -->
      <el-row :gutter="25">
        <!-- 搜索区域 -->
        <!-- el-col:span设置列宽 -->
        <el-col :span="8">
          <el-input placeholder="请输入搜索内容"
                    clearable
                    @clear="reset"
                    v-model="username">
            <el-button slot="append"
                       icon="el-icon-search"
                       @click="load">
            </el-button>
          </el-input>

        </el-col>
        
          <el-button type="primary"
                     @click="handleAdd" >添加用户 <i class="el-icon-circle-plus-outline"></i></el-button>

          <el-button type="primary" @click="exp" class="ml-5" style="margin-left:12px">导出 <i class="el-icon-top"></i></el-button>
        
        <el-button type="danger"  style="margin-left:12px" @click="delBatch">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-row>


    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <!-- 把列的type设置成index类型就成为了索引列 -->

        <el-table-column type="index"
                         width="50"
                         align="center">
          <template slot-scope="scope">
            <span>{{
              (pageNum - 1) * pageSize + (scope.$index + 1)
            }}</span>
          </template>
        </el-table-column>

      <el-table-column prop="username" label="用户名" width="120"></el-table-column>
      <el-table-column prop="name" label="姓名" width="120"></el-table-column>
      <el-table-column prop="sex" label="性别" width="80"></el-table-column>
      <el-table-column prop="phone" label="电话"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="address" label="地址"></el-table-column>
      <el-table-column prop="role" label="角色" width="130px" align="center">
        <template slot-scope="scope">
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_ADMIN'">管理员</el-tag>
          <el-tag type="warning" v-if="scope.row.role === 'ROLE_TEACHER'">线长</el-tag>
          <el-tag type="success" v-if="scope.row.role === 'ROLE_STUDENT'">员工</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作"  width="160" align="center">
        <template slot-scope="scope">

          <!-- 修改按钮 -->
            <el-tooltip content="修改员工信息"
                        placement="top"
                        effect="light">
              <el-button type="primary"
                         icon="el-icon-edit"
                         plain
                         round
                         size="mini"
                          @click="handleEdit(scope.row)"></el-button>
            </el-tooltip>
            <!-- 删除按钮 -->
            <el-tooltip content="删除员工"
                        placement="top"
                        effect="light">
              <el-button type="danger"
                         icon="el-icon-delete"
                         round
                         plain
                         size="mini"
                         @click="del(scope.row.id)"></el-button>
            </el-tooltip>

        </template>
      </el-table-column>
    </el-table>
    
      <el-pagination
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          layout="total, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </el-card>

    <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="用户名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="名字">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="性别">
          <el-input v-model="form.sex" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="邮箱">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="地址">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="角色">
          <el-select clearable v-model="form.role" placeholder="请选择角色" style="width: 100%">
            <el-option v-for="item in roles" :key="item.name" :label="item.name" :value="item.flag"></el-option>
          </el-select>
        </el-form-item>
        
        
        
        
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    
  </div>
</template>

<script>
import {serverIp} from "../../public/config";

export default {
  name: "User",
  data() {
    return {
      serverIp: serverIp,
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 7,
      username: "",
      email: "",
      address: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      roles: [],
      vis: false,
      stuVis: false
    }
  },
  created() {
    this.load()
  },
  methods: {
    lookCourse(courses) {
      this.courses = courses
      this.vis = true
    },
    lookStuCourse(stuCourses) {
      this.stuCourses = stuCourses
      this.stuVis = true
    },
    load() {
      this.request.get("/user/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          email: this.email,
          address: this.address,
        }
      }).then(res => {

        this.tableData = res.data.records
        this.total = res.data.total

      })

      this.request.get("/role").then(res => {
        this.roles = res.data
      })
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },

    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },

    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
    },


    async del(id) {

      const confirmResult = await this.$confirm(
        "此操作将永久删除用户，是否继续？",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      ).catch((err) => err); //把结果信息放进了confirmResult中
      if (confirmResult != "confirm") {
        return this.$message.info("已取消删除");
      }
      this.request.delete("/user/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },





    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },


    async delBatch() {
      const confirmResult1 = await this.$confirm(
        "此操作将永久删除用户，是否继续？",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      ).catch((err) => err); //把结果信息放进了confirmResult中
      if (confirmResult1 != "confirm") {
        return this.$message.info("已取消删除");
      }
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/user/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },

    reset() {
      this.username = ""
      this.email = ""
      this.address = ""
      this.load()
    },

    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
    exp() {
      window.open(`http://${serverIp}:9090/user/export`)
    },

  }
}
</script>

<style lang="less" scoped>
.el-table {
  margin-top: 15px;
  font-size: 15px;
}
</style>
