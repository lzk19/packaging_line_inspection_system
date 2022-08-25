//package com.qingge.springboot.service.impl;
//
//import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
//import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
//import com.qingge.springboot.entity.Event;
//import com.qingge.springboot.entity.User;
//import com.qingge.springboot.mapper.EventMapper;
//import com.qingge.springboot.service.IEventService;
//import org.springframework.stereotype.Service;
//
//import javax.annotation.Resource;
//
//@Service
//public class EventServiceImpl extends ServiceImpl<EventMapper, Event> implements IEventService {
//
//    @Resource
//    EventMapper eventMapper;
//
//
//    @Override
//    public Page<Event> findPage(Page<Event> page, String machineName, String eventName) {
//        return eventMapper.findPage(page, machineName, eventName);
//    }
//}
