<template>



  <div class="main1">

      <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>角色管理</el-breadcrumb-item>
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
                    v-model="name">
            <el-button slot="append"
                       icon="el-icon-search"
                       @click="load">
            </el-button>
          </el-input>

        </el-col>
        
          <el-button type="primary"
                     @click="handleAdd" >添加角色 <i class="el-icon-circle-plus-outline"></i></el-button>

          <el-button type="primary" @click="exp" class="ml-5" style="margin-left:12px">导出 <i class="el-icon-top"></i></el-button>
        
        <el-button type="danger"  style="margin-left:12px" @click="delBatch">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-row>


    <el-table :data="tableData" border stripe   @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column type="index"
                         width="50"
                         align="center">
          <template slot-scope="scope">
            <span>{{
              (pageNum - 1) * pageSize + (scope.$index + 1)
            }}</span>
          </template>
        </el-table-column>
      <el-table-column prop="name" label="名称" ></el-table-column>
      <el-table-column prop="flag" label="唯一标识" ></el-table-column>
      <el-table-column prop="description" label="描述" ></el-table-column>

      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">

          <!-- 修改按钮 -->
            <el-tooltip content="分配菜单"
                        placement="top"
                        effect="light">
              <el-button type="success"
                         icon="el-icon-setting"
                         plain
                         round 
                         size="mini"
                          @click="selectMenu(scope.row)"></el-button>
            </el-tooltip>

          <!-- 修改按钮 -->
            <el-tooltip content="编辑"
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
            <el-tooltip content="删除"
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

    <el-dialog title="角色信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="唯一标识">
          <el-input v-model="form.flag" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="菜单分配" :visible.sync="menuDialogVis" width="30%">
      <el-tree
          :props="props"
          :data="menuData"
          show-checkbox
          node-key="id"
          ref="tree"
          :default-expanded-keys="expends"
          :default-checked-keys="checks">
         <span class="custom-tree-node" slot-scope="{ node, data }">
            <span><i :class="data.icon"></i> {{ data.name }}</span>
         </span>
      </el-tree>
      <div slot="footer" class="dialog-footer">
        <el-button @click="menuDialogVis = false">取 消</el-button>
        <el-button type="primary" @click="saveRoleMenu">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {serverIp} from "../../public/config";
export default {
  name: "Role",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      name: "",
      form: {},
      dialogFormVisible: false,
      menuDialogVis: false,
      multipleSelection: [],
      menuData: [],
      props: {
        label: 'name',
      },
      expends: [],
      checks: [],
      roleId: 0,
      roleFlag: '',
      ids: []
    }
  },
  created() {
    this.load()
  },
  methods: {

    collapse() {
      // this.$parent.$parent.$parent.$parent.collapse()  // 通过4个 $parent 找到父组件，从而调用其折叠方法
      this.$emit("asideCollapse")
    },

    load() {
      this.request.get("/role/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/menu/ids").then(r => {
        this.ids = r.data
      })

    },
    save() {
      this.request.post("/role", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    saveRoleMenu() {
      this.request.post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys()).then(res => {
        if (res.code === '200') {
          this.$message.success("绑定成功")
          this.menuDialogVis = false

          // 操作管理员角色后需要重新登录
          if (this.roleFlag === 'ROLE_ADMIN') {
            this.$store.commit("logout")
          }

        } else {
          this.$message.error(res.msg)
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
      this.request.delete("/role/" + id).then(res => {
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
      this.request.post("/role/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },
    
    reset() {
      this.name = ""
      this.load()
    },

    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },

    exp() {
      window.open(`http://${serverIp}:9090/role/export`)
    },

    async selectMenu(role) {
      this.roleId = role.id
      this.roleFlag = role.flag

      // 请求菜单数据
      this.request.get("/menu").then(res => {
        this.menuData = res.data

        // 把后台返回的菜单数据处理成 id数组
        this.expends = this.menuData.map(v => v.id)
      })

      this.request.get("/role/roleMenu/" + this.roleId).then(res => {
        this.checks = res.data
        this.ids.forEach(id => {
          if (!this.checks.includes(id)) {
            // 可能会报错：Uncaught (in promise) TypeError: Cannot read properties of undefined (reading 'setChecked')
            this.$nextTick(() => {
              this.$refs.tree.setChecked(id, false)
            })
          }
        })
        this.menuDialogVis = true
      })
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
