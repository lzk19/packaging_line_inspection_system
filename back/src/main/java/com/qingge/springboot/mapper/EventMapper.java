package com.qingge.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.entity.Event;
import com.qingge.springboot.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.awt.*;
import java.util.List;

@Repository
public interface EventMapper extends BaseMapper<Event> {
//    Page<Event> findPage(Page<Event> page, @Param("machineName") String machineName, @Param("eventName") String eventName);
    //getAllEvent获取所有事件 pageStart每一页存放的最大的配置
    List<Event> getAllEvent(@Param("eventName") String eventName, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    //getEventCounts获取事件个数
    int getEventCounts(@Param("eventName") String eventName);

    //添加事件
    int addEvent(Event event);


    //查询需要修改的事件
    Event getUpdateEvent(int id);

    //修改事件信息
    int updateEvent(Event event);

    //关闭事件
    int deleteEvent(int id);

    int addUrl(String url);
}
