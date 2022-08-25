package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("sys_event")
@Data
public class Event {
    private Integer id;
    private String date;
    private String line;
    private String machineName;
    private String eventName;
    private String eventType;
    private String describe1;
    private String happenPlace;
    private String reason;
    private String problemDefect;
    private String actions;
    private String tracks;
    private String isCloseEvent;
    private String fileName;
    private String url;

}
