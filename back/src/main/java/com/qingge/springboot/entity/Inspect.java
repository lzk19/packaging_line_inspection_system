package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_inspect")
@Data
public class Inspect {
    private Integer id;
    private String name;
    private String date;
    private String shift;
    private String line;
    private String sfq1answer;
    private String sfq2answer;
    private String sfq3answer;
    private String qlq1answer;
    private String qlq2answer;
    private String qlq3answer;
    private String qlq4answer;
    private String qlq5answer;
    private String qlq6answer;
}
