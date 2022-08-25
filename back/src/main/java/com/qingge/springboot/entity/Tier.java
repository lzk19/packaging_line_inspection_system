package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_tier")
@Data
public class Tier {
    private Integer id;
    private String name;
    private String date;
    private String shift;
    private String line;
    private String t1q1answer;
    private String t1q2answer;
    private String t1q3answer;
    private String t1q4answer;
    private String t2q1answer;
    private String t2q2answer;
    private String t2q3answer;
    private String t2q4answer;
}
