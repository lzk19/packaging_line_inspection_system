package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_efficiency")
@Data
public class Efficiency {
    private Integer id;
    private String name;
    private String date;
    private String shift;
    private String line;
    private String effiq1answer;
    private String effiq2answer;
    private String effiq3answer;
    private String effiq4answer;
}
