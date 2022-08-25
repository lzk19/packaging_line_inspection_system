package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_handover")
@Data
public class Handover {
    private Integer id;
    private String name;
    private String date;
    private String shift;
    private String line;
    private String common;
    private String special;
}
