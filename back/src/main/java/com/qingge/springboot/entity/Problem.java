package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_problem")
@Data
public class Problem {
    private Integer id;
    private String problem;
}
