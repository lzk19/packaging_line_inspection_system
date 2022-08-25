package com.qingge.springboot.entity;

import lombok.Data;

//分页所需的参数都封装到实体EventQueryInfo中
@Data
public class EventQueryInfo {
    private String query; //查询信息 username
    private Integer pageNum = 1; //当前页
    private Integer pageSize = 1; //每页最大数
}
