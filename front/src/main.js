import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "./plugins/element.js";
import './assets/gloable.css'
import request from "@/utils/request";

// main.js全局注册
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
// use
Vue.use(mavonEditor)


//导入dialog.js实现dialog拖拽
import "./utils/dialog.js";

import "./plugins/charts.js";

Vue.config.productionTip = false


Vue.prototype.request=request

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
