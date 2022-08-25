package com.qingge.springboot.mapper;

import com.baomidou.mybatisplus.extension.service.IService;
import com.qingge.springboot.entity.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrdinaryPlateMapper extends IService {
    //添加Tier记录
    int addTierRecord(Tier tierRecord);

    //获取Tier记录
    List<Tier> getTierRecord();

    //修改Tier记录信息
    int updateTierRecord(Tier tierRecord);

    //    获取Tier记录信息(包括头信息)
    List<Tier> getTierRecordList();

    //添加巡检记录
    int addInspectRecord(Inspect inspectRecord);

    //    获取巡检记录信息
    List<Inspect> getInspectRecord();

    //修改巡检记录信息
    int updateInspectRecord(Inspect inspectRecord);

    //    获取巡检记录信息(包括头信息)
    List<Inspect> getInspectRecordList();

    //添加效率评价记录
    int addEfficiencyRecord(Efficiency efficiencyRecord);

    //获取效率评价记录
    List<Efficiency> getEfficiencyRecord();

    //修改效率评价记录信息
    int updateEfficiencyRecord(Efficiency efficiencyRecord);

    //    获取效率评价记录信息(包括头信息)
    List<Efficiency> getEfficiencyRecordList();

    //添加指导抽查记录信息
    int addGuidanceRecord(Guidance guidanceRecord);

    //获取指导抽查记录
    List<Guidance> getGuidanceRecord();

    //修改指导抽查记录信息
    int updateGuidanceRecord(Guidance guidanceRecord);

    //    获取指导抽查记录信息(包括头信息)
    List<Guidance> getGuidanceRecordList();


    //    添加交接内容信息
    int addHandoverRecord(Handover handover);

    //    获取交接内容信息
    List<Handover> getHandoverRecord();

    //    修改交接内容信息
    int updateHandoverRecord(Handover handover);

    List<String> getEfficiencyRecordDate(@Param("date") String date);

    List<String> getEfficiencyRecord4(@Param("effiq4answer") String effiq4answer);


}
