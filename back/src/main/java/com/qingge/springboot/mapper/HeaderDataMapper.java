package com.qingge.springboot.mapper;

import com.qingge.springboot.entity.HeaderData;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.qingge.springboot.entity.Menu;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface HeaderDataMapper extends BaseMapper<HeaderData> {

    @Select("select * from sys_headerData order by id desc limit 1")
    List<HeaderData> getHeaderData();

    @Insert("insert into sys_headerData (name, date, shift, line) VALUE (#{name},#{date},#{shift},#{line})")
    int addHeaderData(HeaderData headerData);

}
