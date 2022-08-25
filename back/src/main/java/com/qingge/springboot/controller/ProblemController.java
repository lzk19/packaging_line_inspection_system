package com.qingge.springboot.controller;

import com.qingge.springboot.common.Result;
import com.qingge.springboot.mapper.ProblemMapper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class ProblemController {

    @Resource
    ProblemMapper problemMapper;

    @RequestMapping("/getTier1Problem")
    public Result getTier1Problem() {
        return Result.success(problemMapper.getTier1Problem());
    }

    @RequestMapping("/getTier2Problem")
    public Result getTier2Problem() {
        return Result.success(problemMapper.getTier2Problem());
    }

    @RequestMapping("/getInspect1Problem")
    public Result getInspect1Problem() {
        return Result.success(problemMapper.getInspect1Problem());
    }

    @RequestMapping("/getInspect2Problem")
    public Result getInspect2Problem() {
        return Result.success(problemMapper.getInspect2Problem());
    }

    @RequestMapping("/getEffiProblem")
    public Result getEffiProblem() {
        return Result.success(problemMapper.getEffiProblem());
    }

    @RequestMapping("/getGuiProblem")
    public Result getGuiProblem() {
        return Result.success(problemMapper.getGuiProblem());
    }
}
