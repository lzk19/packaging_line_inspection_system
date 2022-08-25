package com.qingge.springboot.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Event;
import com.qingge.springboot.entity.EventQueryInfo;
import com.qingge.springboot.mapper.EventMapper;
//import com.qingge.springboot.service.IEventService;
import com.qingge.springboot.service.IUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@RestController
//@RequestMapping("/event")
public class EventController {
//    @Resource
//    private IEventService eventService;

//    @RequestMapping("/page")
//    public Result getEvent(@RequestParam Integer pageNum,
//                           @RequestParam Integer pageSize,
//                           @RequestParam(defaultValue = "") String machineName,
//                           @RequestParam(defaultValue = "") String eventName){
//        return Result.success(eventService.findPage(new Page<>(pageNum, pageSize), machineName,eventName));
//
//    }

    @Resource
    EventMapper eventMapper;

    @RequestMapping("getEventList")
    public Result getEventList(EventQueryInfo eventQueryInfo) {
        //获取最大列表数和当前编号
        int numb = eventMapper.getEventCounts("%" + eventQueryInfo.getQuery() + "%");
        int pageStart = (eventQueryInfo.getPageNum() - 1) * eventQueryInfo.getPageSize();
        List<Event> events = eventMapper.getAllEvent("%" + eventQueryInfo.getQuery() + "%", pageStart, eventQueryInfo.getPageSize());
        HashMap<String, Object> res = new HashMap<>();
        res.put("numbers", numb);
        res.put("data", events);
        return Result.success(res);
    }

    @RequestMapping("addEvent")
    public Result addEvent(@RequestBody Event event){
        eventMapper.addEvent(event);
        return Result.success();
    }

    @RequestMapping("/getUpdateEvent")
    public Result getUpdateEvent(int id) {
        return Result.success(eventMapper.getUpdateEvent(id));
    }

    @RequestMapping("/updateEvent")
    public Result updateEvent(@RequestBody Event event) {
        eventMapper.updateEvent(event);
        return Result.success();
    }

    @RequestMapping("/deleteEvent")
    public Result deleteEvent(int id) {
        eventMapper.deleteEvent(id);
        return Result.success();
    }

    @RequestMapping("/addUrl")
    public Result addEvent(@RequestBody String url) {
        eventMapper.addUrl(url);
        return Result.success();
    }
}
