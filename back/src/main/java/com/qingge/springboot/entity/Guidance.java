package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_guidance")
@Data
public class Guidance {
    private Integer id;
    private String name;
    private String date;
    private String shift;
    private String line;
    private String gdq1answer;
    private String gdq2answer;
    private String gdq3answer;
}
