package com.qingge.springboot.controller;

import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.*;
import com.qingge.springboot.mapper.OrdinaryPlateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@RestController
public class OrdinaryPlateController {
    @Resource
    OrdinaryPlateMapper ordinaryPlateMapper;

    @RequestMapping("/addTierRecord")
    public Result addTierRecord(@RequestBody Tier tierRecord) {
        ordinaryPlateMapper.addTierRecord(tierRecord);
        return Result.success();
    }

    @RequestMapping("/getTierRecord")
    public Result getTierRecord() {
        return Result.success(ordinaryPlateMapper.getTierRecord());
    }

    @RequestMapping("/updateTierRecord")
    public Result updateTierRecord(@RequestBody Tier tierRecord){
        ordinaryPlateMapper.updateTierRecord(tierRecord);
        return Result.success();
    }

    @RequestMapping("/getTierRecordList")
    public Result getTierRecordList() {
        return Result.success(ordinaryPlateMapper.getTierRecordList());
    }

    @RequestMapping("/addInspectRecord")
    public Result addInspectRecord(@RequestBody Inspect inspectRecord) {
        ordinaryPlateMapper.addInspectRecord(inspectRecord);
        return Result.success();
    }

    @RequestMapping("/getInspectRecord")
    public Result getInspectRecord() {
        return Result.success(ordinaryPlateMapper.getInspectRecord());
    }

    @RequestMapping("/updateInspectRecord")
    public Result updateInspectRecord(@RequestBody Inspect inspectRecord){
        ordinaryPlateMapper.updateInspectRecord(inspectRecord);
        return Result.success();
    }

    @RequestMapping("/getInspectRecordList")
    public Result getInspectRecordList() {
        return Result.success(ordinaryPlateMapper.getInspectRecordList());
    }

    @RequestMapping("/addEfficiencyRecord")
    public Result addEfficiencyRecord(@RequestBody Efficiency efficiencyRecord) {
        ordinaryPlateMapper.addEfficiencyRecord(efficiencyRecord);
        return Result.success();
    }

    @RequestMapping("/getEfficiencyRecord")
    public Result getEfficiencyRecord() {
        return Result.success(ordinaryPlateMapper.getEfficiencyRecord());
    }

    @RequestMapping("/updateEfficiencyRecord")
    public Result updateEfficiencyRecord(@RequestBody Efficiency efficiencyRecord){
        ordinaryPlateMapper.updateEfficiencyRecord(efficiencyRecord);
        return Result.success();
    }

    @RequestMapping("/getEfficiencyRecordList")
    public Result getEfficiencyRecordList() {
        return Result.success(ordinaryPlateMapper.getEfficiencyRecordList());
    }

    @RequestMapping("/addGuidanceRecord")
    public Result addGuidanceRecord(@RequestBody Guidance guidanceRecord) {
        ordinaryPlateMapper.addGuidanceRecord(guidanceRecord);
        return Result.success();
    }

    @RequestMapping("/getGuidanceRecord")
    public Result getGuidanceRecord() {
        return Result.success(ordinaryPlateMapper.getGuidanceRecord());
    }

    @RequestMapping("/updateGuidanceRecord")
    public Result updateGuidanceRecord(@RequestBody Guidance guidanceRecord){
        ordinaryPlateMapper.updateGuidanceRecord(guidanceRecord);
        return Result.success();
    }

    @RequestMapping("/getGuidanceRecordList")
    public Result getGuidanceRecordList() {
        return Result.success(ordinaryPlateMapper.getGuidanceRecordList());
    }

    @RequestMapping("/addHandoverRecord")
    public Result addHandoverRecord(@RequestBody Handover handover) {
        ordinaryPlateMapper.addHandoverRecord(handover);
        return Result.success();
    }

    @RequestMapping("/getHandoverRecord")
    public Result getHandoverRecord() {
        return Result.success(ordinaryPlateMapper.getHandoverRecord());
    }

    @RequestMapping("/updateHandoverRecord")
    public Result updateHandoverRecord(@RequestBody Handover handover){
        ordinaryPlateMapper.updateHandoverRecord(handover);
        return Result.success();
    }

    @RequestMapping("/getP")
    public Result getP(Efficiency efficiencyRecord) {
        List<String> dates = ordinaryPlateMapper.getEfficiencyRecordDate(efficiencyRecord.getDate());
        List<String> q4 = ordinaryPlateMapper.getEfficiencyRecord4(efficiencyRecord.getEffiq4answer());
        HashMap<String, Object> res = new HashMap<>();
        res.put("x", dates);
        res.put("y", q4);
        return Result.success(res);
    }


}
