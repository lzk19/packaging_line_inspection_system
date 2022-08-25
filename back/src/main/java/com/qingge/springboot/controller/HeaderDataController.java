package com.qingge.springboot.controller;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.mapper.HeaderDataMapper;
//import com.qingge.springboot.service.IHeaderDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.common.Result;

import com.qingge.springboot.entity.HeaderData;

import org.springframework.web.bind.annotation.RestController;


@RestController
public class HeaderDataController {

    @Resource
    HeaderDataMapper headerDataMapper;

    @GetMapping("/getHeaderData")
    public Result findOne() {
        return Result.success(headerDataMapper.getHeaderData());
    }

    @RequestMapping("/addHeaderData")
    public Result insertTo(@RequestBody HeaderData headerData){
        headerDataMapper.addHeaderData(headerData);
        return Result.success();
    }



}

