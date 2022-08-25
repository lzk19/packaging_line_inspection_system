package com.qingge.springboot.mapper;

import com.qingge.springboot.entity.Problem;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProblemMapper {

    List<Problem> getTier1Problem();

    List<Problem> getTier2Problem();

    List<Problem> getInspect1Problem();

    List<Problem> getInspect2Problem();

    List<Problem> getEffiProblem();

    List<Problem> getGuiProblem();
}
